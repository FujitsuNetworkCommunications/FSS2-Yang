#!/bin/bash 
#
# Fujitsu T600 validation script.
#
# Standard Deviations are not checked as they require imports not available in their context.
# 
# This validation must be run on a subset of releases as it can take a considerable amount-
# of time to validate all releases.
#
# NOTE: Make sure to have pyang installed locally.
# 
#
set -xe
product=T600-OC
product_dir=FSS2-API-Yang/${product}
# append product version to versions
versions="1.1"

yang_compile() {
    yang_dir=$1
    version_onward_path=${yang_dir##T600-OC/}
    version=${version_onward_path%%/yang}
    return_val=0
    cd $yang_dir
    yang_modpath_orig=$YANG_MODPATH
    export YANG_MODPATH=$yang_dir:$yang_dir/standards:$yang_dir/third_party
    # get all the yang files to this directory 
    for fname in *.yang; do
        if [ "$fname" != ${fname#*"openconfig"} ] ; then
            echo "ignoring $fname"
            continue
        elif [ "$fname" != ${fname#*"ietf"} ]; then
            echo "ignoring $fname"
            continue
        else
            pyang --lax-quote-checks --lax-xpath-checks $fname 2>&1
        fi
        if [ "$?" != "0" ]; then
            echo "Error in $fname"
            return_val=1
        fi
    done

    if [ "$return_val" != "0" ]; then
        echo "Failed to compile $product-$version yang"
        exit 1
    else
        echo "Successfully compiled $product-$version yang files"
    fi

    export YANG_MODPATH=$yang_modpath_orig
}

if [ -e $product_dir ]; then
    cd $product_dir 
fi

cwd=`pwd`
declare -a process_ids
for dir in $versions; do
    echo "$cwd/$dir/yang"
    (yang_compile "$cwd/$dir/yang") &
    process_ids+=("$!")
done

# wait for all the processes to complete
for process_id in $process_ids; do
    wait $process_id || exit 1
done

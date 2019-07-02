#!/bin/bash
#
# Main validation script to invoke all the product specific scritps
#
#
set -xe
declare -a yang_validatation_scripts=(
    "./FSS2-API-Yang/T100/yang-compile.sh"
    "./FSS2-API-Yang/T400/yang-compile.sh"
    "./FSS2-API-Yang/T600/yang-compile.sh"
    "./FSS2-API-Yang/T600-OC/yang-compile.sh"
)

declare -a process_ids

for validation_script in ${yang_validatation_scripts[@]}; do
    printf "\n~~~\nRunning $validation_script\n~~~\n"
    ($validation_script) &
    process_ids+=("$!")
done

process_ids_len=${#process_ids[@]}
for (( i=0; i<${process_ids_len}; i++ )); do
    wait ${process_id[$i]} || exit 1
    printf "\n~~~\n${yang_validatation_scripts[$i]} is done.\n~~~\n"
done

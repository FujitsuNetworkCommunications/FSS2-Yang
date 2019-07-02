# FSS2 API Yang

![FSS2 Yang](http://www.fujitsu.com/global/resources/design/stylesheets/images/css_images/fujitsu/symbolmark.gif)

Getting started
---
This repository contains FSS2 Yang models that highlight the capabilities of Fujitsu's 1FINITY Network Elements. 

The repository is structured as follows:
```
|-- FSS2-API-Yang
|   |-- Product
|   |   -- Product_version
|   |       -- yang
|   |           |-- docs
|   |           |-- standards
|   |           |-- third_party

Note: Each product includes its own yang validation script. The scripts can be run individually to validate the yang models for each product. The master validation script can be run to check yang models for all the products.

cd FSS-API-Yang/product
# Change the release/version to appropriately reflect on the releases to be tested.
vi yang-compile.sh
bash ./yang-compile

# OR 
# Run the master checker
# cd into FSS2-Yang and run the master validation script
# NOTE: Please ensure the correct versions to validate are included in the individual validation scripts.
bash yang-validate.sh
```

License
----
This project is licensed under the [Apache 2.0](https://github.com/FujitsuNetworkCommunications/FSS2-Yang/blob/master/LICENSE) License - see the LICENSE file for details


## Maintainers 

Suraj Bennur [@bennfnc](https://github.com/orgs/FujitsuNetworkCommunications/people/bennfnc)

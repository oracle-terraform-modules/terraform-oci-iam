# Oracle Cloud Infrastructure Terraform Modules for Identity and Access Management

This module contains a collection of submodules that simplify the managment of Identity and Access Management (IAM) resources such as compartments, users, groups, and dynamic groups for Oracle Cloud Infrastructure. For more information about IAM, see [Overview of IAM](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/overview.htm).

## Prerequisites

This module requires Terraform 0.12 and the corresponding Oracle Cloud Infrastructure Terraform Provider (>= 3.27.0)

See the [Oracle Cloud Infrastructure Terraform Provider docs](https://www.terraform.io/docs/providers/oci/index.html) for information about setting up and using the Oracle Cloud Infrastructure Terraform Provider.

## How to use this module

This module has the following folder structure:

* [modules](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules): This folder includes submodules for creating IAM resources in Oracle Cloud Infrastructure.
* [example](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/example): This folder contains an example of how to use the module.

## Usage

The available submodules are listed below.

`iam-compartment`:  See a basic example below and [the iam-compartment readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-compartment/README.md) for details.

```hcl
module "iam_compartment" {
  source                  = "oracle-terraform-modules/iam/oci/modules/iam-compartment"
  tenancy_ocid            = "${var.tenancy_ocid}"
  compartment_name        = "tf_example_compartment"
  compartment_description = "compartment created by terraform"
  compartment_create      = false
}
```

`iam-user`: See a basic example below and [the iam-user readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-user/README.md) for details.

```hcl
module "iam_user1" {
  source           = "oracle-terraform-modules/iam/oci/modules/iam-user"
  tenancy_ocid     = "${var.tenancy_ocid}"
  user_name        = "tf_example_user1@oracle.com"
  user_description = "user1 created by terraform"
}
```

`iam-group`: See a basic example below and [the iam-group readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-group/README.md) for details.

```hcl
module "iam_group" {
  source                = "oracle-terraform-modules/iam/oci/modules/iam-group"
  tenancy_ocid          = "${var.tenancy_ocid}"
  group_name            = "tf_example_group"
  group_description     = "group created by terraform"
  user_count            = 2
  user_ids              = ["${module.iam_user1.user_id}", "${module.iam_user2.user_id}"]
  policy_compartment_id = "${module.iam_compartment.compartment_id}"
  policy_name           = "tf-example-policy"
  policy_description    = "policy created by terraform"
  policy_statements     = ["Allow group tf_example_group to read instances in compartment tf_example_compartment", "Allow group tf_example_group to inspect instances in compartment tf_example_compartment"]
}
```

`iam-dynamic-group`: See a basic example below and [the iam-dynamic-group readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-dynamic-group/README.md) for details.

```hcl
module "iam_dynamic_group" {
  source                    = "oracle-terraform-modules/iam/oci/modules/iam-dynamic-group"
  tenancy_ocid              = "${var.tenancy_ocid}"
  dynamic_group_name        = "tf_example_dynamic_group"
  dynamic_group_description = "dynamic group created by terraform"
  dynamic_group_rule        = "instance.compartment.id = '${module.iam_compartment.compartment_id}'"
  policy_compartment_id     = "${module.iam_compartment.compartment_id}"
  policy_name               = "tf-example-dynamic-policy"
  policy_description        = "dynamic policy created by terraform"
  policy_statements         = ["Allow dynamic-group tf_example_dynamic_group to read instances in compartment tf_example_compartment"]
}
```

## Contributing

This project is open source. Oracle appreciates any contributions that are made by the open source community.

## License

Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

Licensed under the Universal Permissive License 1.0 or Apache License 2.0.

See [LICENSE](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/LICENSE.txt) for more details.

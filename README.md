# Oracle Cloud Infrastructure Terraform Modules for Identity and Access Management (oci-iam) v2

This module contains a collection of submodules that simplify the management of Identity and Access Management (IAM) resources such as compartments, users, groups, and dynamic groups for Oracle Cloud Infrastructure. For more information about IAM, see [Overview of IAM](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/overview.htm).

Note: the root folder of this module contains no Terraform code: it groups together the related submodules.

The file and directory layout follows the [Terraform Standard Module Structure](https://www.terraform.io/docs/modules/structure.html):

* [modules](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules) folder contains several standalone, reusable, submodules for creating IAM resources in Oracle Cloud Infrastructure,
* [examples](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/examples) folder contains fully-functional examples that you can copy and paste "as is" to have a first look at the submodules capabilities.

## Maintainers

This module is maintained by Oracle.

## What's new in v2?

### iam-compartment

* Add support for nested Compartments,
* Add support for Compartment deletion,
* DEPRECATED: `compartment_create` argument, which creates a data source instead of a resource when set to `false`. This argument will be removed in the next major release.
* DEPRECATED: `tenancy_ocid`. The preferred argument is now `compartment_id`, as it can be used to create compartments at the tenancy root level and as a nested compartment.

### iam-user

* Add for creating a list of users from a single module,
* Add support for defining user email.

### iam-group

* DEPRECATED: `group_create` argument, which creates a data source instead of a resource when set to `false`. This argument will be removed in the next major release.

### iam-dynamic-group

* DEPRECATED: `dynamic_group_create` argument, which creates a data source instead of a resource when set to `false`. This argument will be removed in the next major release.

## Requirements

* Terraform 0.12.x
* OCI Terraform Provider 3.27 or greater

This modules and its submodules, in version 2, are optimized for Terraform v0.12:

* They will not run at all, or not as intended with a Terraform version below v0.12.0,
* They are not tested with Terraform versions above v0.12 and may produce unexpected behaviors.

The first OCI Terraform provider version to work with Terraform v0.12 is provider.oci v3.27.

* you must use OCI Terraform Provider v3.27 or above,
* this module and its submodules are not extensively tested with OCI Terraform Provider versions 4 and above,
* It may work and give richer informations for some resources, but also produce unexpected behaviors under certain circumstances.

The diagram below summarizes the required components and their respective versions to use this module.

![versions](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/docs/diagrams/versions.svg?raw=true&sanitize=true)

To enforce versions compatibility of both Terraform and the OCI provider, your root configuration should ideally include this block in main.tf for version pinning:

```HCL
terraform {
  required_version = ">= 0.12, < 0.13"
  required_providers {
    oci = {
      version = ">= 3.27, < 4.0"
    }
  }
}
```

See the [Oracle Cloud Infrastructure Terraform Provider docs](https://registry.terraform.io/providers/hashicorp/oci/latest/docs) for detailed information about setting up and using the Oracle Cloud Infrastructure Terraform Provider.

## How to use the submodules

You should always pin the version of this module in your configuration: add the `version` argument of the module block in your root configuration.

* To use v2 of this module for Terraform 0.12:

```HCL
module "iam" {
  source  = "oracle-terraform-modules/iam/oci"
  version = "2.0.0"
}
```

* to use v1 of this module for Terraform 0.11 compatibility:

```HCL
module "iam" {
  source  = "oracle-terraform-modules/iam/oci"
  version = "1.0.3"
}
```

Note:

- *adjust the minor and patch version of the module according to your needs. If version is omitted, the latest available version on the registry will be used.*
- *When using the oci-iam modules, or more generally when manipulating iam resources, **be sure to configure your oci provider to use the tenancy's home region**, as IAM resources can only be managed from the home region.*
- To combine this template with non-iam resources provisioned in a region different from your *home region*, you will need to use [provider aliases](https://www.terraform.io/docs/configuration/providers.html#alias-multiple-provider-configurations).

The available submodules are listed below with example block codes. For fully-functional examples, please see [examples](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/examples).

### Declaring OCI Compartments with iam-compartment

See a basic example below and [the iam-compartment readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-compartment) for details.

* To create a compartment at the root level of the tenancy, insert this block in your root configuration:

```HCL
module "iam_compartment" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = var.tenancy_ocid # define the parent compartment. Creation at tenancy root if omitted
  compartment_name        = "tf_example_compartment"
  compartment_description = "compartment at root level created - terraformed"
  compartment_create      = true # if false, a data source with a matching name is created instead
  enable_delete           = true # if false, on `terraform destroy`, compartment is deleted from the terraform state but not from oci 
}
```

* To create a sub-compartment, with the previously created compartment as parent, insert this block in your root configuration:

```HCL
module "iam_subcompartment" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = module.iam_compartment.compartment_id # define the parent compartment. Here we make reference to the previous module's output
  compartment_name        = "tf_example_subcompartment"
  compartment_description = "subcompartment created below tf_example_compartment - terraformed"
  compartment_create      = true # if false, a data source with a matching name is created instead
  enable_delete           = true # if false, on `terraform destroy`, compartment is deleted from the terraform state but not from oci 
}
```

### Declaring a list of OCI Users with iam-user

See a basic example below and [the iam-user readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-user) for details.

* To create a list of users, insert this block in your root configuration:

```HCL
module "iam_users" {
  source          = "oracle-terraform-modules/iam/oci//modules/iam-user"
  version         = "2.0.0"
  tenancy_ocid    = var.tenancy_ocid # required
  users           = [ # a list of users
    { # user1
      name        = "tf_example_user1@example.com" # required
      description = "user1 - terraformed" # required
      email       = null # set to null if you don't want to provide an email 
    },
    { # user2
      name        = "tf_example_user2@example.com"
      description = "user2 - terraformed"
      email       = "tf_example_user2@example.com"
    },
    { # user3
      name        = "tf_example_user3@example.com"
      description = "user3 - terraformed"
      email       = "tf_example_user3@example.com"
    },# add more users below as needed
  ]
}
```

### Declaring OCI Groups with iam-group

See a basic example below and [the iam-group readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-group) for details.

* To create a group, add previously declared users as members and create an IAM policy in the previously declared compartment, insert this block in your root configuration:

```HCL
module "iam_group" {
  source                = "oracle-terraform-modules/iam/oci//modules/iam-group"
  version         = "2.0.0"
  tenancy_ocid          = var.tenancy_ocid # required
  group_name            = "tf_example_group"  # required
  group_description     = "an example group - terraformed"  # required
  user_ids              = [element(module.iam_users.user_id,0),element(module.iam_users.user_id,1),element(module.iam_users.user_id,2)] # a list of user ocids
  policy_name           = "tf-example-policy" # optional
  policy_compartment_id = module.iam_compartment.compartment_id # optional
  policy_description    = "policy created by terraform" # optional
  policy_statements     = [ # optional
    "Allow group ${module.iam_group.group_name} to read instances in compartment tf_example_compartment",
    "Allow group ${module.iam_group.group_name} to inspect instances in compartment tf_example_compartment",
  ]
}
```

### Declaring OCI Dynamic Groups with iam-dynamic-group

See a basic example below and [the iam-dynamic-group readme](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/modules/iam-dynamic-group) for details.

* To create a dynamic group with a matching rule, and create an IAM policy in the previously declared compartment, insert this block in your root configuration:

```HCL
module "iam_dynamic_group" {
  source                    = "oracle-terraform-modules/iam/oci//modules/iam-dynamic-group"
  tenancy_ocid              = var.tenancy_ocid
  dynamic_group_name        = "tf_example_dynamic_group"
  dynamic_group_description = "dynamic group created by terraform"
  matching_rule             = "instance.compartment.id = '${module.iam_compartment.compartment_id}'"
  policy_compartment_id     = module.iam_compartment.compartment_id
  policy_name               = "tf-example-dynamic-policy"
  policy_description        = "dynamic policy created by terraform"
  policy_statements         = [
    "Allow dynamic-group ${module.iam_dynamic_group.dynamic_group_name} to read instances in compartment tf_example_compartment"
  ]
}
```

## Contributing

This project is open source. Oracle appreciates any contributions that are made by the open source community.

Learn how to [contribute](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/CONTRIBUTING.md).

## License

Copyright (c) 2018, 2021, Oracle and/or its affiliates.

Licensed under the Universal Permissive License 1.0 or Apache License 2.0.

See [LICENSE](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/LICENSE) for more details.

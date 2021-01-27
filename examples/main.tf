// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "homeregion" {}

terraform {
  required_version = ">= 0.12, < 0.13" // this example is intended to run with Terraform v0.12
  required_providers {
    oci = {
      version = ">= 3.27, < 4.0" // force downloading oci-provider compatible with terraform v0.12
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.homeregion
}

/*
* This example shows how to create a compartement and two sub-compartemnt.
*
* This example also shows how to create:
* - several users with a single module block,
* - a group and add group members to it,
* - a policy pertaining to a compartment and group,
* - some more directives to show dynamic groups and policy for it.
*
* Note: The compartment resource internally resolves name collisions and returns a reference to the preexisting compartment.
* All resources created by this example can be deleted by using the Terraform destroy command.
 */

module "iam_compartment" {

  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  version                 = "2.1.1"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = var.tenancy_ocid # define the parent compartment. Creation at tenancy root if omitted
  compartment_name        = "tf_example_compartment"
  compartment_description = "compartment at root level created - terraformed"
  compartment_create      = true # if false, a data source with a matching name is created instead
  enable_delete           = true # if false, on `terraform destroy`, compartment is deleted from the terraform state but not from oci 
}

module "iam_subcompartment1" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  version                 = "2.1.1"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = module.iam_compartment.compartment_id # define the parent compartment. Here we make reference to the previous module
  compartment_name        = "tf_example_subcompartment1"
  compartment_description = "subcompartment created below tf_example_compartment - terraformed"
  compartment_create      = true # if false, a data source with a matching name is created instead
  enable_delete           = true # if false, on `terraform destroy`, compartment is deleted from the terraform state but not from oci 
}

module "iam_subcompartment2" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  version                 = "2.1.1"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = module.iam_compartment.compartment_id # define the parent compartment. Here we make reference to the previous module
  compartment_name        = "tf_example_subcompartment2"
  compartment_description = "subcompartment created below tf_example_compartment - terraformed"
  compartment_create      = true # if false, a data source with a matching name is created instead
  enable_delete           = true # if false, on `terraform destroy`, compartment is deleted from the terraform state but not from oci 
}

module "iam_users" {
  source       = "oracle-terraform-modules/iam/oci//modules/iam-user"
  version      = "2.1.1"
  tenancy_ocid = var.tenancy_ocid
  users = [
    { # user1
      name        = "tf_example_user1@example.com"
      description = "user1 created by terraform"
      email       = null
    },
    { # user2
      name        = "tf_example_user2@example.com"
      description = "user2 created by terraform"
      email       = "tf_example_user2@example.com"
    },
    { # user3
      name        = "tf_example_user3@example.com"
      description = "user3 created by terraform"
      email       = "tf_example_user3@example.com"
    }, # add more users below if needed
  ]
}

module "iam_group" {
  source                = "oracle-terraform-modules/iam/oci//modules/iam-group"
  version               = "2.1.1"
  tenancy_ocid          = var.tenancy_ocid
  group_name            = "tf_example_group"
  group_description     = "an example group - terraformed"
  user_ids              = [element(module.iam_users.user_id, 0), element(module.iam_users.user_id, 1), element(module.iam_users.user_id, 2)] # a list of user ocids
  policy_name           = "tf-example-policy"
  policy_compartment_id = module.iam_compartment.compartment_id
  policy_description    = "policy created by terraform aaaaaaaaaah"
  policy_statements = [
    "Allow group ${module.iam_group.group_name} to read instances in compartment tf_example_compartment",
    "Allow group ${module.iam_group.group_name} to inspect instances in compartment tf_example_compartment",
  ]
}

module "iam_dynamic_group" {
  source                    = "oracle-terraform-modules/iam/oci//modules/iam-group"
  version                   = "2.1.1"
  tenancy_ocid              = var.tenancy_ocid
  dynamic_group_name        = "tf_example_dynamic_group"
  dynamic_group_description = "dynamic group created by terraform"
  matching_rule             = "instance.compartment.id = '${module.iam_compartment.compartment_id}'"
  policy_compartment_id     = module.iam_compartment.compartment_id
  policy_name               = "tf-example-dynamic-policy"
  policy_description        = "dynamic policy created by terraform"
  policy_statements = [
    "Allow dynamic-group ${module.iam_dynamic_group.dynamic_group_name} to read instances in compartment tf_example_compartment",
    "Allow dynamic-group ${module.iam_dynamic_group.dynamic_group_name} to inspect instances in compartment tf_example_compartment",
  ]
}

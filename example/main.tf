// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "homeregion" {}

provider "oci" {
  version          = ">= 3.27.0" // force downloading oci-provider compatible with terraform v0.12
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.homeregion
}

/*
 * This example shows how to reference an existing compartment as a resource (compartment_create = false),
 * or if a compartment needs to be created, please set compartment_create = true.
 * Also this example shows how to create two users, a group and add two users to it, and create a policy
 * pertaining to a compartment and group.
 * And some more directives to show dynamic groups and policy for it.
 *
 * Note: the compartment resource internally resolves name collisions and returns a reference to the preexisting
 * compartment. Compartments can not be deleted, so removing a compartment resource from your .tf file will only
 * remove it from your statefile. User, group and dynamic group created by this example can be deleted by using
 * terrafrom destroy.
 */

module "iam_compartment" {
  source = "../modules/iam-compartment"
  #source                 = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = var.compartment_ocid
  compartment_name        = "tf_example_compartment"
  compartment_description = "compartment created by terraform"
  compartment_create      = true
  enable_delete           = true // give option to delete compartment on `terraform destroy`
}

module "iam_subcompartment" {
  source                  = "../modules/iam-compartment"
  tenancy_ocid            = var.compartment_ocid
  compartment_id          = module.iam_compartment.compartment_id
  compartment_name        = "tf_example_subcompartment"
  compartment_description = "subcompartment created below tf_example_compartment by terraform"
  compartment_create      = true
  enable_delete           = true // give option to delete compartment on `terraform destroy`
}

module "iam_users" {
  source = "../modules/iam-user"
  #source          = "oracle-terraform-modules/iam/oci//modules/iam-user"
  tenancy_ocid = var.tenancy_ocid
  users = [
    {
      name        = "tf_example_user1@oracle.com"
      description = "user1 created by terraform"
      email       = "tf_example_user1@oracle.com"
    },
    {
      name        = "tf_example_user2@oracle.com"
      description = "user2 created by terraform"
      email       = "tf_example_user2@oracle.com"
    },
    {
      name        = "tf_example_user3@oracle.com"
      description = "user3 created by terraform"
      email       = "tf_example_user3@oracle.com"
    },
  ]
}

module "iam_group" {
  source = "../modules/iam-group"
  #source               = "oracle-terraform-modules/iam/oci//modules/iam-group"
  tenancy_ocid      = var.tenancy_ocid
  group_name        = "tf_example_group"
  group_description = "group created by terraform"
  user_ids              = ["${element(module.iam_users.user_id,0)}","${element(module.iam_users.user_id,1)}","${element(module.iam_users.user_id,2)}"]
  policy_compartment_id = module.iam_compartment.compartment_id
  policy_name           = "tf-example-policy"
  policy_description    = "policy created by terraform"
  policy_statements = [
    "Allow group tf_example_group to read instances in compartment tf_example_compartment",
    "Allow group tf_example_group to inspect instances in compartment tf_example_compartment",
  ]
}

module "iam_dynamic_group" {
  source = "../modules/iam-dynamic-group"
  #source                   = "oracle-terraform-modules/iam/oci//modules/iam-dynamic-group"
  tenancy_ocid              = var.tenancy_ocid
  dynamic_group_name        = "tf_example_dynamic_group"
  dynamic_group_description = "dynamic group created by terraform"
  dynamic_group_rule        = "instance.compartment.id = '${module.iam_compartment.compartment_id}'"
  policy_compartment_id     = module.iam_compartment.compartment_id
  policy_name               = "tf-example-dynamic-policy"
  policy_description        = "dynamic policy created by terraform"
  policy_statements = [
    "Allow dynamic-group tf_example_dynamic_group to read instances in compartment tf_example_compartment"
  ]
}

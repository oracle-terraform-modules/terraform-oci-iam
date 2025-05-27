// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

/*
* This example shows how to create a hierarchical compartments.
*
* The hierarchical_compartment_config.yaml contains the detailed structure of 
* compartments that needs to be provisioned.
*/

module "Hierarchical_compartment" {
  source              = "oracle-terraform-modules/iam/oci//modules/iam-hierarchical-compartment"
  root_compartment_id = var.tenancy_ocid # define the parent compartment. Creation at tenancy root if omitted
  compartments        = yamldecode(file("${path.module}/hierarchical_compartment_config.yaml"))["compartments"]
}

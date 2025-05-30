// Copyright (c) 2018, 2021, 2025, Oracle and/or its affiliates.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

/*
* This example shows how to create a hierarchical compartments.
*
* The hierarchical_compartment_config.yaml contains the detailed structure of 
* compartments that needs to be provisioned.
*/

module "Hierarchical_compartment" {
  source              = "oracle-terraform-modules/iam/oci//modules/iam-hierarchical-compartment"
  # version               = "2.0.2"
  root_compartment_id = var.tenancy_ocid # define the parent compartment. Creation at tenancy root if omitted
  compartments        = yamldecode(file("${path.module}/hierarchical_compartment_config.yaml"))["compartments"]
}

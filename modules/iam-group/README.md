# Oracle Cloud Infrastructure Group Terraform Module

This [Terraform module](https://www.terraform.io/docs/modules/index.html) defines an [Oracle Cloud Infrastructure  Group](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managinggroups.htm) and a related policy, and optionally adds a list of users to that group.

```hcl
module "iam_group" {
  source                = "oracle-terraform-modules/iam/oci//modules/iam-group"
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

Note the following parameters:

Argument | Description
--- | ---
tenancy_ocid | (Required) Unique identifier (OCID) of the tenancy.
group_name | (Required) The name you assign to the IAM group when created. The name must be unique across all compartments in the tenancy.
group_description | (Required if group_create is true.) Description of the IAM group. The description is editable.
group_create | (Optional) Specifies whether the module should create the group. If true, the user must have permission to create a group. If false, group data is returned for all existing groups. If no groups are found, an empty string is returned for the group ID. Default value is true.
user_count | (Optional) Number of user to be added to a group.
user_ids | (Optional) List of user' ocids.
policy_name | (Optional)  The name you assign to the IAM policy. 
policy_description | (Required if policy_name is not empty) Description of the IAM policy. The description is editable. 
policy_statements | (Required if policy_name is not empty)  The policy definition expressed as one or more policy statements. 

You can find the other parameters in [variables.tf](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/modules/iam-group/variables.tf).

Check out the [example](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/example) for fully-working sample code.

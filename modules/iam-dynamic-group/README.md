# Oracle Cloud Infrastructure Dynamic Group Terraform Module

This [Terraform module](https://www.terraform.io/docs/modules/index.html) defines an [Oracle Cloud Infrastructure Dynamic Group](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingdynamicgroups.htm) and a related policy.

```hcl
module "iam_dynamic_group" {
  source                    = "oracle-terraform-modules/iam/oci//modules/iam-dynamic-group"
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

Note the following parameters:

Argument | Description
--- | ---
tenancy_ocid | (Required) Unique identifier (OCID) of the tenancy.
dynamic_group_name | (Required) Name given to the dynamic group during creation. The name must be unique across all compartments in the tenancy.
dynamic_group_description | (Required if dynamic_group_create is true.) Description of the dynamic group. The description is editable.
dynamic_group_create | (Optional) Specifies whether the module should create a dynamic group. If true, the user must have permission to create a dynamic group. If false, data is returned for any existing dynamic groups, and an empty string is returned for the dynamic group ID. Default value is true.
dynamic_group_rule | (Required if dynamic_group_create is true.) Define a matching rule or a set of matching rules to define the group members.
policy_name | (Optional)  The name you assign to the IAM policy. 
policy_description | (Required if policy_name is not empty) Description of the IAM policy. The description is editable. 
policy_statements | (Required if policy_name is not empty)  The policy definition expressed as one or more policy statements. 

You can find the other parameters in [variables.tf](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/modules/iam-dynamic-group/variables.tf).

Check out the [example](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/example) for fully-working sample code.

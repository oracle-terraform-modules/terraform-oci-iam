# modules/iam-group

This [Terraform module](https://www.terraform.io/docs/modules/index.html) defines an [Oracle Cloud Infrastructure  Group](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managinggroups.htm). Optionally, you can:

* add a list of users as member to the created group,
* add an OCI IAM policy. [See How Policies Work](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/policies.htm) and [Common Policies](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/commonpolicies.htm) for more information regarding the policy syntax.

Below is the typical module block you should add to your configuration to create a group with this module.

```hcl
module "iam_group" {
  source                = "oracle-terraform-modules/iam/oci//modules/iam-group"
  version         = "2.1.1"
  tenancy_ocid          = var.tenancy_ocid # required
  group_name            = "tf_example_group"  # required
  group_description     = "an example group - terraformed"  # required
  user_ids              = [var.user1_id,var.user2_id,var.user3_id]
  policy_compartment_id = var.tenancy_ocid
  policy_name           = "tf-example-policy" # optional
  policy_description    = "policy created by terraform" # optional
  policy_statements     = [ # optional
    "Allow group tf_example_group to read instances in compartment tf_example_compartment",
    "Allow group tf_example_group to inspect instances in compartment tf_example_compartment",
  ]
}
```

Check out the [examples](../../examples) folder for fully-working sample code.

Note the following parameters:

Argument | Description | Default
--- | --- | ---
tenancy_ocid | (Required) Unique identifier (OCID) of the tenancy. | null
group_name | (Required) The name you assign to the IAM group when created. The name must be unique across all groups in the tenancy and cannot be changed. | null
group_description | (Required if group_create is true.)(Updatable) Description of the IAM group. Does not have to be unique, and it's changeable. | null
group_create | **[DEPRECATED]** (Optional) Specifies whether the module should create the group. If true, the user must have permission to create a group. If false, group data is returned for all existing groups. If no groups are found, an empty string is returned for the group ID. | true
user_ids | (Optional)(Updatable) List of user ocids to add as group member. | null
policy_name | (Optional)  The name you assign to the IAM policy. The name must be unique across all policies in the tenancy and cannot be changed. | null
policy_compartment | (Required, if policy_name is set) The OCID of the compartment containing the policy. Cannot be changed (current API limitation.) | null
policy_description | (Required, if policy_name is set)(Updatable) The description you assign to the policy during creation. Does not have to be unique, and it's changeable. | null
policy_statements | (Required if policy_name is set)(Updatable) An array of policy statements written in the policy language. | null

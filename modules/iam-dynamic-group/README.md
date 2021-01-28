# modules/iam-dynamic-group

This [Terraform module](https://www.terraform.io/docs/modules/index.html) defines an [Oracle Cloud Infrastructure Dynamic Group](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingdynamicgroups.htm). Optionally, you can:

* add an OCI IAM policy for this dynamic group. [See How Policies Work](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/policies.htm) and [Common Policies](https://docs.cloud.oracle.com/iaas/Content/Identity/Concepts/commonpolicies.htm) for more information regarding the policy syntax.

Below is the typical module block you should add to your configuration to create a compartment with this module.

**IMPORTANT:** There is no version pinning of modules in the examples to lower documentation maintenance when releasing new module versions. It is a good practice to pin the module version to the exact version you are using in your code so that your infrastructure remains stable and predictible.

```hcl
module "iam_dynamic_group" {
  source                    = "oracle-terraform-modules/iam/oci//modules/iam-dynamic-group"
  # Pinning each module to a specific version is highly advisable. Please adjust and uncomment the line below
  # version               = "x.x.x"
  tenancy_ocid              = "${var.tenancy_ocid}"
  dynamic_group_name        = "tf_example_dynamic_group"
  dynamic_group_description = "dynamic group created by terraform"
  matching_rule             = "instance.compartment.id = '${module.iam_compartment.compartment_id}'"
  policy_compartment_id     = "${module.iam_compartment.compartment_id}"
  policy_name               = "tf-example-dynamic-policy"
  policy_description        = "dynamic policy created by terraform"
  policy_statements         = ["Allow dynamic-group tf_example_dynamic_group to read instances in compartment tf_example_compartment"]
}
```

Check out the [examples](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/examples) for fully-working sample code.

Note the following parameters:

Argument | Description | Default
--- | --- | ---
tenancy_ocid | (Required) Unique identifier (OCID) of the tenancy. | null
dynamic_group_name | (Required) Name given to the dynamic group during creation. The name must be unique across all compartments in the tenancy and cannot be changed. | null
dynamic_group_description | (Required if dynamic_group_create is true.)(Updatable) Description of the dynamic group. Does not have to be unique, and it's changeable. | null
dynamic_group_create | **[DEPRECATED]** (Optional) Specifies whether the module should create a dynamic group. If true, the user must have permission to create a dynamic group. If false, data is returned for any existing dynamic groups, and an empty string is returned for the dynamic group ID. | true
matching_rule | (Required if dynamic_group_create is true.)(Updatable) The matching rule to dynamically match an instance certificate to this dynamic group. For rule syntax, see [Managing Dynamic Groups](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingdynamicgroups.htm). | null
policy_name | (Optional)  The name you assign to the IAM policy. The name you assign to the IAM policy. The name must be unique across all policies in the tenancy and cannot be changed. | null
policy_description | (Required if policy_name is set)(Updatable) The description you assign to the policy during creation. Does not have to be unique, and it's changeable. | null
policy_statements | (Required if policy_name is set)(Updatable) An array of policy statements written in the policy language. | null

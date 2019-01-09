# Oracle Cloud Infrastructure Compartment Terraform Module

This [Terraform module](https://www.terraform.io/docs/modules/index.html) allows an [Oracle Cloud Infrastructure  compartment](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm) to be used in either read-only mode or read/write mode. You can switch between the two modes by setting `compartment_create` to either true (read/write) or false (read-only).

```hcl
module "iam_compartment" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  tenancy_ocid            = "${var.tenancy_ocid}"
  compartment_name        = "tf_example_compartment"
  compartment_description = "compartment created by terraform"
  compartment_create      = false
}
```

Note the following parameters:

Argument | Description
--- | ---
tenancy_ocid | (Required) Unique identifier (OCID) of the tenancy.
compartment_name | (Required) The name you assign to the compartment. The name must be unique across all compartments in a given tenancy.
compartment_description | (Required if compartment_create is true.) Description of the compartment. You can edit the description.
compartment_create | (Optional)  Specifies whether the module should create a compartment. If true, the compartment will be managed by the module. In this case, the user must have permission to create the compartment. If false, compartment data will be returned about any existing compartments. If no compartment is found, an empty string is returned for the compartment ID. Default value is true.

You can find the other parameters in [variables.tf](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/modules/iam-compartment/variables.tf).

Check out the [example](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/example) for fully-working sample code.

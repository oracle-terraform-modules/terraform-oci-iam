# modules/iam-compartment

This [Terraform module](https://www.terraform.io/docs/modules/index.html) allows an [Oracle Cloud Infrastructure  compartment](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm) to be used in either read-only mode or read/write mode. You can switch between the two modes by setting the `compartment_create` argument to either `true` (a new resource will be created) or `false` (a data source filtered to the provided compartment name will be created).

With the `enable_delete` argument (boolean: `true` or `false`), you can control the `terraform destroy` command behavior:

- `true`: terraform will actually delete the compartment from OCI.
- `false`: terraform will only remove the compartment from the configuration (the actual OCI resource is not deleted, only the terraform representation is deleted

Below is the typical module block you should add to your configuration to create a compartment with this module.

**IMPORTANT:** There is no version pinning of modules in the examples to lower documentation maintenance when releasing new module versions. It is a good practice to pin the module version to the exact version you are using in your code so that your infrastructure remains stable and predictible.

```hcl
module "iam_compartment" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  # Pinning each module to a specific version is highly advisable. Please adjust and uncomment the line below
  # version               = "x.x.x"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = var.tenancy_ocid
  compartment_name        = "tf_example_compartment"
  compartment_description = "compartment created by terraform"
  compartment_create      = true
  enable_delete           = true
}
```

The argument `compartment_id` defines the parent compartment of the defined compartment and takes an ocid as value:

- to create or move a compartment at the root level, set `compartment_id` to the tenancy ocid,
- to create or move a compartment at below another compartment, set `compartment_id` to the partent compartment ocid,

```hcl
module "iam_subcompartment" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-compartment"
  # Pinning each module to a specific version is highly advisable. Please adjust and uncomment the line below
  # version               = "x.x.x"
  tenancy_ocid            = var.tenancy_ocid
  compartment_id          = module.iam_compartment.compartment_id
  compartment_name        = "tf_example_subcompartment"
  compartment_description = "subcompartment created below tf_example_compartment by terraform"
  compartment_create      = true
  enable_delete           = true
}
```

Check out the [examples](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/examples) for fully-working sample code.

Note the following parameters:

Argument | Description | Default
--- | --- | ---
tenancy_ocid | **[DEPRECATED]** (Required) Unique identifier (OCID) of the tenancy. | null
compartment_id | (Required)(Updatable) The OCID of the parent compartment containing the compartment. | null
compartment_name | (Required)(Updatable) The name you assign to the compartment. The name must be unique across all compartments in the parent compartment. | null
compartment_description | (Required if compartment_create is true.)(Updatable) The description you assign to the compartment during creation. Does not have to be unique, and it's changeable. | null
compartment_create | **[DEPRECATED]** (Optional)  Specifies whether the module should create a compartment. If true, the compartment will be managed by the module. In this case, the user must have permission to create the compartment. If false, compartment data will be returned about any existing compartments. If no compartment is found, an empty string is returned for the compartment ID. | true
enable_delete | If omitted or set to false the provider will implicitly import the compartment if there is a name collision, and will not actually delete the compartment on destroy or removal of the resource declaration. If set to true, the provider will throw an error on a name collision with another compartment, and will attempt to delete the compartment on destroy or removal of the resource declaration. | false

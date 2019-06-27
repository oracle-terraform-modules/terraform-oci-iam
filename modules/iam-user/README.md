# Oracle Cloud Infrastructure User Terraform Module

This [Terraform module](https://www.terraform.io/docs/modules/index.html) allows creation of [Oracle Cloud Infrastructure  users](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingusers.htm).

```hcl
module "iam_users" {
  source           = "oracle-terraform-modules/iam/oci//modules/iam-user"
  tenancy_ocid     = "${var.tenancy_ocid}"
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
  ]
}
```

Note the following parameters:

Argument | Description
--- | ---
tenancy_ocid | (Required) Unique identifier (OCID) of the tenancy.
users | an array of users to create
name | The name you assign to the user during creation. The name must be unique across all compartments in the tenancy.
description | (Required) Description of the user. The description is editable.
email | (Optional) The email address you assign to the user during creation.

You can find the other parameters in [variables.tf](https://github.com/oracle-terraform-modules/terraform-oci-iam/blob/master/modules/iam-user/variables.tf).

Check out the [example](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/example) for fully-working sample code.

### Create Compartment, User, Group and Dynamic Group
This example shows how to reference an existing compartment as a resource (compartment_create = false), or if a compartment needs to be created, please set compartment_create = true.
Also this example shows how to create two users, a group and add two users to it, and create a policy pertaining to a compartment and group, and some more directives to show dynamic groups and policy for it.

Note: The compartment resource internally resolves name collisions and returns a reference to the preexisting compartment. Compartments can not be deleted, so removing a compartment resource from your .tf file will only remove it from your statefile. User, group, and dynamic group created by this example can be deleted by using the Terraform destroy command.

### Using this example
* Create a "terraform.tfvars" file based on the provided template, "terraform.tfvars.template", and fill in the necessary info.
* Initialize the directory:

```
$ terraform init
```

* View what Terraform plans do before actually doing it:

```
$ terraform plan
```

* Use Terraform to Provision resources on OCI:

```
$ terraform apply
```

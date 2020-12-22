# Create Compartment, Sub-compartment, Users, Group and Dynamic Group

This example shows how to create a compartement and two sub-compartemnt.

This example also shows how to create:

- several users with a single module block,
- a group and add users to it,
- a policy pertaining to a compartment and group,
- some more directives to show dynamic groups and policy for it.

Note: The compartment resource internally resolves name collisions and returns a reference to the preexisting compartment.
All resources created by this example can be deleted by using the `terraform destroy` command.

## Using this example

- Create a "terraform.tfvars" file based on the provided template, "terraform.tfvars.template", and fill in the necessary info.
- Initialize the directory:

```bash
> terraform init
```

- Inspect what Terraform plans to do before actually doing it:

```bash
> terraform plan
```

- If proposed changes are what waas intended, apply the plan to Provision resources on OCI (if not abort the operation and review the configuration):

```bash
> terraform apply
```

Sample ouput:

```bash
Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

iam_compartment = {
  "description" = "compartment created by terraform"
  "name" = "tf_example_compartment"
  "ocid" = "ocid1.compartment.oc1..aaaaaaaa"
  "parent" = "ocid1.tenancy.oc1..aaaaaaaa"
}
iam_dynamic_group_name = tf_example_dynamic_group
iam_group = [
  {
    "tf_example_group" = "ocid1.group.oc1..aaaaaaaa"
  },
]
iam_subcompartment1 = {
  "description" = "subcompartment created below tf_example_compartment by terraform"
  "name" = "tf_example_subcompartment"
  "ocid" = ""
  "parent" = ""
}
iam_subcompartment2 = {
  "description" = "subcompartment created below tf_example_compartment by terraform"
  "name" = "tf_example_subcompartment2"
  "ocid" = ""
  "parent" = ""
}
iam_users = [
  {
    "tf_example_user1@example.com" = "ocid1.user.oc1..aaaaaaaa"
    "tf_example_user2@example.com" = "ocid1.user.oc1..aaaaaaaa"
    "tf_example_user3@example.com" = "ocid1.user.oc1..aaaaaaaa"
  },
]
```

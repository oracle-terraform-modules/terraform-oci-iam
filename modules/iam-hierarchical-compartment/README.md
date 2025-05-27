
# modules/iam-hierarchical-compartment

This [Terraform module](https://www.terraform.io/docs/modules/index.html) allows an [Oracle Cloud Infrastructure  compartment](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm) to be created hierarchically upto 6-level deep from the root compartment.

## Example

```hcl
module "Hierarchical_compartment" {
  source                  = "oracle-terraform-modules/iam/oci//modules/iam-hierarchical-compartment"
  # Pinning each module to a specific version is highly advisable. Please adjust and uncomment the line below
  # version               = "x.x.x"
  root_compartment_id     = var.tenancy_ocid # define the parent compartment. Creation at tenancy root if omitted
  compartments            = yamldecode(file("${path.module}/hierarchical_compartment_config.yaml"))["compartments"] # place the yaml file in the same module path
}
```

```yaml
compartments:
- compartment_name: compartment_level_1_a
  description: "level 1 a"
  freeform_tags: 
    "Env": "Dev" 
    "Billing": "Devbilling"
  defined_tags:
    "Operations.CostCenter": "42"
  enable_delete: true
  compartments:
  - compartment_name: compartment_level_2_a
    description: "level 2 a"
    enable_delete: true
    compartments:
    - compartment_name: compartment_level_3_1_a
      description: "level 3.1 a"
      enable_delete: true
      compartments: []
    - compartment_name: compartment_level_3_2_a
      description: "level 3.2 a"
      enable_delete: true
      compartments:
      - compartment_name: compartment_level_4_a
        description: "level 4 a"   
        enable_delete: true 
        compartments:
        - compartment_name: compartment_level_5_a
          description: "level 5 a"
          enable_delete: true
          compartments:
          - compartment_name: compartment_level_6_a
            description: "level 6 a"
            enable_delete: true    
- compartment_name: compartment_level_1_b
  description: "level 1 b"
  enable_delete: true
  compartments:
  - compartment_name: compartment_level_2_b
    compartments: []
    description: "level 2b"
    enable_delete: true
    freeform_tags: 
      "Env": "Test" 
      "Billing": "Testbilling"

```

Check out the [examples](https://github.com/oracle-terraform-modules/terraform-oci-iam/tree/master/examples) for fully-working sample code.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >=4.67.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | >=4.67.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_compartment.compartment_level_1](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_compartment.compartment_level_2](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_compartment.compartment_level_3](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_compartment.compartment_level_4](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_compartment.compartment_level_5](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_compartment.compartment_level_6](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartments"></a> [compartments](#input\_compartments) | Hierarchical Compartments | `any` | n/a | yes |
| <a name="input_root_compartment_id"></a> [root\_compartment\_id](#input\_root\_compartment\_id) | Target compartment id which is considered as root | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartment_ids"></a> [compartment\_ids](#output\_compartment\_ids) | Compartment ID's |

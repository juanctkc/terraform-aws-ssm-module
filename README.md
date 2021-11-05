# Terraform aws ssm module

## About

This module creates AWS SSM parameters.
It has ability to create manual - without any tracking of updates and dynamic - with auto set values

## Examples

```hcl
locals {
  // Values that should be set manually and not overriden by terraform
  manual_set_parameters = [
    // Backend
    {
      "prefix" = "/${var.environment}/backend"
      "parameters" = [
        {
          "name"  = "Bank_Secret"
          "value" = "1"
        },
        {
          "name"  = "Bank_Key"
          "value" = "1"
        },
        {
          "name"  = "Other_Manual_Secret"
          "value" = "1"
        }
      ]
    }
  ]
}

## task definition secrets
module "task_container_secrets" {
  source         = "git::https://github.com/dmytro-dorofeiev/modules/terraform-aws-ssm-module.git"
  parameters     = local.task_container_secrets
  kms_key_id     = data.aws_kms_alias.default.arn
  ignore_changes = true
  overwrite      = false
  tags           = local.common_tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.dynamic_set_parameters](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ignore_changes"></a> [ignore\_changes](#input\_ignore\_changes) | Set lifecycle behaviour | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key id | `string` | n/a | yes |
| <a name="input_overwrite"></a> [overwrite](#input\_overwrite) | Overwrite an existing parameter. | `bool` | `true` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | n/a | <pre>list(object({<br>    prefix = string<br>    parameters = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamic_keys"></a> [dynamic\_keys](#output\_dynamic\_keys) | SSM keys name |
| <a name="output_dynamic_secrets_json"></a> [dynamic\_secrets\_json](#output\_dynamic\_secrets\_json) | ECS task definition secrets from dynamic ssm |
| <a name="output_dynamic_values"></a> [dynamic\_values](#output\_dynamic\_values) | SSM keys values |
| <a name="output_static_keys"></a> [static\_keys](#output\_static\_keys) | SSM keys name |
| <a name="output_static_secrets_json"></a> [static\_secrets\_json](#output\_static\_secrets\_json) | ECS task definition secrets from manual ssm |
| <a name="output_static_values"></a> [static\_values](#output\_static\_values) | SSM keys values |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

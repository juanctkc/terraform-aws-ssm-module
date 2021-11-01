
locals {
  parameters = flatten([
    for parameters in var.parameters : [
      for keyvalues in parameters.parameters :
      {
        "name"  = "${parameters.prefix}/${keyvalues.name}"
        "value" = keyvalues.value
      }
    ]
  ])

}

# resource "aws_ssm_parameter" "manual_set_parameters" {
resource "aws_ssm_parameter" "parameter" {
  for_each  = { for keyvalue in local.parameters : keyvalue.name => keyvalue.value if var.ignore_changes == true }
  name      = each.key
  value     = each.value
  type      = var.kms_key_id != "" ? "SecureString" : "String"
  key_id    = var.kms_key_id
  tags      = var.tags
  overwrite = var.overwrite

  lifecycle {
    ignore_changes        = [value]
    create_before_destroy = false
  }
}

resource "aws_ssm_parameter" "dynamic_set_parameters" {
  for_each  = { for keyvalue in local.parameters : keyvalue.name => keyvalue.value if var.ignore_changes == false }
  name      = each.key
  value     = each.value
  type      = var.kms_key_id != "" ? "SecureString" : "String"
  key_id    = var.kms_key_id
  tags      = var.tags
  overwrite = var.overwrite

  lifecycle {
    create_before_destroy = false
  }
}

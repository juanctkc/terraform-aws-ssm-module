output "static_secrets_json" {
  description = "ECS task definition secrets from manual ssm"
  value = var.ignore_changes ? [
    for secret, arn in zipmap(
      sort(flatten([for parameters in var.parameters : [for keyvalues in parameters.parameters : keyvalues.name]])),
    sort([for value in aws_ssm_parameter.parameter : value.arn])) :
    tomap({ "name" = secret, "valueFrom" = arn })
  ] : null
}

output "static_keys" {
  description = "SSM keys name"
  value       = var.ignore_changes ? sort(flatten([for parameters in var.parameters : [for keyvalues in parameters.parameters : keyvalues.name]])) : null
}

output "static_values" {
  description = "SSM keys values"
  value       = var.ignore_changes ? sort([for value in aws_ssm_parameter.parameter : value.arn]) : null
}

output "dynamic_secrets_json" {
  description = "ECS task definition secrets from dynamic ssm"
  value = var.ignore_changes == false ? [
    for secret, arn in zipmap(
      sort(flatten([for parameters in var.parameters : [for keyvalues in parameters.parameters : keyvalues.name]])),
    sort([for value in aws_ssm_parameter.dynamic_set_parameters : value.arn])) :
    tomap({ "name" = secret, "valueFrom" = arn })
  ] : null
}

output "dynamic_keys" {
  description = "SSM keys name"
  value       = var.ignore_changes == false ? sort(flatten([for parameters in var.parameters : [for keyvalues in parameters.parameters : keyvalues.name]])) : null
}

output "dynamic_values" {
  description = "SSM keys values"
  value       = var.ignore_changes == false ? sort([for value in aws_ssm_parameter.dynamic_set_parameters : value.arn]) : null
}

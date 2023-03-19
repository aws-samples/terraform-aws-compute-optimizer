data "aws_caller_identity" "current" {}


locals {
  #based on the values given in variable file each value is read and added a parameter
  account_id = data.aws_caller_identity.current.account_id

  #common prefix for command is added
  command_prefix = "aws compute-optimizer put-recommendation-preferences"

  scope_parameters = var.scope_name == null ? null : (var.scope_name == "Organization") ? "--scope-name=Organization,value=${var.scope_value}" : (var.scope_name == "AccountId" && length(var.scope_value) == 12) ? "--scope name=AccountId,value=${var.scope_value}" : (var.scope_name == "ResourceArn") ? "--scope name=ResourceArn,value=${var.scope_value} " : ""

  resuorce_type_parameters = var.resource_type == null ? null : "--resource-type ${var.resource_type}"

  enhanced_monitoring_parameters = var.enhanced_monitoring == null ? null : "--enhanced-infrastructure-metrics ${var.enhanced_monitoring}"

  #put-recomendation-preference is not executed when:
  # - enrollment status is Inactive
  # - any neccesary values like scope_name, resource_type, enhanced_monitoring are set to null
  executable_command = var.status == "Inactive" || (var.scope_name == null && var.resource_type == null && var.enhanced_monitoring == null) ? null : join(" ", [local.command_prefix, local.scope_parameters, local.resuorce_type_parameters, local.enhanced_monitoring_parameters])
}

resource "null_resource" "compute_optimiser" {
  triggers = {
    status     = var.status
    scope_name = var.scope_name
    file_hash  = "${sha256(file("${path.module}/dev.auto.tfvars"))}"
  }
  #Uncommenting below snippet will execute the command. Commented as the command execution will fail because it needs AWS Org setup etc. 
  #However, the final command can be seen in output section 
  
  provisioner "local-exec" {
    command = local.executable_command == null ? " aws compute-optimizer update-enrollment-status --status ${self.triggers.status} " : "aws compute-optimizer update-enrollment-status --status ${self.triggers.status} ; ${local.executable_command}"
  }
}

output "executable_command" {
  description = "Command executed:"
  value       = "aws compute-optimizer update-enrollment-status --status ${var.status} \n${local.executable_command}"
}


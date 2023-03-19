variable "status" {
  description = "Whether AWS Computer Optimizer should be Active or Inactive."
  #type        = string
  default = "Active"
  validation {
    condition     = contains(["Active", "Inactive"], var.status)
    error_message = "Value has to be Active or Inactive."
  }
}

variable "scope_name" {
  description = "The name of the scope. It can be Organization|AccountId|ResourceArn"
  validation {
    condition     = var.scope_name == null ? true : (var.scope_name == "Organization" || var.scope_name == "AccountId" || var.scope_name == "ResourceArn")
    error_message = "Value has to be from the list [Organization,AccountId,ResourceArn]."
  }
}

variable "scope_value" {
  description = "The value of the scope. It should be ALL_ACCOUNTS if scope_name is Organization, vales of Account ID or resource arn as mentioned in scope name"

  default = null
  validation {
    condition     = var.scope_value == null ? true : (var.scope_value == "ALL_ACCOUNTS" || length(var.scope_value) == 12 || can(regex("^arn:aws:(?:ec2|autoscaling):[a-z]-[a-z]+-[1-9]:[[:digit:]]{12}:(.*)$", var.scope_value)))
    error_message = "Invalid scope_name and scope_value pair."
  }
}

variable "resource_type" {

  description = "The target resource type of the recommendation preference to create."
  default     = null
  validation {
    condition     = var.resource_type == null ? true : (var.resource_type == "Ec2Instance" || var.resource_type == "AutoScalingGroup" || var.resource_type == "EbsVolume" || var.resource_type == "LambdaFunction" || var.resource_type == "NotApplicable")
    error_message = "Value has to be from the list :[Ec2Instance,AutoScalingGroup,EbsVolume,LambdaFunction,NotApplicable]."
  }
}

variable "enhanced_monitoring" {

  description = "The status of the enhanced infrastructure metrics recommendation preference to make it Active or Inactive"
  default     = null
  validation {
    condition     = var.enhanced_monitoring == null ? true : (var.enhanced_monitoring == "Active" || var.enhanced_monitoring == "Inactive")
    error_message = "Value has to be Active or Inactive."
  }
}

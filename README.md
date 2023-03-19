# AWS Compute Optimizer Terraform module

Terraform Infrastructure as code (IaC) template for AWS Compute Optimizer module to Opting in or out your account.

## Limitations

Currently Terraform does not have resource for AWS Compute Optimizer. Below is open issue:

[Add resources for ComputeOptimizer Recommendation Preferences](https://github.com/hashicorp/terraform-provider-aws/issues/23945)

As workaround, we tried to provide customised way to opt-in and opt-out your account for AWS compute optimizer. We may need to update it as per the requirements and Terraform releases.

[AWS Documentation on put-recommendation-preferences](https://docs.aws.amazon.com/cli/latest/reference/compute-optimizer/put-recommendation-preferences.html)

## Requirements

- This module requires Terraform version >= 0.12.

## Input

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="status"></a> [status](#input\status) | Whether AWS Computer Optimizer should be Active or Inactive | `string` | n/a | yes |
| <a name="scope_name"></a> [scope_name](#input\status)|The name of the scope. It can be Organization\|AccountId\|ResourceArn|`string`|null|no|
|[scope_value](#input\status)|The value of the scope. It should be ALL_ACCOUNTS if scope_name is Organization, values for Account ID or resource arn to be mentioned as per scope name|`string`|null|no|
|[resource_type](#input\status)|The target resource type of the recommendation preference to create|`string`|null|no|
|[enhanced_monitoring](#input\status)|The status of the enhanced infrastructure metrics recommendation preference to make it Active or Inactive|`string`|null|no|

## Usage

Update variables in dev.auto.tfvars as per the configuration required.

## Example output

```
 terraform apply                                          

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.compute_optimiser will be created
  + resource "null_resource" "compute_optimiser" {
      + id       = (known after apply)
      + triggers = {
          + "file_hash"  = "1c90c11c9c712ffb320ea81490f501cc53952331a428c329a97b680a5cf5d66b"
          + "scope_name" = "Organization"
          + "status"     = "Active"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + executable_command = <<-EOT
        aws compute-optimizer update-enrollment-status --status Active 
        aws compute-optimizer put-recommendation-preferences --scope name=Organization,value=ALL_ACCOUNTS --resource-type Ec2Instance --enhanced-infrastructure-metrics Inactive
    EOT

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

null_resource.compute_optimiser: Creating...
null_resource.compute_optimiser: Creation complete after 0s [id=2527645616079253896]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

executable_command = <<EOT
aws compute-optimizer update-enrollment-status --status Active 
aws compute-optimizer put-recommendation-preferences --scope name=Organization,value=ALL_ACCOUNTS --resource-type Ec2Instance --enhanced-infrastructure-metrics Inactive
EOT

```
## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
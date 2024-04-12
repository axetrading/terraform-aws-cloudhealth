# terraform-aws-cloudhealth
This module manages installation of CloudHealth - AWS required resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.45.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cur_report_definition.cur_report](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cur_report_definition) | resource |
| [aws_iam_role.cloudhealth_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudhealth_read_only_policy_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.cloudhealth_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudhealth_read_only_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cur_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_bucket_name"></a> [billing\_bucket\_name](#input\_billing\_bucket\_name) | The name of the S3 bucket where AWS CUR files are saved. | `string` | `null` | no |
| <a name="input_cloudhealth_external_id"></a> [cloudhealth\_external\_id](#input\_cloudhealth\_external\_id) | REQUIRED: Enter the ExternalID provided to you by CloudHealth. | `string` | n/a | yes |
| <a name="input_create_s3_access_policy"></a> [create\_s3\_access\_policy](#input\_create\_s3\_access\_policy) | Flag to create the S3 policy | `bool` | `false` | no |
| <a name="input_create_s3_cur_bucket"></a> [create\_s3\_cur\_bucket](#input\_create\_s3\_cur\_bucket) | Flag to create the S3 bucket for AWS CUR files. | `bool` | `false` | no |
| <a name="input_cur_bucket_name"></a> [cur\_bucket\_name](#input\_cur\_bucket\_name) | The name of the S3 bucket where AWS CUR files are saved. | `string` | `null` | no |
| <a name="input_kms_key_alias"></a> [kms\_key\_alias](#input\_kms\_key\_alias) | The alias for the KMS key. | `string` | `null` | no |
| <a name="input_reports"></a> [reports](#input\_reports) | A map of report definitions | <pre>map(object({<br>    report_name                = string<br>    time_unit                  = string<br>    format                     = string<br>    compression                = string<br>    additional_schema_elements = optional(list(string))<br>    s3_bucket                  = optional(string)<br>    s3_prefix                  = string<br>    s3_region                  = string<br>    additional_artifacts       = optional(list(string))<br>    report_versioning          = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_s3_cur_bucket_versioning_enabled"></a> [s3\_cur\_bucket\_versioning\_enabled](#input\_s3\_cur\_bucket\_versioning\_enabled) | Flag to enable versioning on the S3 bucket for AWS CUR files. | `bool` | `true` | no |
| <a name="input_s3_kms_key_arn"></a> [s3\_kms\_key\_arn](#input\_s3\_kms\_key\_arn) | The ARN of the KMS key to use for server-side encryption. | `string` | `null` | no |
| <a name="input_s3_use_existing_kms_key"></a> [s3\_use\_existing\_kms\_key](#input\_s3\_use\_existing\_kms\_key) | Flag to use an existing KMS key for server-side encryption. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudhealth_access_role"></a> [cloudhealth\_access\_role](#output\_cloudhealth\_access\_role) | The IAM role that CloudHealth will assume to access your AWS account. |
| <a name="output_cloudhealth_access_role_arn"></a> [cloudhealth\_access\_role\_arn](#output\_cloudhealth\_access\_role\_arn) | The ARN of the IAM role that CloudHealth will assume to access your AWS account. |
| <a name="output_cloudhealth_cost_usage_bucket_arn"></a> [cloudhealth\_cost\_usage\_bucket\_arn](#output\_cloudhealth\_cost\_usage\_bucket\_arn) | The ARN of the S3 bucket where AWS CUR files are saved. |
| <a name="output_cloudhealth_cost_usage_bucket_name"></a> [cloudhealth\_cost\_usage\_bucket\_name](#output\_cloudhealth\_cost\_usage\_bucket\_name) | The name of the S3 bucket where AWS CUR files are saved. |
<!-- END_TF_DOCS -->
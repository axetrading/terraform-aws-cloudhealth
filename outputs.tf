output "cloudhealth_access_role" {
  description = "The IAM role that CloudHealth will assume to access your AWS account."
  value       = aws_iam_role.cloudhealth_access.name
}

output "cloudhealth_access_role_arn" {
  description = "The ARN of the IAM role that CloudHealth will assume to access your AWS account."
  value       = aws_iam_role.cloudhealth_access.arn
}

output "cloudhealth_cost_usage_bucket_name" {
  description = "The name of the S3 bucket where AWS CUR files are saved."
  value       = try(aws_s3_bucket.cur[0].id, "")
}

output "cloudhealth_cost_usage_bucket_arn" {
  description = "The ARN of the S3 bucket where AWS CUR files are saved."
  value       = try(aws_s3_bucket.cur[0].arn, "")
}
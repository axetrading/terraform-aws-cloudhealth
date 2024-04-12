locals {
  account_id          = data.aws_caller_identity.current.account_id
  region              = data.aws_region.current.name
  cur_bucket_name     = var.create_s3_cur_bucket ? aws_s3_bucket.cur[0].id : var.cur_bucket_name
  billing_bucket_name = var.create_s3_cur_bucket ? aws_s3_bucket.cur[0].id : var.billing_bucket_name
}
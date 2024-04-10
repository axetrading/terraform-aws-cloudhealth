resource "aws_s3_bucket" "cur" {
  count  = var.create_s3_cur_bucket ? 1 : 0
  bucket = var.cur_bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cur" {
  count  = var.create_s3_cur_bucket ? 1 : 0
  bucket = aws_s3_bucket.cur[0].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.s3_use_existing_kms_key ? var.s3_kms_key_arn : aws_kms_key.s3[0].arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "cur" {
  count  = var.create_s3_cur_bucket && var.s3_cur_bucket_versioning_enabled ? 1 : 0
  bucket = aws_s3_bucket.cur[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "cur" {
  count  = var.create_s3_cur_bucket ? 1 : 0
  bucket = aws_s3_bucket.cur[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "cur" {
  count = var.create_s3_cur_bucket ? 1 : 0

  bucket = aws_s3_bucket.cur[0].id
  policy = data.aws_iam_policy_document.cur_bucket_policy[0].json
}

### Cost and Usage Reports

resource "aws_cur_report_definition" "cur_report" {
  for_each = var.reports != {} ? var.reports : {}

  report_name                = each.value.report_name
  time_unit                  = each.value.time_unit
  format                     = each.value.format
  compression                = each.value.compression
  additional_schema_elements = each.value.additional_schema_elements

  s3_bucket = each.value.s3_bucket != null ? each.value.s3_bucket : local.cur_bucket_name
  s3_prefix = each.value.s3_prefix
  s3_region = each.value.s3_region

  additional_artifacts = each.value.additional_artifacts

  report_versioning = each.value.report_versioning
}

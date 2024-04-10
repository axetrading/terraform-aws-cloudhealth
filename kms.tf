resource "aws_kms_key" "s3" {
  count = var.create_s3_cur_bucket && !var.s3_use_existing_kms_key ? 1 : 0

  description = "For server-side encryption of S3 bucket"

  tags = var.tags
}

resource "aws_kms_alias" "s3" {
  count = var.create_s3_cur_bucket && !var.s3_use_existing_kms_key ? 1 : 0

  name          = var.kms_key_alias
  target_key_id = aws_kms_key.s3[0].key_id
}
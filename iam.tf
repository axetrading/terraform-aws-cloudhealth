resource "aws_iam_role" "cloudhealth_access" {
  name               = "CloudHealth-Access"
  assume_role_policy = data.aws_iam_policy_document.cloudhealth_assume_role_policy.json
  tags               = var.tags
}

resource "aws_iam_policy" "cloudhealth_read_only_policy" {
  name        = "CloudHealth-ReadOnly-Policy"
  description = "CloudHealth Billing and Reporting"
  policy      = data.aws_iam_policy_document.cloudhealth_read_only_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "cloudhealth_read_only_policy_attach" {
  role       = aws_iam_role.cloudhealth_access.name
  policy_arn = aws_iam_policy.cloudhealth_read_only_policy.arn
}

resource "aws_iam_policy" "cloudhealth_bucket_access_policy" {
  count       = var.create_s3_access_policy ? 1 : 0
  name        = "cloudhealth-bucket-access-policy"
  description = "CloudHealth Billing and Reporting"
  policy      = data.aws_iam_policy_document.cloudhealth_bucket_access.json
}

resource "aws_iam_role_policy_attachment" "cloudhealth_bucket_access_policy_attach" {
  count      = var.create_s3_access_policy ? 1 : 0
  role       = aws_iam_role.cloudhealth_access.name
  policy_arn = aws_iam_policy.cloudhealth_bucket_access_policy[0].arn
}


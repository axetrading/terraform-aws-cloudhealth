data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "cloudhealth_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::454464851268:root"]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [var.cloudhealth_external_id]
    }
  }
}

data "aws_iam_policy_document" "cloudhealth_read_only_policy_doc" {
  statement {
    actions = [
      "appstream:Describe*",
      "appstream:List*",
      "appstream:ListTagsForResource",
      "appstream:DescribeApplications",
      "appstream:DescribeImages",
      "autoscaling:Describe*",
      "cloudformation:ListStacks",
      "cloudformation:ListStackResources",
      "cloudformation:DescribeStacks",
      "cloudformation:DescribeStackEvents",
      "cloudformation:DescribeStackResources",
      "cloudformation:GetTemplate",
      "cloudfront:Get*",
      "cloudfront:List*",
      "cloudtrail:DescribeTrails",
      "cloudtrail:GetEventSelectors",
      "cloudtrail:ListTags",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "config:Get*",
      "config:Describe*",
      "config:Deliver*",
      "config:List*",
      "cur:Describe*",
      "dms:Describe*",
      "dms:List*",
      "dynamodb:DescribeTable",
      "dynamodb:List*",
      "ec2:Describe*",
      "ec2:GetReservedInstancesExchangeQuote",
      "ecs:List*",
      "ecs:Describe*",
      "eks:Describe*",
      "eks:List*",
      "elasticache:Describe*",
      "elasticache:ListTagsForResource",
      "elasticbeanstalk:Check*",
      "elasticbeanstalk:Describe*",
      "elasticbeanstalk:List*",
      "elasticbeanstalk:RequestEnvironmentInfo",
      "elasticbeanstalk:RetrieveEnvironmentInfo",
      "elasticfilesystem:Describe*",
      "elasticloadbalancing:Describe*",
      "elasticmapreduce:Describe*",
      "elasticmapreduce:List*",
      "es:List*",
      "es:Describe*",
      "firehose:ListDeliveryStreams",
      "firehose:DescribeDeliveryStream",
      "firehose:ListTagsForDeliveryStream",
      "fsx:Describe*",
      "iam:List*",
      "iam:Get*",
      "iam:GenerateCredentialReport",
      "kinesis:Describe*",
      "kinesis:List*",
      "kms:DescribeKey",
      "kms:GetKeyRotationStatus",
      "kms:ListKeys",
      "kms:ListResourceTags",
      "lambda:List*",
      "logs:Describe*",
      "logs:ListTagsLogGroup",
      "organizations:ListAccounts",
      "organizations:ListTagsForResource",
      "organizations:DescribeOrganization",
      "redshift:Describe*",
      "route53:Get*",
      "route53:List*",
      "rds:Describe*",
      "rds:ListTagsForResource",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetAccountPublicAccessBlock",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:List*",
      "sagemaker:Describe*",
      "sagemaker:List*",
      "savingsplans:DescribeSavingsPlans",
      "sdb:GetAttributes",
      "sdb:List*",
      "ses:Get*",
      "ses:List*",
      "sns:Get*",
      "sns:List*",
      "sqs:GetQueueAttributes",
      "sqs:ListQueues",
      "storagegateway:List*",
      "storagegateway:Describe*",
      "workspaces:Describe*"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudhealth_bucket_access" {
  statement {
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      "arn:aws:s3:::${local.cur_bucket_name}",
      "arn:aws:s3:::${local.cur_bucket_name}/*"
    ]
  }
  statement {
    actions = ["s3:Put*"]
    resources = [
      "arn:aws:s3:::${local.cur_bucket_name}",
      "arn:aws:s3:::${local.cur_bucket_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "cur_bucket_policy" {
  count = var.create_s3_cur_bucket ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy",
    ]
    resources = [
      "arn:aws:s3:::${local.cur_bucket_name}"
    ]
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:us-east-1:${local.account_id}:definition/*"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${local.cur_bucket_name}/*"
    ]
    principals {
      type        = "Service"
      identifiers = ["billingreports.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [local.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cur:us-east-1:${local.account_id}:definition/*"]
    }
  }
}

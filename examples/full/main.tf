module "aws_cur_reports" {
  source                  = "../.."
  cloudhealth_external_id = "1234abcd9876qwerty5678ghjkl098"
  create_s3_cur_bucket    = true
  create_s3_access_policy = true
  cur_bucket_name         = "my-cur-bucket"
  reports = {
    report1 = {
      report_name                = "MonthlyCostsReport"
      time_unit                  = "MONTHLY"
      format                     = "textORcsv"
      compression                = "GZIP"
      additional_schema_elements = ["RESOURCES"]
      s3_bucket                  = "test"
      s3_prefix                  = "reports/monthly/"
      s3_region                  = "us-east-1"
      additional_artifacts       = ["REDSHIFT", "QUICKSIGHT"]
      report_versioning          = "OVERWRITE_REPORT"
    },
    report2 = {
      report_name                = "DailyCostsReport"
      time_unit                  = "DAILY"
      format                     = "textORcsv"
      compression                = "GZIP"
      additional_schema_elements = ["RESOURCES"]
      s3_prefix                  = "reports/daily/"
      s3_region                  = "us-west-2"
      additional_artifacts       = ["REDSHIFT"]
      report_versioning          = "OVERWRITE_REPORT"
    }
  }
}
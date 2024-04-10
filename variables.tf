variable "cloudhealth_external_id" {
  description = "REQUIRED: Enter the ExternalID provided to you by CloudHealth."
  type        = string
  validation {
    condition     = length(var.cloudhealth_external_id) == 30
    error_message = "The External ID must be exactly 30 characters."
  }
}

variable "create_s3_cur_bucket" {
  description = "Flag to create the S3 bucket for AWS CUR files."
  type        = bool
  default     = false
}

variable "create_s3_access_policy" {
  description = "Flag to create the S3 policy"
  type        = bool
  default     = false
}


variable "cur_bucket_name" {
  description = "The name of the S3 bucket where AWS CUR files are saved."
  type        = string
  default     = null
}

variable "kms_key_alias" {
  description = "The alias for the KMS key."
  type        = string
  default     = null

}

variable "s3_cur_bucket_versioning_enabled" {
  description = "Flag to enable versioning on the S3 bucket for AWS CUR files."
  type        = bool
  default     = true
}

variable "s3_kms_key_arn" {
  description = "The ARN of the KMS key to use for server-side encryption."
  type        = string
  default     = null
}

variable "s3_use_existing_kms_key" {
  description = "Flag to use an existing KMS key for server-side encryption."
  type        = bool
  default     = false
}

variable "reports" {
  description = "A map of report definitions"
  type = map(object({
    report_name                = string
    time_unit                  = string
    format                     = string
    compression                = string
    additional_schema_elements = optional(list(string))
    s3_bucket                  = optional(string)
    s3_prefix                  = string
    s3_region                  = string
    additional_artifacts       = optional(list(string))
    report_versioning          = optional(string)
  }))
  default = {}
}

variable "tags" {
  description = "A map of tags to add to the resources."
  type        = map(string)
  default     = {}
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
}

variable "logging_bucket" {
  description = "The bucket where access logs are stored"
  type        = string
}

variable "kms_key_id" {
  description = "KMS Key ID to use for encryption"
  type        = string
}

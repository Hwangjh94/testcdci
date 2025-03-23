variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "kms_key_id" {
  description = "KMS Key ID for bucket encryption"
  type        = string
}

variable "logging_bucket" {
  description = "The name of the bucket to store access logs"
  type        = string
}

variable "replication_role_arn" {
  description = "IAM Role ARN for replication"
  type        = string
  default     = ""
}

variable "replica_bucket_arn" {
  description = "ARN of the destination bucket for replication"
  type        = string
  default     = ""
}

variable "notification_lambda_arn" {
  description = "ARN of Lambda function for S3 event notifications"
  type        = string
  default     = ""
}
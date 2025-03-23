# S3 Bucket with encryption, versioning, logging, and replication
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}
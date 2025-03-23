bucket_name = "secure-dev-bucket"
replica_region = "us-west-2"
replication_role_arn = "arn:aws:iam::123456789012:role/replication-role"

# modules/s3/main.tf

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "this" {
  bucket = aws_s3_bucket.this.id
  target_bucket = aws_s3_bucket.primary_log_bucket.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    id     = "expire-logs"
    status = "Enabled"
    expiration {
      days = 90
    }
    filter {}
  }
}

resource "aws_s3_bucket_replication_configuration" "this" {
  depends_on = [aws_s3_bucket_versioning.this]
  bucket = aws_s3_bucket.this.id

  role = var.replication_role_arn
  rule {
    id = "replication-rule"
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.replica_bucket.arn
      storage_class = "STANDARD"
    }
    filter {}
  }
}

resource "aws_s3_bucket" "replica_bucket" {
  count  = var.enable_replication ? 1 : 0
  bucket = "${var.bucket_name}-replica"
  tags   = var.tags
  provider = aws.replica_region
}

# modules/aws-config/main.tf

resource "aws_config_configuration_recorder" "recorder" {
  name     = "default"
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "channel" {
  name           = "default"
  s3_bucket_name = var.bucket_name
  sns_topic_arn  = var.sns_topic_arn
  depends_on     = [aws_config_configuration_recorder.recorder]
}

resource "aws_config_config_rule" "s3_public_block" {
  name = "s3-bucket-public-read-prohibited"
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
}
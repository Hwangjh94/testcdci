bucket_name     = "my-secure-bucket"
logging_bucket  = "my-logs-bucket"
kms_key_id      = "arn:aws:kms:ap-northeast-2:123456789012:key/xxxx-xxxx-xxxx"
tags = {
  env = "dev"
  owner = "yourname"
}

bucket_name            = "your-secure-bucket-name"
tags                   = { "env" = "dev" }
kms_key_id             = "arn:aws:kms:ap-northeast-2:123456789012:key/xxx"
logging_bucket         = "your-log-bucket"
replication_role_arn   = ""
replica_bucket_arn     = ""
notification_lambda_arn = ""

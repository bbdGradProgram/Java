resource "aws_s3_bucket" "liquibase-env-store" {
  bucket = var.liquibase-s3-bucket-name
}


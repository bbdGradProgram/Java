variable "username" {
  description = "The username for the database"
  type        = string
}

variable "password" {
  description = "The password for the database"
  type        = string
}

variable "postgres_version" {
  description = "The version of PostgreSQL to use"
  type        = string
  default     = "16.0"
}

variable "aws_resource_owner" {
  description = "The owner of the AWS resources"
  type        = string
}
variable "rds_instance_identifier" {
  description = "The identifier for the RDS instance"
  type        = string

}

variable "vpc-name" {
  description = "The name of the VPC"
  type        = string
  default     = "free-the-beans-vpc"
}

variable "ec2-key-name" {
  description = "Name for the key pair the ec2 instnace is to use"
  type        = string
}

variable "ec2-instance-name" {
  description = "Name for the ec2 instance"
  type        = string
}

variable "rds-db-name" {
  description = "Name for the RDS db"
  type        = string
}

variable "liquibase-s3-bucket-name" {
  description = "Name for the S3 bucket to store the liquibase changeset"
  type        = string

}
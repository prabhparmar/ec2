variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-bucket"
}

variable "domain" {
  description = "Domain name for Route53 zone"
  type        = string
  default     = "test.com"
}

variable "db_name" {
  description = "Name of the database instance"
  type        = string
  default     = "mydb"
}

variable "db_user" {
  description = "Username for the database instance"
  type        = string
  default     = "admin"
}

variable "db_pass" {
  description = "Password for the database instance"
  type        = string
  default     = "password123"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "ami" {
  description = "Amazon Machine Image ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}



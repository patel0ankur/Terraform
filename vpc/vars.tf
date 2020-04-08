variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.74.0.0/16"
}

variable "public_cidr" {
  description = "Public CIDR"
  type        = "list"
  default     = ["10.74.1.0/24", "10.74.2.0/24"]
}

variable "private_cidr" {
  description = "Private CIDR"
  type        = "list"
  default     = ["10.74.3.0/24", "10.74.4.0/24"]
}

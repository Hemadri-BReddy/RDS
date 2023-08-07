variable "aurora_cluster_sg" {
  type = string
}
variable "azs" {
  type = list
}

variable "tags" {
  type = map   # required
}
variable "aurora_cluster_identifier" {
  type = string
}
variable "aurora_engine" {
  type = string
}
variable "aurora_engine_version" {
  type = string
}
variable "database_name" {
  type = string
}
variable "database_username" {
  type = string
}
variable "database_retention_period" {
  type = number
}
variable "aurora_instance_identifier" {
  type = string
}
variable "db_instance_type" {
  type = string
}
variable "secret_name" {
  type = string
}
variable "db_subnet_group" {
  type = string
}

variable "database_subnet_cidr" {
  type = list(string)
}
variable "database_subnet_names" {
  type = list
}
variable "database_route_table_name" {
  type = string
}
variable "vpc-name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnet_names" {
  type = list
}
variable "public_subnet_cidr" {
  type = list
}
 
variable "aurora_cluster_description" {
  type = string
}
variable "aurora_cluster_cidr" {
  type = list(map(string))
  default = [ ]
}
variable "aws_access_key" {
  type = string
}
variable "aws_secret_key" {
  type = string
}
variable "skip_snapshot" {
  type = bool
}
# variable "db_storage" {
#   type = number
# }
variable "db_deleetion_protection" {
  type = bool
}
variable "kmskey_description" {
  type = string
}
variable "kmskey_deletion_period" {
  type = number
}
variable "kmskey-alias" {
  type = string
}

# SNS

variable "sns-topic" {
  type = string
}
variable "fallback-topic" {
  type = string
}
variable "has_email" {
  type    = bool
  default = false
}

variable "email" {
  type    = string
  default = ""
}

variable "has_http_endpoint" {
  type    = bool
  default = false
}

variable "http_endpoint" {
  type    = string
  default = ""
}

variable "has_https_endpoint" {
  type    = bool
  default = false
}

variable "https_endpoint" {
  type    = string
  default = ""
}

variable "has_fallback_email" {
  type    = bool
  default = false
}

variable "fallback_email" {
  type    = string
  default = ""
}
variable "cloudwatch-alarm" {
  type = string
}
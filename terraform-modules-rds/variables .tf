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





# variable "allocated_storage" {
  
# }
# variable "db_name" {
  
# }
# variable "identifier" {
  
# }
# variable "engine" {
  
# }
# variable "engine_version" {
  
# }
# variable "instance_type" {
  
# }
# variable "username" {
  
# }
# variable "db_subnet_group_name" {
  
# }
# variable "vpc_security_group_ids" {
#   type = list
# }
# # variable "secret_name" {
  
# # }
# variable "rds_secret_arn" {
#   type = string
# }



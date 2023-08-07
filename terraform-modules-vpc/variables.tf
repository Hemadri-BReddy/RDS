variable "vpc_cidr" {
  type = string
}


variable "tags" {
  type = map   # required
}
# variable "vpc_tags" {
#   type = map
#   default = {}   # optional
# }

variable "azs" {
  type = list
}

variable "public_subnet_cidr" {
  type = list
}
# variable "public_subnet_tags" {
#   type = map
#   default = {} # optional
# }
variable "public_subnet_names" {
  type = list
}
# variable "igw_tags" {
#   type = map
#   default = {}  # optional
# }
# variable "public_route_table_tags" {
#   type = map
#   default = {} # optional
# }
# variable "public_route_table_name" {
#   type = string
# }
# variable "private_subnet_cidr" {
#   type = list
# }
# variable "private_subnet_tags" {
#   type = map
#   default = {} # optional
# }
# variable "private_subnet_names" {
#   type = list
# }
# variable "Ngw_tags" {
#   type = map
#   default = {} # optional
# }
# variable "private_route_table_tags" {
#   type = map
#   default = {}  # optional
# }
# variable "private_route_table_name" {
#   type = string
# }
# variable "project" {
#   type = string
# }
# variable "vpc-cloudwatch-group" {
#   type = string
# }
# variable "vpc-flowlog-role" {
#   type = string
# }
# variable "vpc-iam-role-policy" {
#   type = string
# }
variable "vpc-name" {
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

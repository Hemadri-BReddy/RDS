# variable "public_sg_name" {
#   type = string
# }
# variable "public_sg_description" {
#   type = string
# }
# variable "ingress_cidr" {
#   type = list(map(string))
#   default = [ ]
# }
variable "aurora_cluster_sg" {
  type = string
}
variable "aurora_cluster_description" {
  type = string
}
variable "aurora_cluster_cidr" {
  type = list(map(string))
  default = [ ]
}
# variable "workernode_sg_name" {
#   type = string
# }
# variable "workernode_sg_description" {
#   type = string
# }
# variable "workernode_ingress_cidr" {
#   type = list(map(string))
#   default = [ ]
# }
# variable "control_plane_sg_name" {
#   type = string
# }
# variable "control_plane_sg_description" {
#   type = string
# }
# variable "control_plane_ingress_cidr" {
#   type = list(map(string))
#   default = [ ]
# }
variable "tags" {
  type = map
}
# variable "vpc_id" {
#   type = string
# }
variable "vpc-name" {
  type = string
}

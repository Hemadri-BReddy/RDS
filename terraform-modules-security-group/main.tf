# module "vpc" {
#   source = "../terraform-modules-vpc"
# }


# security group for eks control plane
# resource "aws_security_group" "public_sg" {
#   name =  var.public_sg_name
#   description = var.public_sg_description
#   vpc_id = data.aws_vpc.existing_vpc_id.id

#   tags = merge(var.tags,{"Name" = var.public_sg_name})
# }

# # this rule will add ingress rules to the security group

# resource "aws_security_group_rule" "public_inbound" {
#   count = length(var.ingress_cidr)  
#   type = "ingress"
#   from_port = lookup(var.ingress_cidr[count.index], "from_port")
#   to_port = lookup(var.ingress_cidr[count.index], "to_port")
#   description = lookup(var.ingress_cidr[count.index], "description")
#   cidr_blocks = [lookup(var.ingress_cidr[count.index], "cidr_block")]
#   protocol = "6" # custom TCP
#   security_group_id = aws_security_group.public_sg.id
# }

# resource "aws_security_group_rule" "public_outbound" {
#   security_group_id = aws_security_group.public_sg.id
#   type  = "egress"
#   from_port  = 0
#   to_port = 0
#   protocol = "-1" 
#   cidr_blocks = ["0.0.0.0/0"]
#   ipv6_cidr_blocks = ["::/0"]      
# }

resource "aws_security_group" "aurora_cluster_security_group" {
  name = var.aurora_cluster_sg
  vpc_id = data.aws_vpc.existing_vpc_id.id
  description = var.aurora_cluster_description

  egress {          
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {"Name"= var.aurora_cluster_sg})
}

resource "aws_security_group_rule" "aurora_database_inbound" {
  count = length(var.aurora_cluster_cidr)  
  type = "ingress"
  from_port = lookup(var.aurora_cluster_cidr[count.index], "from_port")
  to_port = lookup(var.aurora_cluster_cidr[count.index], "to_port")
  description = lookup(var.aurora_cluster_cidr[count.index], "description")
  cidr_blocks = [lookup(var.aurora_cluster_cidr[count.index], "cidr_block")]
  protocol = "6" # custom TCP
  security_group_id = aws_security_group.aurora_cluster_security_group.id
}

# resource "aws_security_group" "workernode_sg" {
#   name = var.workernode_sg_name
#   vpc_id = data.aws_vpc.existing_vpc_id.id
#   description = var.workernode_sg_description

#   egress {          
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = merge(var.tags, {"Name"= var.workernode_sg_name})
# }

# resource "aws_security_group_rule" "workernodes_inbound" {
#   count = length(var.workernode_ingress_cidr)
#   type = "ingress"
#   from_port = lookup(var.workernode_ingress_cidr[count.index], "from_port")
#   to_port = lookup(var.workernode_ingress_cidr[count.index], "to_port")
#   description = lookup(var.workernode_ingress_cidr[count.index], "description")
#   cidr_blocks = [lookup(var.workernode_ingress_cidr[count.index], "cidr_block")]
#   protocol = lookup(var.workernode_ingress_cidr[count.index], "protocol")
#   security_group_id = aws_security_group.workernode_sg.id
# }

# resource "aws_security_group" "control_plane_sg" {
#   name = var.control_plane_sg_name
#   vpc_id = data.aws_vpc.existing_vpc_id.id
#   description = var.control_plane_sg_description

#   egress {          
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = merge(var.tags, {"Name"= var.control_plane_sg_name})
# }

# resource "aws_security_group_rule" "control_plane_inbound" {
#   count = length(var.control_plane_ingress_cidr)
#   type = "ingress"
#   from_port = lookup(var.control_plane_ingress_cidr[count.index], "from_port")
#   to_port = lookup(var.control_plane_ingress_cidr[count.index], "to_port")
#   description = lookup(var.control_plane_ingress_cidr[count.index], "description")
#   cidr_blocks = [lookup(var.control_plane_ingress_cidr[count.index], "cidr_block")]
#   protocol = lookup(var.control_plane_ingress_cidr[count.index], "protocol")
#   security_group_id = aws_security_group.control_plane_sg.id
# }





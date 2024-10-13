provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  name = "multi-az-vpc"
  cidr_block = "10.0.0.0/16"
  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"
  private_subnet_1_cidr = "10.0.3.0/24"
  private_subnet_2_cidr = "10.0.4.0/24"
  az_1 = "us-east-1a"
  az_2 = "us-east-1b"
}

module "bastion" {
  source = "./modules/bastion"
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  subnet_id_az1= module.vpc.public_subnets[0]
  subnet_id_az2= module.vpc.public_subnets[1]
  security_group_id = aws_security_group.bastion_sg.id
  key_name = var.key_name

}


# module "autoscaling" {
#   source = "./modules/autoscaling"
#   launch_config_name = "nginx-launch-config"
#   image_id = "ami-0e86e20dae9224db8"
#   instance_type = "t2.micro"
#   security_group_id = aws_security_group.private_sg.id
#   key_name = var.key_name
#   min_size = 2
#   max_size = 2
#   desired_capacity = 2
#   private_subnets = module.vpc.private_subnets
# }

resource "aws_security_group" "bastion_sg" {
  name = "bastion-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.allowed_ips
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name = "private-instance-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private EC2 Instance in AZ1
resource "aws_instance" "private_instance_az1" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  subnet_id    = module.vpc.private_subnets[1]
  key_name      = "terraform-ansible"
  security_groups = [aws_security_group.private_sg.id]

  tags = {
    Name = "private-instance-az1"
  }
}
# Private EC2 Instance in AZ2
resource "aws_instance" "private_instance_az2" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"
  subnet_id    = module.vpc.private_subnets[1]
  key_name      = "terraform-ansible"
  security_groups = [aws_security_group.private_sg.id]

  tags = {
    Name = "private-instance-az2"
  }
}

# resource "local_file" "ansible_inventory" {
#   content  = templatefile("${path.module}/templates/inventory.tpl", {
#     private_ips =module.autoscaling.asg_instance_ips
#   })
#   filename = "${path.module}/ansible/workspaces/dev/inventory.ini"
# }



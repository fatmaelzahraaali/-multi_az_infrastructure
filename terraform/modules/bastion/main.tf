resource "aws_instance" "bastion_az1" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id   = var.subnet_id_az1
  security_groups = [var.security_group_id]
  key_name      = var.key_name
  tags = {
    Name = "Bastion"
  }
}

resource "aws_instance" "bastion_az2" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id    = var.subnet_id_az2
  security_groups = [var.security_group_id]
  key_name      = var.key_name
  tags = {
    Name = "Bastion"
  }
}
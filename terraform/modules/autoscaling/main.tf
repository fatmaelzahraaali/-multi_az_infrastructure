resource "aws_launch_configuration" "lc" {
  name          = var.launch_config_name
  image_id      = var.image_id
  instance_type = var.instance_type
  security_groups = [var.security_group_id]
  key_name      = var.key_name
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.lc.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.private_subnets

  tag {
    key                 = "Name"
    value               = "nginx-instance"
    propagate_at_launch = true
  }
}

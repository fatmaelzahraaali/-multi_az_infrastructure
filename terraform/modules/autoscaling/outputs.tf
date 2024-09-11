output "private_ips" {
  description = "The private IP addresses of the instances"
  value       = aws_autoscaling_group.asg.instances[*].private_ip
}

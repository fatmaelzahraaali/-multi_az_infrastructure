# # Fetch instance information using instance_ids from the Auto Scaling Group
# data "aws_instances" "asg_instances" {
#   instance_ids = aws_autoscaling_group.asg.instance_ids
# }

# # Output the private IPs of the instances in the Auto Scaling Group
# output "asg_instance_private_ips" {
#   value = data.aws_instances.asg_instances.private_ips
# }



# # data "aws_instances" "asg_instances" {
# #   instance_ip = aws_autoscaling_group.asg.private_ips
# # }
# # output "asg_instance_ips" {
# #   value = data.aws_instances.asg_instances.instance_ip
# # }

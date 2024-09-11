output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "load_balancer_dns" {
  value = aws_lb.nginx_lb.dns_name
}

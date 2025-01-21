output "web-url" {
  value = format("http://%s", aws_instance.web.public_ip)
}

output "ssh-command" {
  value = format(
    "ssh -i %s %s@%s",
    var.key_pair_info.private_key_path,
    var.web_server_info.username,
    aws_instance.web.public_ip
  )
}

# Outputs (optional)
output "vpc_id" {
  value = aws_vpc.base.id
}

output "web_subnet_ids" {
  value = aws_subnet.web[*].id
}

output "db_subnet_ids" {
  value = aws_subnet.db[*].id
}

output "web_sg_id" {
  value = aws_security_group.web.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}

output "rds_endpoint" {
  description = "The endpoint of the RDS MySQL database"
  value       = aws_db_instance.mysql_db.endpoint
}
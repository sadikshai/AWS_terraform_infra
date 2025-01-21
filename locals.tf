locals {
  anywhere         = "0.0.0.0/0"
  web_subnet_count = length(var.web_subnet)
  db_subnet_count  = length(var.db_subnet)


}
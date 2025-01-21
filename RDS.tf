resource "aws_db_subnet_group" "db_default" {
  subnet_ids = [aws_subnet.db[0].id, aws_subnet.db[1].id]
  name       = "main"
  tags = {
    Name = "My DB subnet group"
  }

}


resource "aws_db_instance" "mysql_db" {
  allocated_storage      = var.database.allocated_storage
  db_name                = var.database.db_name
  engine                 = var.database.engine
  engine_version         = var.database.engine_version
  instance_class         = var.database.instance_class
  username               = var.database.username
  password               = var.database.password
  db_subnet_group_name   = aws_db_subnet_group.db_default.id
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot    = true
  tags = {
    Name="mydatabase_sql"
  }
}
vpc_info = [{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Network"
  }
}]


web_subnet = [
  {
    cidr_block        = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "web1"
    }
  },
  {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "web2"
    }
  }
]


db_subnet = [
  {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "db1"
    }
  },
  {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name = "db2"
    }
  }
]

web_security_group = {
  description = "this is webs ecurity group"
  name        = "web-sg"
  rules = [{
    cidr_block  = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"

    },
    {
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"

  }]
}



db_security_group = {
  description = "this is db security group"
  name        = "db-sg"
  rules = [{
    cidr_block  = "10.0.0.0/16"
    from_port   = 3306
    to_port     = 3306
    ip_protocol = "tcp"

  }]
}


key_pair_info = {
  name            = "mykeypair"
  public_key_path = "~/.ssh/id_rsa.pub"
}

web_server_info = {
  ami_filter                  = {}
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  username                    = "ubuntu"
  tags = {
    Name = "webserver"
  }

}


database = {
  allocated_storage = 10
  db_name           = "my_db_mysql"
  engine            = "mysql"
  engine_version    = "8.0.34"
  instance_class    = "db.t3.micro"
  username          = "qtdevopsdb"
  password          = "qtdevopspass"
}
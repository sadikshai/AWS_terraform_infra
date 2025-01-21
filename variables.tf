variable "vpc_info" {
  type = list(object({
    cidr_block = string
    tags       = map(string)
  }))

}

variable "web_subnet" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}


variable "db_subnet" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))

}


variable "web_security_group" {
  type = object({
    name        = optional(string, "web-sg")
    description = optional(string, "this is for web security group")
    rules = list(object({
      cidr_ipv4   = optional(string, "0.0.0.0/0")
      from_port   = number
      to_port     = string
      ip_protocol = optional(string, "tcp")
    }))
  })

}



variable "db_security_group" {
  type = object({
    name        = optional(string, "db-sg")
    description = optional(string, "this is for db security group")
    rules = list(object({
      cidr_ipv4   = optional(string, "0.0.0.0/0")
      from_port   = number
      to_port     = number
      ip_protocol = optional(string, "tcp")
    }))
  })

}


variable "key_pair_info" {
  type = object({
    name             = string
    public_key_path  = optional(string, "~/.ssh/id_rsa.pub")
    private_key_path = optional(string, "~/.ssh/id_rsa")
  })

}


variable "web_server_info" {
  type = object({
    ami_filter = object({
      name  = optional(string, "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*")
      owner = optional(string, "099720109477")
    })
    associate_public_ip_address = optional(bool, true)
    instance_type               = optional(string, "t2.micro")
    username                    = optional(string, "ubuntu")
    tags                        = map(string)
  })

}



variable "build_id" {
  type    = string
  default = "1"

}


variable "database" {
  type = map(string)

}


# Terraform VPC Infrastructure Setup

This repository contains a Terraform configuration for creating and managing a Virtual Private Cloud (VPC) on AWS with associated subnets, security groups, routing, and an RDS database instance.

## Resources Provisioned

### VPC
- **AWS VPC**: A VPC with the CIDR block `10.0.0.0/16` is created.
- **Tags**: `Name = Network`

### Subnets
- **Web Subnets**: Two subnets (`10.0.0.0/24` and `10.0.1.0/24`) in availability zones `ap-south-1a` and `ap-south-1b`.
- **Database Subnets**: Two subnets (`10.0.2.0/24` and `10.0.3.0/24`) in availability zones `ap-south-1a` and `ap-south-1b`.

### Security Groups
- **Web Security Group**:
  - Allows inbound traffic for SSH (port 22) and HTTP (port 80) from `0.0.0.0/0`.
- **Database Security Group**:
  - Allows inbound traffic on MySQL (port 3306) from within the VPC (`10.0.0.0/16`).

### Networking Components
- **Internet Gateway**: Provides public internet access for web subnets.
- **NAT Gateway**: Allows private subnets to access the internet for updates and external communication.
- **Route Tables**:
  - Public route table for web subnets.
  - Private route table for database subnets.

### Compute Resources
- **Web Server Instance**:
  - AMI: Dynamically fetched based on `web_server_info.ami_filter`.
  - Instance type: `t2.micro`.
  - Publicly accessible.

### Database
- **RDS MySQL Instance**:
  - Storage: 10 GB
  - Engine: MySQL 8.0.34
  - Instance Type: `db.t3.micro`
  - Security group: `db-sg`

## Inputs

### VPC Information
```hcl
vpc_info = [{
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Network"
  }
}]
```

### Subnets
- **Web Subnets**:
```hcl
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
```

- **Database Subnets**:
```hcl
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
```

### Security Groups
- **Web Security Group Rules**:
```hcl
web_security_group = {
  description = "this is web security group"
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
```

- **Database Security Group Rules**:
```hcl
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
```

### Database Configuration
```hcl
database = {
  allocated_storage = 10
  db_name           = "my_db_mysql"
  engine            = "mysql"
  engine_version    = "8.0.34"
  instance_class    = "db.t3.micro"
  username          = "qtdevopsdb"
  password          = "qtdevopspass"
}
```

## Outputs

- **VPC ID**: `vpc_id`
- **Web Subnet IDs**: `web_subnet_ids`
- **Database Subnet IDs**: `db_subnet_ids`
- **Web Security Group ID**: `web_sg_id`
- **Database Security Group ID**: `db_sg_id`
- **Web Server URL**: `web-url`
- **SSH Command for Web Server**: `ssh-command`
- **RDS Endpoint**: `rds_endpoint`

## Usage

1. Clone the repository and navigate to the project directory.
2. Ensure Terraform is installed on your local system.
3. Configure AWS credentials for your environment.
4. Update variables as required in the `terraform.tfvars` file.
5. Initialize Terraform:
    ```bash
    terraform init
    ```
6. Validate the configuration:
    ```bash
    terraform validate
    ```
7. Plan the deployment:
    ```bash
    terraform plan
    ```
8. Apply the configuration:
    ```bash
    terraform apply
    ```
9. View outputs after successful deployment.

## Cleanup
To destroy the created infrastructure, run:
```bash
terraform destroy
```



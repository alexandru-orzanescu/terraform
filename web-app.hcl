provider "aws" {
  region = "us-east-1" // Update with your desired region
}

// Variables
variable "ami" {
  description = "The AMI to use for the EC2 instances"
  default     = "ami-0c55b159cbfafe1f0" // Amazon Linux 2 AMI, replace with your desired AMI
}

variable "instance_type" {
  description = "The type of EC2 instance"
  default     = "t2.micro" // Adjust according to your application requirements
}

variable "database_engine" {
  description = "The database engine for RDS"
  default     = "mysql" // Change to your preferred database engine
}

variable "db_instance_class" {
  description = "The instance class for the RDS databases"
  default     = "db.t2.micro" // Adjust according to your database requirements
}

variable "db_username" {
  description = "The username for the database"
  default     = "admin" // Change to your desired database username
}

variable "db_password" {
  description = "The password for the database"
  default     = "password" // Change to your desired database password
}

variable "domain_name" {
  description = "The domain name for your application"
  default     = "example.com" // Change to your desired domain name
}

// EC2 Instance Security Group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for web servers"
  
  // Allow inbound HTTPS traffic (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  // Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// EC2 Instance
resource "aws_instance" "web" {
  count         = 2 // Create two EC2 instances for high availability
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  // Tags
  tags = {
    Name = "WebServer-${count.index}"
  }
}

// RDS Database
resource "aws_db_instance" "database" {
  count                    = 2 // Create two RDS instances for high availability
  engine                   = var.database_engine
  instance_class           = var.db_instance_class
  name                     = "mydatabase-${count.index}"
  username                 = var.db_username
  password                 = var.db_password
  allocated_storage        = 20
  storage_type             = "gp2"
  backup_retention_period  = 7
  multi_az                 = true // Enable Multi-AZ deployment for high availability

  // Tags
  tags = {
    Name = "Database-${count.index}"
  }
}

// Route 53 DNS
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "web" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_instance.web.0.public_ip // Use the public IP of one of the EC2 instances
    zone_id                = aws_instance.web.0.zone_id
    evaluate_target_health = true
  }
}

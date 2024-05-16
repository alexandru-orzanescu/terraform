# terraform
Different terraform scripts

Check out different branches for different cloud providers.

## web-app.hcl

An example Terraform script to deploy a web application on EC2 instances 
with two databases configured for high availability using Amazon RDS Multi-AZ deployment.

Make sure to adjust the values of the variables and resources according to your specific requirements. 
This script deploys two EC2 instances for the web servers and two RDS database instances 
configured for high availability using Multi-AZ deployment.

To add Route 53 to the project for DNS management, you can create a Route 53 hosted zone and set up DNS records 
to route traffic to your EC2 instances.
This script will create a Route 53 hosted zone for your domain and a DNS record to route traffic to your EC2 instances. 
Make sure to replace example.com with your actual domain name and adjust other values as needed.

To restrict access to only port 443 (HTTPS) on the EC2 instances, you can define security group rules.
I've added a security group (aws_security_group.web_sg) for the EC2 instances. 
This security group allows inbound traffic on port 443 (HTTPS) from any IP address (0.0.0.0/0) and allows all outbound traffic. 
The security_groups attribute in the aws_instance resource is then set to reference this security group.
Ensure you replace example.com with your actual domain name and adjust other values as needed.

More info: https://chatgpt.com/c/7f338409-7b83-4716-bebb-2377879b74a6

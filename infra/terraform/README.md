# Production AWS Terraform

This Terraform stack provisions a production baseline for ClaimPilot Pro:

- Multi-AZ VPC with public/private subnets
- Application Load Balancer
- EC2 Auto Scaling Group (backend containers)
- Private S3 bucket for uploaded documents (encrypted + versioned)
- RDS PostgreSQL Multi-AZ
- IAM role/profile for EC2 to access S3 and CloudWatch Logs
- SNS + CloudWatch alarm for basic operational alerting

## Prerequisites

- Terraform `>= 1.6`
- AWS credentials with permissions for VPC, EC2, ALB, IAM, S3, RDS, SNS, CloudWatch
- Backend container image available in ECR (or other reachable registry)

## Usage

Create `terraform.tfvars`:

```hcl
project_name         = "claimpilot-pro"
environment          = "prod"
aws_region           = "us-east-1"
app_image            = "123456789012.dkr.ecr.us-east-1.amazonaws.com/claimpilot-backend:latest"
gemini_api_key       = "replace-me"
cors_origins         = "https://your-frontend-domain.com"
upload_cors_allowed_origins = ["https://your-frontend-domain.com"]
db_password          = "replace-me-strong-password"
alert_email          = "ops@example.com"
asg_min_size         = 2
asg_max_size         = 10
asg_desired_capacity = 2
```

Deploy:

```bash
terraform init
terraform plan
terraform apply
```

## Notes

- ALB listener is HTTP (port 80) by default in this baseline. For production internet traffic, attach ACM certificate and add HTTPS listener (443).
- `gemini_api_key` and `db_password` should be moved to AWS Secrets Manager in a hardened setup.
- RDS has deletion protection enabled and requires final snapshot on destroy.

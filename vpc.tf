module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "practice"
  cidr = "10.100.0.0/16"

  azs             = ["us-east-1a", "us-east-1b",]
  private_subnets = ["10.100.1.0/24", "10.100.2.0/24"]
  public_subnets  = ["10.100.3.0/24", "10.100.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

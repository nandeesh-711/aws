# creating a bastion instance

module "bastion_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "bastion-instance"
  ami = "ami-053b0d53c279acc90"    # ubuntu 
  associate_public_ip_address = true
  instance_type          = "t2.micro"
  key_name               = "assignment_key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.public-sg.id]   
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "Bastion Instance"
  }
}
module "app_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "app-instance"
  ami = "ami-053b0d53c279acc90"    #ubuntu instance
  instance_type          = "t2.micro"
  key_name               = "assignment_key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "App Instance"
  }
}

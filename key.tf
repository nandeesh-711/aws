resource "aws_key_pair" "assignment_key" {
  key_name   = "assignment_key"
  public_key = tls_private_key.assignmenttf.public_key_openssh
}

# private key which is stored in local repository
resource "tls_private_key" "assignmenttf" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# To store the private file in local
resource "local_file" "Terraform-key" {
    content  = tls_private_key.assignmenttf.private_key_pem
    filename = "terraformkey"

}

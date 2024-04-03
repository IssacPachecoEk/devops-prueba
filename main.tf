module "ec2" {
  source        = "./modulos/ec2"
  instance_type = "t2.micro"
  # key_name      = ""
  # providers = {
  #   aws.root = aws
  #   aws.prod = aws.prod
  #   aws.dev  = aws.dev
  # }
}

resource "aws_key_pair" "deployer" {
  key_name   = "key_pair_andrei"
  public_key = ""
}

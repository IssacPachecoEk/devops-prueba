# obtiene el par de llaves para conectarse al ec2 mediante el archivo .pem  
data "aws_key_pair" "key_ec2" {
  key_ec2 = "key_ec2"
}
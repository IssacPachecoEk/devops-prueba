# obtiene el par de llaves para conectarse al ec2 mediante el archivo .pem  
data "aws_key_pair" "key_ec2" {
  key_ec2 = "key_ec2"
}
# obtiene todas las zonas de disponibilidad
data "aws_availability_zones" "zonas_disponibles" {
  all_availability_zones = true
}
  # obtiene los valores de la zona de disponibilidad de la region
data "aws_availability_zone" "zona_disponible" {
  for_each = toset(data.aws_availability_zones.zonas_disponibles.names)
  name     = each.value
}
resource "aws_instance" "instancia_ec2_web_devops" {
  ami           = var.ami_instancia_ec2 
  instance_type = var.tipo_instancia_ec2

  # declaro una condicional para saber si le asigno todas las zonas de dispobilidad de la region o en especifico algunas
  availability_zone ?: var.todas_zonas_disponibles == true ? local.mapeo_zonas_todas : var.mapeo_zonas_especificas
  
  tags = {
    Name = "devops-prueba-${local.tag_recurso_sufijo}"
    fecha_creado = timestamp(var.tags_general.fecha)
    version = var.tags_general.version
  }
}
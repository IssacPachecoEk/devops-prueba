# este local es usado como sufijo para todos los tags de cada recurso
locals {
  tag_recurso_sufijo = "${var.tags_general.proyecto}-${var.tags_general.ambiente}-${var.tags_general.region}"
}
# declaro este recurso para obtener un valor aleatorio como sufijo para el nombre del s3
resource "random_string" "sufijo_s3" {
  length  = 8
  special = false
  upper   = false
}
# este local sirve para concatenar el nombre del proyecto y valor generado de forma aleatoria con la fecha, 
# para el nombre del bucket s3 (usando una función que convirte el valor de cadena a fecha)
locals {
  s3_sufijo = "${var.tags_general.Proyecto}-${random_string.sufijo_s3.id}-${timestamp(var.tags_general.fecha)}"
}
 # toma todas los nombre y id de las zonas de disponibilidad y lo asigna mediante un for en un map
locals {
    mapeo_zonas_todas = {
      for zone in data.aws_availability_zone.zona_disponible :
      zone.name => zone.zone_id
    }
  }
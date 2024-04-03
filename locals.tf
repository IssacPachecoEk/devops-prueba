locals {
  # toma todas los nombre y id de las zonas de disponibilidad y lo asigna mediante un for en un map  
  mapeo_zonas_todas = {
    for zone in data.aws_availability_zone.zona_disponible :
    zone.name => zone.zone_id
  }
  # este sirve para concatenar el nombre del proyecto, ambiente y region
  bucket_name_sufijo = "${local.proyecto}-${local.ambiente}-${local.region["virginia"]}"
  proyecto           = "devops_prueba"
  ambiente           = "dev"
  region = {
    "virginia" = "us-east-1",
    "ohio"     = "us-east-2"
  }
  alias = {
    "virginia" = "east-1",
    "ohio"     = "east-2"
  }
  version = "1.0.0"
  common_tag = {
    proyecto = local.proyecto
    ambiente = local.ambiente
    region   = local.region["virginia"]
    alias    = local.alias["virginia"]
    version  = local.version
  }
}

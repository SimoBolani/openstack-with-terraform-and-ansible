terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.54"
    }
  }
}

# Grâce au clouds.yaml, aucune info sensible n’apparaît ici
provider "openstack" {
  cloud = "openstack"     
}

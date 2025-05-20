data "openstack_images_image_v2" "bionic" {
  name = "bionic-server"
}

data "openstack_compute_flavor_v2" "m1_small" {
  name = "m1.small"
}

data "openstack_networking_network_v2" "flat_lan_1" {
  name = "flat-lan-1-net"
}


resource "openstack_compute_keypair_v2" "votrenome_keypair" {
  name       = "votrenome-keypair"
  public_key = file("name_of_file.pub")
}


resource "openstack_compute_instance_v2" "votrenome_vm" {
  name            = "votrenome-vm"
  image_id        = data.openstack_images_image_v2.bionic.id
  flavor_id       = data.openstack_compute_flavor_v2.m1_small.id
  key_pair        = openstack_compute_keypair_v2.votrenome_keypair.name
  security_groups = ["default"]

  network {
    uuid = data.openstack_networking_network_v2.flat_lan_1.id
  }
}


resource "openstack_networking_floatingip_v2" "votrenome_fip" {
  pool = "public"       
}

resource "openstack_compute_floatingip_associate_v2" "fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.votrenome_fip.address
  instance_id = openstack_compute_instance_v2.votrenome_vm.id
}

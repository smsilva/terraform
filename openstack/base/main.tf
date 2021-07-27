resource "openstack_compute_keypair_v2" "silvios" {
  name       = "silvios"
  public_key = file("/home/silvios/.ssh/id_rsa.pub")
}

resource "openstack_images_image_v2" "ubuntu" {
  name             = "ubuntu-20.04"
  image_source_url = "https://cloud-images.ubuntu.com/focal/20210720/focal-server-cloudimg-amd64.img"
  container_format = "bare"
  disk_format      = "qcow2"
  min_disk_gb      = 20
  min_ram_mb       = 2048
}

resource "openstack_compute_instance_v2" "server_1" {
  name            = "server-01"
  image_id        = data.openstack_images_image_v2.cirros.id
  flavor_id       = data.openstack_compute_flavor_v2.m1_tinny.flavor_id
  key_pair        = openstack_compute_keypair_v2.silvios.name
  security_groups = ["default"]

  network {
    name = data.openstack_networking_network_v2.internal.name
  }
}

resource "openstack_compute_instance_v2" "server_2" {
  name            = "server-02"
  image_id        = openstack_images_image_v2.ubuntu.id
  flavor_id       = data.openstack_compute_flavor_v2.m2_medium.flavor_id
  key_pair        = openstack_compute_keypair_v2.silvios.name
  security_groups = ["default"]

  network {
    name = openstack_networking_network_v2.network_1.name
  }

  depends_on = [
    openstack_networking_subnet_v2.subnet_1,
    openstack_networking_router_interface_v2.router_1_interface_1,
    openstack_compute_floatingip_v2.floatingip_2
  ]
}

resource "openstack_compute_floatingip_v2" "floatingip_1" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_compute_floatingip_v2" "floatingip_2" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_compute_floatingip_v2" "floatingip_3" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_compute_floatingip_associate_v2" "floatingip_1_server_1" {
  floating_ip = openstack_compute_floatingip_v2.floatingip_1.address
  instance_id = openstack_compute_instance_v2.server_1.id
}

resource "openstack_compute_floatingip_associate_v2" "floatingip_2_server_2" {
  floating_ip = openstack_compute_floatingip_v2.floatingip_2.address
  instance_id = openstack_compute_instance_v2.server_2.id

  depends_on = [
    openstack_networking_router_interface_v2.router_1_interface_1
  ]
}

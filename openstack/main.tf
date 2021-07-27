data "openstack_compute_flavor_v2" "m1_tinny" {
  vcpus = 1
  ram   = 512
}

data "openstack_compute_flavor_v2" "m2_medium" {
  vcpus = 2
  ram   = 4096
}

data "openstack_images_image_v2" "cirros" {
  name        = "cirros"
  most_recent = true

  properties = {
    key = "value"
  }
}

data "openstack_networking_network_v2" "internal" {
  name = "test"
}

data "openstack_networking_network_v2" "public" {
  name = "external"
}

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

  metadata = {
    this = "that"
  }

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

  metadata = {
    this = "that"
  }

  network {
    name = openstack_networking_network_v2.network_1.name
  }

  depends_on = [
    openstack_networking_subnet_v2.subnet_1,
    openstack_compute_floatingip_v2.floatingip_2,
    openstack_networking_router_interface_v2.router_1_interface_1
  ]
}

resource "openstack_compute_floatingip_v2" "floatingip_1" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_compute_floatingip_v2" "floatingip_2" {
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

resource "openstack_networking_network_v2" "network_1" {
  name           = "network_1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = "subnet_1"
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = "192.168.223.0/24"
  ip_version = 4
}

resource "openstack_networking_router_v2" "router_1" {
  name                = "my_router"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public.id
}

resource "openstack_networking_router_interface_v2" "router_1_interface_1" {
  router_id = openstack_networking_router_v2.router_1.id
  subnet_id = openstack_networking_subnet_v2.subnet_1.id
}

resource "openstack_compute_keypair_v2" "silvios" {
  name       = "silvios"
  public_key = file("/home/silvios/.ssh/id_rsa.pub")
}

resource "openstack_images_image_v2" "ubuntu_focal_server" {
  name             = "focal-server-cloudimg-amd64"
  image_source_url = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
  container_format = "bare"
  disk_format      = "qcow2"
  min_disk_gb      = 20
  min_ram_mb       = 2048
}

resource "openstack_compute_instance_v2" "server_1" {
  name            = "demo-01"
  image_id        = openstack_images_image_v2.ubuntu_focal_server.id
  flavor_id       = data.openstack_compute_flavor_v2.medium.flavor_id
  key_pair        = openstack_compute_keypair_v2.silvios.name
  security_groups = ["default"]

  network {
    name = data.openstack_networking_network_v2.private.name
  }
}

resource "openstack_compute_floatingip_v2" "floatingip_1" {
  pool = data.openstack_networking_network_v2.public.name
}

resource "openstack_compute_floatingip_associate_v2" "floatingip_1_server_1" {
  floating_ip = openstack_compute_floatingip_v2.floatingip_1.address
  instance_id = openstack_compute_instance_v2.server_1.id
}

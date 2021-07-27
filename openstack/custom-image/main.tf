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

resource "openstack_compute_floatingip_v2" "floatingip_1" {
  pool = data.openstack_networking_network_v2.public.name
}

data "template_file" "packer" {
  template = file("${path.module}/packer.tpl")
  vars = {
    image_id             = "${openstack_images_image_v2.ubuntu.id}"
    network_internal_id  = "${data.openstack_networking_network_v2.internal.id}"
    ssh_keypair_name     = "${openstack_compute_keypair_v2.silvios.name}"
    ssh_private_key_file = "/home/silvios/.ssh/id_rsa"
    floating_ip_id       = "${openstack_compute_floatingip_v2.floatingip_1.id}"
    floating_ip_address  = "${openstack_compute_floatingip_v2.floatingip_1.address}"
  }
}

resource "local_file" "packer_json_file" {
  content         = data.template_file.packer.rendered
  filename        = "${path.module}/packer.json"
  file_permission = "0644"
}

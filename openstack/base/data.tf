data "openstack_compute_flavor_v2" "medium" {
  vcpus = 2
  ram   = 4096
  name  = "m1.medium"
}

data "openstack_images_image_v2" "ubuntu" {
  name        = "ubuntu"
  most_recent = true
}

data "openstack_networking_network_v2" "public" {
  name = "public"
}

data "openstack_networking_network_v2" "private" {
  name = "private"
}

data "openstack_networking_subnet_v2" "private_subnet" {
  name = "private-subnet"
}

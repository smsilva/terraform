variable "subnet-map" {
  default = {
    ec2 = [
      {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "eu-west-1a"
      }
    ],
    lambda = [
      {
        cidr_block        = "10.0.5.0/24"
        availability_zone = "eu-west-1a"
      },
      {
        cidr_block        = "10.0.6.0/24"
        availability_zone = "eu-west-1b"
      },
      {
        cidr_block        = "10.0.7.0/24"
        availability_zone = "eu-west-1c"
      }
    ],
    secrets = [
      {
        cidr_block        = "10.0.8.0/24"
        availability_zone = "eu-west-1a"
      },
      {
        cidr_block        = "10.0.9.0/24"
        availability_zone = "eu-west-1b"
      },
      {
        cidr_block        = "10.0.10.0/24"
        availability_zone = "eu-west-1c"
      }
    ],
    rds = [
      {
        cidr_block        = "10.0.11.0/24"
        availability_zone = "eu-west-1a"
      },
      {
        cidr_block        = "10.0.12.0/24"
        availability_zone = "eu-west-1b"
      },
      {
        cidr_block        = "10.0.13.0/24"
        availability_zone = "eu-west-1c"
      }
    ]
  }
}

locals {
  subnets = flatten([
    for resource in keys(var.subnet-map) : [
      for subnet in var.subnet-map[resource] : {
        resource          = resource
        cidr_block        = subnet.cidr_block
        availability_zone = subnet.availability_zone
      }
    ]
  ])
}

output "subnets-1" {
  value = var.subnet-map
}

output "subnets-2" {
  value = local.subnets
}

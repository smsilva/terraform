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

  subnets_map = {
    for subnet in local.subnets : "${subnet.resource}:${subnet.availability_zone}" => subnet
  }
}

output "subnets-1" {
  value = var.subnet-map
}

output "subnets-2" {
  value = local.subnets
}

output "subnets-3" {
  value = local.subnets_map
}

# https://www.terraform.io/docs/language/meta-arguments/for_each.html#chaining-for_each-between-resources
# https://stackoverflow.com/questions/57570505/terraform-how-to-use-for-each-loop-on-a-list-of-objects-to-create-resources

# resource "aws_subnet" "subnets-dev" {
#   for_each          = local.subnets_map
#   vpc_id            = aws_vpc.vpc-dev.id
#   cidr_block        = each.value.cidr_block
#   availability_zone = each.value.availability_zone

#   tags = {
#     Name        = "subnet-dev-${each.value.resource}-${each.value.availability_zone}"
#     environment = "dev"
#   }
# }

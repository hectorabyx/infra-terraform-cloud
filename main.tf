# Copyright (c) Hector.
# SPDX-License-Identifier: MPL-2.0

# The following configuration uses a provider which provisions [] resources
# to a fictitious cloud vendor called " Web Services". Configuration for
# the webservices provider can be found in provider.tf.
#
# After running the setup script (./scripts/setup.sh), feel free to change these
# resources and 'terraform apply' as much as you'd like! These resources are
# purely for demonstration and created in Terraform Cloud, scoped to your TFC
# user account.
#
# To review the provider and documentation for the available resources and
# schemas, see: https://registry.terraform.io/providers/hashicorp/webservices
#
# If you're looking for the configuration for the remote backend, you can find that
# in backend.tf.


resource "webservices_vpc" "primary_vpc" {
  name       = "Primary VPC"
  cidr_block = "0.0.0.0/1"
}

resource "webservices_server" "servers" {
  count = 2

  name = "Server ${count.index + 1}"
  type = "t2.micro"
  vpc  = webservices_vpc.primary_vpc.name
}

resource "webservices_load_balancer" "primary_lb" {
  name    = "Primary Load Balancer"
  servers = webservices_server.servers[*].name
}

resource "webservices_database" "prod_db" {
  name = "Production DB"
  size = 256
}

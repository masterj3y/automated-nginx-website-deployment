terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.38.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token  
}

resource "digitalocean_ssh_key" "website_ssh_key" {
  name = "website-key"
  public_key = file("~/.ssh/id_ed25519_nginx.pub")
}

resource "digitalocean_droplet" "website_server" {
  image = "debian-12-x64"
  name = "website-server"
  region = "fra1"
  size = "s-1vcpu-512mb-10gb"
  ssh_keys = [digitalocean_ssh_key.website_ssh_key.fingerprint]

  tags = ["app-server", "website"]
}

resource "digitalocean_firewall" "website_fw" {
  name = "website-only-22-80-443"

  droplet_ids = [digitalocean_droplet.website_server.id]

  inbound_rule {
    protocol = "tcp"
    port_range = 22
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = 80
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol = "tcp"
    port_range = 443
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = 22
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = 80
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = 443
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "null_resource" "configure_server" {
  triggers = {
    website_server_ip = digitalocean_droplet.website_server.ipv4_address
  }

  provisioner "local-exec" {
    working_dir = "../"
    command = "ansible-playbook playbook.yaml"
  }
}

output "droplet_output"{
  description = "website server IPv4 address"
  value = digitalocean_droplet.website_server.ipv4_address
}

variable "allowed_ips" {
  type = list(string)
}

data "hcloud_location" "default" {
  name = "fsn1"
}

resource "hcloud_ssh_key" "u_bora" {
  name       = "u-bora"
  public_key = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJV7//jF3nZUwHyuE8D2uRkL1k+q8ym5QWl0rO9WlHlGHaOG6paD/LqA6pKulYUxMWArbfu5wUin/yYwwN2ISc0= bora@secretive.colt.local"
}

resource "hcloud_floating_ip" "public_ipv4" {
  name              = "public_ipv4"
  type              = "ipv4"
  home_location     = data.hcloud_location.default.name
  delete_protection = true
  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_floating_ip" "public_ipv6" {
  name              = "public_ipv6"
  type              = "ipv6"
  home_location     = data.hcloud_location.default.name
  delete_protection = true
  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_firewall" "default" {
  name = "default-firewall"

  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = 22
    source_ips = var.allowed_ips 
  }
}

resource "hcloud_server" "singularity" {
  name         = "singularity"
  image        = "ubuntu-24.04"
  server_type  = "cx43"
  location     = data.hcloud_location.default.name
  ssh_keys     = [
    hcloud_ssh_key.u_bora.id,
  ]
  firewall_ids = [
    hcloud_firewall.default.id,
  ]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

resource "hcloud_floating_ip_assignment" "public_ipv4_singularity" {
  floating_ip_id = hcloud_floating_ip.public_ipv4.id
  server_id      = hcloud_server.singularity.id
}

resource "hcloud_floating_ip_assignment" "public_ipv6_singularity" {
  floating_ip_id = hcloud_floating_ip.public_ipv6.id
  server_id      = hcloud_server.singularity.id
}

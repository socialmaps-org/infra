# Terraform &mdash; socialmaps.org Infrastructure

## Instructions
1. Create a `secrets.auto.tfvars` file with the following variables:
   1. `hcloud_token` \[string] &mdash; Hetzner Cloud API token. See the docs on how to [generate an API token](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/).
   2. `allowed_ips` \[list(string)] &mdash; List of IP addresses that are allowed by [Hetzner Cloud Firewall](https://docs.hetzner.com/cloud/firewalls/overview) to connect to the host(s) via SSH on port 22.

### Example
```tf
hcloud_token = "0123456789012345678901234567890123456789012345678901234567890123"
allowed_ips  = [
    "203.0.113.0",
    "2001:DB8::/48"
]
```

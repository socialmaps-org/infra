# socialmaps.org infra

* [secretive](https://secretive.dev/) for protecting SSH keys.
* [OpenTofu](https://opentofu.org/) and [tflint](https://github.com/terraform-linters/tflint).
* [Ansible](https://docs.ansible.com/) and [Ansible Lint](https://ansible.readthedocs.io/projects/lint/)
* [Hetzner](https://www.hetzner.com/) for compute.

## Server initialisation

### 1. Create a non-root user
```bash
# Add user
adduser john

# Copy the authorised client key
mkdir -p /home/john/.ssh/
cp .ssh/authorized_keys /home/john/.ssh/authorized_keys

chown -R john:john /home/john/.ssh

# Add user to sudoers
usermod -aG sudo john
```

### Setup Ansible
```bash
sudo apt install direnv pipx
pipx install --include-deps ansible
```

also append `eval "$(direnv hook bash)"` to the end of the `~/.bashrc`.

### 2. Setup Docker
```bash
sudo apt install docker.io docker-cli
```

### 3. Setup Caddy
```bash
sudo apt install caddy
```

Edit `/etc/caddy/Caddyfile`:

```
auth.socialmaps.org {
    reverse_proxy 127.0.0.1:8080
}
```

Reload:

```bash
sudo systemctl reload caddy
```

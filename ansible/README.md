# Ansible &mdash; socialmaps.org Infrastructure

## Instructions
1. Create an `inventory.yaml` file with a host named `singularity`:
   1. Add its IP address as `ansible_host`.
   2. Set its `ansible_user` to `root`.
2. Create an `.envrc` file for autoloading the following environment variables using [direnv](https://direnv.net/):
   1. `OSM_CLIENT_ID` &mdash; Client ID of the [OAuth 2 application of OpenStreetMap](https://www.openstreetmap.org/oauth2/applications)
   2. `OSM_CLIENT_SECRET` &mdash; Client secret of the OAuth 2 application of OpenStreetMap
   3. `ADMIN_PASSWORD` &mdash; Password of the `admin` user of Keycloak for manual access
   4. `SOCIALMAPS_API_CLIENT_SECRET` &mdash; Client secret of api.socialmaps.org as an OAuth 2 application of auth.socialmaps.org for introspecting access tokens


### Sample `inventory.yaml`
```yaml
all:
  hosts:
    singularity:
      ansible_host: 203.0.113.0
      ansible_user: root
```

### Sample `.envrc`
```sh
export OSM_CLIENT_ID='MA-0123456789012345678901234567890123456789'
export OSM_CLIENT_SECRET='0123456789012345678901234567890123456789012'

export ADMIN_PASSWORD='01234567890123456789012345678901'

export SOCIALMAPS_API_CLIENT_SECRET='01234567890123456789012345678901'
```

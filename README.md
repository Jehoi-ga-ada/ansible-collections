# ansible-collections

Sets up the server (`domainesia-devops`) from scratch: Tailscale, Docker, firewall, Caddy, Komodo.

## Before you start

- `domainesia-devops` must be in your `~/.ssh/config`.
- You need the vault password.

```sh
ansible-galaxy install -r requirements.yml
```

## Run, in order

1. Create the `ansible` user and copy your SSH key (asks for the root password):

   ```sh
   ./scripts/geninstall_key.sh
   ```

2. Install Tailscale:

   ```sh
   ansible-playbook playbooks/bootstrap.yml --ask-vault-pass
   ```

3. Install Docker, firewall, Caddy and Komodo:

   ```sh
   ansible-playbook playbooks/komodo.yml --ask-vault-pass
   ```

Komodo is then at https://komodo.int.fronesis.id (Tailscale only).

## Secrets

Secrets are in `inventory/group_vars/*/vault.yml`, encrypted.

```sh
ansible-vault edit inventory/group_vars/komodo/vault.yml
```

New setup: copy `inventory/group_vars/komodo/vault.example.yml` to `vault.yml`, fill it in, then run `ansible-vault encrypt` on it.

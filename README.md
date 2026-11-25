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

   This also adds a 2 GB swap file (`roles/swap`).

Komodo is then at https://komodo.int.fronesis.id (Tailscale only).

## Swap only

The server has 2 GB RAM. Without swap it stalls under memory pressure (Komodo "unreachable" alerts,
502s from the apps). To add or fix only the swap file:

```sh
ansible-playbook playbooks/swap.yml --ask-vault-pass
```

Size and swappiness: `roles/swap/defaults/main.yml`. Check it worked: `cat /proc/pressure/memory`
on the server (`full avg10` near 0).

## Secrets

Secrets are in `inventory/group_vars/*/vault.yml`, encrypted.

```sh
ansible-vault edit inventory/group_vars/komodo/vault.yml
```

New setup: copy `inventory/group_vars/komodo/vault.example.yml` to `vault.yml`, fill it in, then run `ansible-vault encrypt` on it.

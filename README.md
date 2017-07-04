# ansible-role-sensu-api

Configures `sensu-api`.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `sensu_api_user` | user name of `sensu-api` | `{{ __sensu_api_user }}` |
| `sensu_api_group` | group name of `sensu-api` | `{{ __sensu_api_group }}` |
| `sensu_api_service` | service name of `sensu-api` | `{{ __sensu_api_service }}` |
| `sensu_api_config_dir` | path to configuration directory | `{{ __sensu_api_config_dir }}` |
| `sensu_api_config_file` | path to `config.json` | `{{ sensu_api_config_dir }}/config.json` |
| `sensu_api_conf_d_dir` | path to `conf.d` directory | `{{ sensu_api_config_dir }}/conf.d` |
| `sensu_api_extensions_dir` | path to `extensions` directory | `{{ sensu_api_config_dir }}/extensions` |
| `sensu_api_plugins_dir` | path to `plugins` directory | `{{ sensu_api_config_dir }}/plugins` |
| `sensu_api_flags` | not used yet | `""` |
| `sensu_api_config` | YAML representation of `config.json` | `{}` |
| `sensu_api_config_fragments` | YAML representation of JSON files under `conf.d` | `{}` |


## FreeBSD

| Variable | Default |
|----------|---------|
| `__sensu_api_user` | `sensu` |
| `__sensu_api_group` | `sensu` |
| `__sensu_api_service` | `sensu-api` |
| `__sensu_api_config_dir` | `/usr/local/etc/sensu` |

# Dependencies

- reallyenglish.freebsd-repos (FreeBSD only)

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-sensu-api
  vars:
    freebsd_repos:
      sensu:
        enabled: "true"
        url: https://sensu.global.ssl.fastly.net/freebsd/FreeBSD:10:amd64/
        mirror_type: srv
        signature_type: none
        priority: 100
        state: present
    sensu_api_config_fragments:
      transport:
        transport:
          name: rabbitmq
          reconnect_on_error: true
      api:
        api:
          host: "{{ ansible_default_ipv4.address }}"
          bind: "{{ ansible_default_ipv4.address }}"
          port: 4242
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)

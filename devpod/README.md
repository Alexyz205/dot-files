# Devpod configuration
| NAME                        | DEFAULT | VALUE                                     |
|-----------------------------|---------|-------------------------------------------|
| AGENT_INJECT_TIMEOUT         | 20      |                                          |
| AGENT_URL                    |         |                                          |
| DOTFILES_SCRIPT              |         | devpod/setup                             |
| DOTFILES_URL                 |         | git@github.com:Alexyz205/dotfiles.git    |
| EXIT_AFTER_TIMEOUT           | true    |                                          |
| GIT_SSH_SIGNATURE_FORWARDING | true    |                                          |
| GPG_AGENT_FORWARDING         | false   |                                          |
| REGISTRY_CACHE               |         |                                          |
| SSH_ADD_PRIVATE_KEYS         | true    |                                          |
| SSH_AGENT_FORWARDING         | true    |                                          |
| SSH_CONFIG_PATH              |         |                                          |
| SSH_INJECT_DOCKER_CREDENTIALS| true    |                                          |
| SSH_INJECT_GIT_CREDENTIALS   | true    | true                                     |
| TELEMETRY                    | true    |                                          |
# Default .devcontainer.json
```json
{
  "image": "mcr.microsoft.com/devcontainers/base:debian", 
  "features": {
    "ghcr.io/devcontainers/features/nix:1": {}
  }
}
```

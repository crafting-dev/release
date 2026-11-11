# Release Artifacts

This repository contains information about released artifacts.
In most cases, the Crafting CLI will automatically discover and download.

## Releases

There are releases from different schedules pushed with prefixes accordingly:
- `cs-`: the Crafting CLI releases;
- `jetbrains-`: the Crafting Jetbrains plugin.

The `latest` release is set for the CLI.

## Install CLI

A quick simple command:

```sh
curl -sSL https://raw.githubusercontent.com/crafting-dev/release/refs/heads/master/scripts/install-cli.sh | bash
```

Or use the following direct links:

- For Mac OS Apple Silicon (ARM64)

  ```sh
  curl -sSfL https://github.com/crafting-dev/release/releases/latest/download/cs-darwin-arm64.tar.gz | sudo tar -C /usr/local/bin -xz
  ```

- For Mac OS Intel

  ```sh
  curl -sSfL https://github.com/crafting-dev/release/releases/latest/download/cs-darwin-amd64.tar.gz | sudo tar -C /usr/local/bin -xz
  ```

- For Linux x86_64

  ```sh
  curl -sSfL https://github.com/crafting-dev/release/releases/latest/download/cs-linux-amd64.tar.gz | sudo tar -C /usr/local/bin -xz
  ```

- For Linux ARM64

  ```sh
  curl -sSfL https://github.com/crafting-dev/release/releases/latest/download/cs-linux-arm64.tar.gz | sudo tar -C /usr/local/bin -xz
  ```

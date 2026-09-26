# Data model

Configuration under `config/` describes version control resources without naming a platform.
A platform module under `modules/` maps it onto that platform's resources.
`config/org.yaml` selects the platform, and `main.tf` wires the config into the matching module.

## `config/org.yaml`

| Field      | Meaning                                                        |
| ---------- | -------------------------------------------------------------- |
| `platform` | Platform module to use. `github` is the only one implemented.  |
| `owner`    | Organization, group, or user that owns the repositories.       |

## `config/repos/<name>.yaml`

The file name is the repository name.
Every field is optional, and defaults match what GitHub gives a new repository.

| Field                          | Type                           | Default   |
| ------------------------------ | ------------------------------ | --------- |
| `description`                  | string                         | `""`      |
| `visibility`                   | `public`, `private`, `internal`| `private` |
| `topics`                       | list of strings                | `[]`      |
| `default_branch`               | string                         | `main`    |
| `archived`                     | bool                           | `false`   |
| `features.issues`              | bool                           | `true`    |
| `features.wiki`                | bool                           | `true`    |
| `features.projects`            | bool                           | `true`    |
| `merge.squash`                 | bool                           | `true`    |
| `merge.merge`                  | bool                           | `true`    |
| `merge.rebase`                 | bool                           | `true`    |
| `merge.delete_branch_on_merge` | bool                           | `false`   |

Settings with no equivalent on other platforms go under a key named after the platform, so the rest of the file stays portable:

| Field                    | Type   | Default |
| ------------------------ | ------ | ------- |
| `github.homepage_url`    | string | unset   |
| `github.has_discussions` | bool   | `false` |
| `github.is_template`     | bool   | `false` |

## Adding a platform

A new module under `modules/<platform>/` accepts the same `repositories` variable and ignores the keys of other platforms.
`main.tf` adds a module call for it, and the `platform` check accepts the new value.

## Removing a repository

Deleting a file archives the repository (`archive_on_destroy`) rather than deleting it.

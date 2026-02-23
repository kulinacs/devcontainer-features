# Knative CLI (knative)

Installs the Knative CLI (kn).

## Example Usage

```json
"features": {
    "ghcr.io/kulinacs/devcontainer-features/knative:1": {}
}
```

## Options

| Options Id        | Description                                                                                   | Type    | Default Value |
| ----------------- | --------------------------------------------------------------------------------------------- | ------- | ------------- |
| version           | The version of the Knative CLI (kn) to install.                                               | string  | 1.21.0        |
| includeQuickstart | Include the Knative Quickstart plugin. The plugin version will match the Knative CLI version. | boolean | false         |

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/kulinacs/devcontainer-features/blob/main/src/knative/devcontainer-feature.json). Add additional notes to a `NOTES.md`._

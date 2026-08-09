# AVM Terraform module template

This repository is the seed template for new Azure Verified Modules Terraform repositories. It contains a minimal AzAPI module that creates one resource group, one runnable example, and focused unit tests.

Most governance-managed files are intentionally excluded from this template. Running `avm pre-commit` adds or updates the current managed files and applies the standard authoring transforms.

The template retains the standard `enable_telemetry` input, but its implementation is added by the authoring transforms when `avm pre-commit` runs.

```powershell
Install-PSResource -Name Avm.Authoring -Repository PSGallery -Scope CurrentUser -TrustRepository
Import-Module Avm.Authoring
avm pre-commit
```

The generated repository README will replace this file.

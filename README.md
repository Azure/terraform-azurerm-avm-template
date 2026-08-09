# AVM Terraform module template

This repository is the seed template for new Azure Verified Modules Terraform repositories. It contains a minimal AzAPI module that creates one resource group, one runnable example, and focused unit tests.

Governance-managed files are intentionally excluded. Run the AVM repository sync workflow immediately after creating a repository from this template to add the current workflows, policies, contributor guidance, tooling configuration, and agent skills.

The template retains the standard `enable_telemetry` input, but telemetry implementation is added by the AVM authoring transforms after repository sync.

After the initial sync, import the released `Avm.Authoring` PowerShell module and run:

```powershell
avm pre-commit
```

The generated repository README will replace this file.

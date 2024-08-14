# This is required for most resource modules
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the disk encryption set."
}

variable "location" {
  type        = string
  nullable    = false
  description = "Azure region where the resource should be deployed."
}


variable "name" {
  description = "The name of the disk encryption set."
  type        = string
}

variable "key_vault_key_id" {
  description = "The Key Vault Key ID used for encryption."
  type        = string
}

variable "managed_hsm_key_id" {
  description = "The Managed HSM Key ID used for encryption."
  type        = string
  default     = null # Optional: Set to an empty string if not using Managed HSM
}

variable "auto_key_rotation_enabled" {
  description = "Whether or not auto key rotation is enabled for the encryption set."
  type        = bool
  default     = false
}

variable "encryption_type" {
  description = "The type of encryption to be used. Allowed Values are'EncryptionAtRestWithCustomerKey', 'EncryptionAtRestWithPlatformAndCustomerKeys' and 'ConfidentialVmEncryptedWithCustomerKey'."
  type        = string
  default     = "EncryptionAtRestWithCustomerKey" # Optional: Adjust default value based on your requirements
}

  variable "federated_client_id" {
  description = " Multi-tenant application client id to access key vault in a different tenant."
  type        = string
  default     = null # Optional: Set to an empty string if not using a federated service principal
}

variable "identity_type" {
  description = "The type of identity to use for the disk encryption set."
  type        = string
  default     = "SystemAssigned" # Optional: Adjust default value based on your requirements
}

variable "identity_ids" {
  description = "A list of user-assigned identity IDs to associate with the disk encryption set."
  type        = list(string)
  default     = [] # Optional: Set to an empty list if not using user-assigned identities
}

variable "key_vault_resource_id" {
  type        = string
  description = "The resource ID of the Key Vault to associate with the disk encryption set."
}


variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  default     = null
  description = <<DESCRIPTION
Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.
DESCRIPTION

  validation {
    condition     = var.lock != null ? contains(["CanNotDelete", "ReadOnly"], var.lock.kind) : true
    error_message = "The lock level must be one of: 'None', 'CanNotDelete', or 'ReadOnly'."
  }
}

# tflint-ignore: terraform_unused_declarations
variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
  default     = {}
  description = <<DESCRIPTION
Controls the Managed Identity configuration on this resource. The following properties can be specified:

- `system_assigned` - (Optional) Specifies if the System Assigned Managed Identity should be enabled.
- `user_assigned_resource_ids` - (Optional) Specifies a list of User Assigned Managed Identity resource IDs to be assigned to this resource.
DESCRIPTION
  nullable    = false
}

# tflint-ignore: terraform_unused_declarations
variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

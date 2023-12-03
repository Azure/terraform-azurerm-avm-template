variable "name" {
  type        = string
  description = "The name of the this resource."

  validation {
    condition     = can(regex("TODO determine REGEX", var.name))
    error_message = "The name must be TODO."
    # TODO remove the example below once complete:
    #condition     = can(regex("^[a-z0-9]{5,50}$", var.name))
    #error_message = "The name must be between 5 and 50 characters long and can only contain lowercase letters and numbers."
  }
}

# This is required for most resource modules
variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "location" {
  type        = string
  default     = null
  description = "Azure region where the resource should be deployed.  If null, the location will be inferred from the resource group location."
}

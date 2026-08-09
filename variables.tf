variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "location" {
  type        = string
  description = "The Azure region where the resource group will be created."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the resource group."
  nullable    = false

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 90 && can(regex("^[-\\w\\._\\(\\)]+$", var.name)) && !endswith(var.name, ".")
    error_message = "The name must be 1 to 90 characters, contain only alphanumeric characters, hyphens, underscores, periods, or parentheses, and cannot end with a period."
  }
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "A map of tags to assign to the resource group."
}

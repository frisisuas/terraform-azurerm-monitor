/*
data "azurerm_resources" "existing" {
  for_each            = var.alertScope
  name                = each.value.resourceName
  resource_group_name = each.value.resourceGroup
  type                = each.value.resourceType
}

variable "alertScope" {
  type = map(object({
	resourceName  = string
	resourceGroup = string
	resourceType  = string
  }))
}
*/

variable "metric-alerts" {
  type = map(object({
    alertName                   = string
    alertResourceGroupName      = string
    alertDescription            = string
    alertEnabled                = bool
    alertAutoMitigate           = bool
    alertFrequency              = string
    alertWindowSize             = string
    alertSeverity               = number
    alertTargetResourceType     = string
    alertTargetResourceLoc      = string
    dynCriteriaAggregation      = string
    dynCriteriaMetricName       = string
    dynCriteriaMetricNamespace  = string
    dynCriteriaOperator         = string
    dynCriteriaAlertSensitivity = string
  }))
  default = {
    "alert1" = {
      alertName                   = "VM_Availability"
      alertResourceGroupName      = "vm-rg"
      alertDescription            = "VM Availability Alert"
      alertEnabled                = true
      alertAutoMitigate           = true
      alertFrequency              = "PT15M"
      alertWindowSize             = "PT1H"
      alertSeverity               = 2
      alertTargetResourceType     = "Microsoft.Compute/virtualMachines"
      alertTargetResourceLoc      = "westeurope"
      dynCriteriaAggregation      = "Average"
      dynCriteriaMetricName       = "VmAvailabityMetric"
      dynCriteriaMetricNamespace  = "Microsoft.Compute/virtualMachines"
      dynCriteriaOperator         = "LessThan"
      dynCriteriaAlertSensitivity = "Medium"
    },
    "alert2" = {
      alertName                   = "VM_CPU_Usage"
      alertResourceGroupName      = "vm-rg"
      alertDescription            = "VM CPU Usage Alert"
      alertEnabled                = true
      alertAutoMitigate           = true
      alertFrequency              = "PT15M"
      alertWindowSize             = "PT1H"
      alertSeverity               = 2
      alertTargetResourceType     = "Microsoft.Compute/virtualMachines"
      alertTargetResourceLoc      = "westeurope"
      dynCriteriaAggregation      = "Average"
      dynCriteriaMetricName       = "PercentageCPU"
      dynCriteriaMetricNamespace  = "Microsoft.Compute/virtualMachines"
      dynCriteriaOperator         = "GreaterThan"
      dynCriteriaAlertSensitivity = "High"
    },
  }
}
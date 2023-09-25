terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.74.0"
    }
  }
}

provider "azurerm" {
  features {}
}


module "find-ids" {
  source = "../modules/AZ-Resource-Identify"

  alertScope = {
    "resource1" = {
      resourceName  = "test-vm01"
      resourceGroup = "test-asr"
      resourceType  = "Microsoft.Compute/virtualMachines"
    }
  }
}

module "azmonitor-action-groups" {
  source = "../modules/AzMonitor-ActionGroups/"

  tags = {
    Application = "Azure Monitor Alerts"
    CostCentre  = ""
    Environment = ""
    ManagedBy   = ""
    Owner       = ""
    Support     = ""
  }

  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = "AzMonitorAlertGroups"
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "jloudon"
          email_address           = "coder_au@outlook.com"
          use_common_alert_schema = "true"
        }
      ]
    },
    "group2" = {
      actionGroupName      = "AlertOperationsGroup"
      actionGroupShortName = "alertops"
      actionGroupRGName    = "AzMonitorAlertGroups"
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "jloudon"
          email_address           = "coder_au@outlook.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}

module "azmonitor-metric-alerts" {
  source   = "../modules/AzMonitor-MetricAlerts/"
  for_each = var.metric-alerts
  tags = {}

  alertScope = {
    "resource1" = {
      resourceName  = "test-vm01"
      resourceGroup = "test-asr"
      resourceType  = "Microsoft.Compute/virtualMachines"
    }
  }

  metricAlerts = {
    "alert1" = {
      alertName              = each.value.alertName
      alertResourceGroupName = each.value.alertResourceGroupName
      alertScopes = [
        #module.azmonitor-metric-alerts.alert-scope["0"].resource1.resources[0].id
        module.find-ids.alert-scope["0"].resource1.resources[0].id
      ]
      alertDescription            = each.value.alertDescription
      alertEnabled                = each.value.alertEnabled
      alertAutoMitigate           = each.value.alertAutoMitigate
      alertFrequency              = each.value.alertFrequency
      alertWindowSize             = each.value.alertWindowSize
      alertSeverity               = each.value.alertSeverity
      alertTargetResourceType     = each.value.alertTargetResourceType
      alertTargetResourceLoc      = each.value.alertTargetResourceLoc
      dynCriteriaMetricNamespace  = each.value.dynCriteriaMetricNamespace
      dynCriteriaMetricName       = each.value.dynCriteriaMetricName
      dynCriteriaAggregation      = each.value.dynCriteriaAggregation
      dynCriteriaOperator         = each.value.dynCriteriaOperator
      dynCriteriaAlertSensitivity = each.value.dynCriteriaAlertSensitivity
      dynCriteriaDimensions = [

      ]
      actionGroupID = module.azmonitor-action-groups.ag["0"].group1.id
    }
  }
}
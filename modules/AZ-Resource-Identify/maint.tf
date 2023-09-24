data "azurerm_resources" "existingids" {
  for_each = var.alertScope
  
  name                = each.value.resourceName
  resource_group_name = each.value.resourceGroup
  type                = each.value.resourceType
}

variable "alertScope" {
  type = map(object({
	resourceName  = string
	resourceGroup = string
	resourceType  = string
  }))
}
# Sign in to your Azure subscription
Connect-AzAccount

# put resource group in a variable so you can use the same group name going forward, without hard-coding it repeatedly
$resourceGroup = "storage-resource-group"
$location = "westus"
New-AzResourceGroup -Name $resourceGroup -Location $location

# If we're not sure which region to specify for the -Location parameter
Get-AzLocation | select Location

# create a general-purpose v2 storage account with read-access geo-redundant storage (RA-GRS) by using the New-AzStorageAccount command. 
# name of our storage account must be unique across Azure, so replace the placeholder value in brackets with our own unique value:
New-AzStorageAccount -ResourceGroupName $resourceGroup `
  -Name <account-name> `
  -Location $location `
  -SkuName Standard_RAGRS `
  -Kind StorageV2
  
# Delete a storage account
# Deleting a storage account deletes the entire account, including all data in the account, and cannot be undone.
Remove-AzStorageAccount -Name <storage-account> -ResourceGroupName <resource-group>
  
# Create a BlockBlobStorage account
# Open an elevated Windows PowerShell session (Run as administrator).
# Run the following command to make sure the latest version of the Az PowerShell module is installed.
Install-Module -Name Az -AllowClobber

# Open a new PowerShell console and sign in with your Azure account.
Connect-AzAccount -SubscriptionId <SubscriptionID>

# If needed, create a new resource group. Replace the values in quotations, and run the following command.
$resourcegroup = "new_resource_group_name"
$location = "region_name"
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create the BlockBlobStorage account. Replace the values in quotations, and run the following command.

$resourcegroup = "resource_group_name"
$storageaccount = "new_storage_account_name"
$location = "region_name"

New-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccount -Location $location -Kind "BlockBlobStorage" -SkuName "Premium_LRS"

#  Enabling this setting with your BlockBlobStorage account gives you the premium tier for Data Lake Storage.
# If you want to optimize your storage account for data analytics, then add
-EnableHierarchicalNamespace $True

# Upgrade to a general-purpose v2 storage account
# To upgrade a general-purpose v1 account to a general-purpose v2 account using PowerShell, first update PowerShell to use the latest version of the Az.Storage module. 
Set-AzStorageAccount -ResourceGroupName <resource-group> -Name <storage-account> -UpgradeToStorageV2 -AccessTier <Hot/Cool>

# Specify an access tier for blob data
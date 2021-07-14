# working with service principal

To Create a service principal run the below command in azure cloud shell
```
New-AzADServicePrincipal -DisplayName Gtaa-DevOp-Connection
```

## **Get Object ID**
To get the object ID, you can use Get-AzADServicePrincipal. For a service principal, use the object ID and not the application ID

```
Get-AzADServicePrincipal -SearchString <principalName>
```
<br>

```
(Get-AzADServicePrincipal -DisplayName <principalName>).id
```

## **Get the appropriate role**

we will be using **Contributor** Role

```
Get-AzRoleDefinition Contributor
```

## **Scope**
To allow at the resource group level we can use either of the below two steps.
* `-Scope "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/pharma-sales"`

* `-ResourceGroupName MyVirtualNetworkResourceGroup `


## **Assigning the role**

```
New-AzRoleAssignment -ObjectId aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa `
-RoleDefinitionName "Contributor" `
-ResourceGroupName gtaa-test
```
[ref this link Link for other Built-in Roles](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)


## **Further reading**
* https://docs.microsoft.com/en-us/azure/role-based-access-control/role-assignments-powershell
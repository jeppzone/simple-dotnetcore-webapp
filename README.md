# simple-dotnetcore-webapp 

This webapplication simply outputs a background color and a text from the configuration file *appsettings.json*, and also the value of custom environment variables *ENVIRONMENT* and *APP_NAME*

To be used in docker exercises

# Requirements
```
.NET Core v2.2.0-preview2
```

# dotnet CLI commands
```dotnet restore ```
Downloads package dependencies referenced in *.csproj* file

```dotnet publish -c Release -o out ```
Packages the application and its dependencies with Release configuration and outputs to "/out" directory

# Health Check
Available on endpoint */healthz*


# Create cluster

az login

terraform init

terraform apply -var-file="service_principal.tfvars"

az ad app show --id {application_id}

terraform apply -var app_id={0} -var password={1}

az aks browse --resource-group Kubernetes_Cluster --name klasaks898


-----

az aks install-cli

az aks get-credentials --resource-group Kubernetes_Cluster --name klasaks898


$subscriptionName="MPN"
$managementGroup="TEST"

az login

Write-Host "Searching the subscriptions..."
$subscriptions=ConvertFrom-Json –InputObject "$(az account list --query "[? name!='null']|[? contains(name,'$subscriptionName')].{name:name,id:id}" --all -o json)"

foreach($subscription in $subscriptions){
    $confirmation = Read-Host "Associate subscription " $subscription.name " to " $managementGroup "? (y/n)"
    if ($confirmation -eq 'y') {
        Write-Host "Associating subscription..."
        az account management-group subscription add --name $managementGroup --subscription  $subscription.id 
        Write-Host "Done..."
    }else{
        Write-Host "Cancelled association..."
    }
}

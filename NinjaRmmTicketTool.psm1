# Global variables
$global:NinjaRmmTokenUrl = ''
$global:NinjaRmmClientID = ''
$global:NinjaRmmClientSecret = ''
$global:NinjaRmmRefreshToken = ''
$global:NinjaRmmTicketCreationUrl = ''
$global:NinjaRmmBearerToken = ''

Function Set-NinjaRmmGlobalSettings {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [String] $TokenUrl,

        [Parameter(Mandatory = $true)]
        [String] $ClientID,

        [Parameter(Mandatory = $true)]
        [String] $ClientSecret,

        [Parameter(Mandatory = $true)]
        [String] $RefreshToken,

        [Parameter(Mandatory = $true)]
        [String] $TicketCreationUrl
    )

    $global:NinjaRmmTokenUrl = $TokenUrl
    $global:NinjaRmmClientID = $ClientID
    $global:NinjaRmmClientSecret = $ClientSecret
    $global:NinjaRmmRefreshToken = $RefreshToken
    $global:NinjaRmmTicketCreationUrl = $TicketCreationUrl

    Write-Host "Global settings have been set."
    Write-Host "Token URL: $TokenUrl"
    Write-Host "Client ID: $ClientID"
    Write-Host "Ticket Creation URL: $TicketCreationUrl"
}

Function Get-NinjaBearerToken {
    [CmdletBinding()]
    Param()

    $Body = @{
        grant_type    = 'refresh_token'
        refresh_token = $global:NinjaRmmRefreshToken
        client_id     = $global:NinjaRmmClientID
        client_secret = $global:NinjaRmmClientSecret
    }

    $Headers = @{
        'Content-Type' = 'application/x-www-form-urlencoded'
    }

    Write-Host "Request URL: $global:NinjaRmmTokenUrl"
    Write-Host "Request Body: $($Body | ConvertTo-Json -Compress)"
    Write-Host "Request Headers: $($Headers | Out-String)"

    try {
        $Response = Invoke-RestMethod -Uri $global:NinjaRmmTokenUrl -Method Post -Headers $Headers -Body $Body
        Write-Host "Token refresh successful. New access token retrieved."
        $global:NinjaRmmBearerToken = $Response.access_token
    }
    catch {
        Write-Error "Error in refreshing access token: $_"
        if ($_.Exception.Response -ne $null) {
            $ErrorContent = $_.Exception.Response.Content.ReadAsStringAsync().Result
            Write-Error "Detailed Error: $ErrorContent"
        }
    }
}

Function New-NinjaTicket {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [String] $ClientID,

        [Parameter(Mandatory = $true)]
        [String] $Subject,

        [Parameter(Mandatory = $true)]
        [String] $Description,

        [Parameter(Mandatory = $true)]
        [ValidateSet('NONE', 'HIGH', 'LOW', 'MEDIUM')]
        [String] $Priority,

        [Parameter(Mandatory = $true)]
        [String] $Status,

        [Parameter(Mandatory = $true)]
        [String] $Type,

        [Parameter(Mandatory = $true)]
        [String] $TicketFormId,

        [Parameter(Mandatory = $true)]
        [String] $RequesterUid
    )

    # Ensure we have a valid bearer token
    if (-not $global:NinjaRmmBearerToken) {
        Get-NinjaBearerToken
    }

    $Headers = @{
        'Authorization' = "Bearer $global:NinjaRmmBearerToken"
        'Content-Type'  = 'application/json'
    }

    $Body = @{
        clientId     = [int]$ClientID
        requesterUid = $RequesterUid
        subject      = $Subject
        description  = @{
            public   = $true
            body     = $Description
            htmlBody = $Description  # Include both text and HTML body for better compatibility
        }
        priority     = $Priority
        status       = $Status
        type         = $Type
        ticketFormId = [int]$TicketFormId
    } | ConvertTo-Json -Depth 3

    Write-Host "Request URL: $global:NinjaRmmTicketCreationUrl"
    Write-Host "Request Headers: $($Headers | Out-String)"
    Write-Host "Request Body: $Body"

    try {
        $Response = Invoke-RestMethod -Uri $global:NinjaRmmTicketCreationUrl -Method Post -Headers $Headers -Body $Body
        Write-Host "Ticket created successfully: $($Response | ConvertTo-Json -Compress)"
        return $Response
    }
    catch {
        Write-Error "Error in creating ticket: $_"
        if ($_.Exception.Response -ne $null) {
            $ErrorContent = $_.Exception.Response.Content.ReadAsStringAsync().Result
            Write-Error "Detailed Error: $ErrorContent"
        }
    }
}

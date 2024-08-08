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

    Write-Verbose "Global settings have been set."
    Write-Verbose "Token URL: $TokenUrl"
    Write-Verbose "Client ID: $ClientID"
    Write-Verbose "Ticket Creation URL: $TicketCreationUrl"
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

    Write-Verbose "Request URL: $global:NinjaRmmTokenUrl"
    Write-Verbose "Request Body: $($Body | ConvertTo-Json -Compress)"
    Write-Verbose "Request Headers: $($Headers | Out-String)"

    try {
        $Response = Invoke-RestMethod -Uri $global:NinjaRmmTokenUrl -Method Post -Headers $Headers -Body $Body
        Write-Verbose "Token refresh successful. New access token retrieved."
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
        [ValidateSet('1000', '2000', '2001', '3000', '3001', '3002', '3003', '3004', '3005', '3006', '3007', '4000', '5000')]
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

    Write-Debug "Request URL: $global:NinjaRmmTicketCreationUrl"
    Write-Debug "Request Headers: $($Headers | Out-String)"
    Write-debug "Request Body: $Body"

    try {
        $Response = Invoke-RestMethod -Uri $global:NinjaRmmTicketCreationUrl -Method Post -Headers $Headers -Body $Body
        Write-Verbose "Ticket created successfully: $($Response | ConvertTo-Json -Compress)"
        Write-Verbose $Response
    }
    catch {
        Write-Error "Error in creating ticket: $_"
        if ($null -ne $_.Exception.Response) {
            $ErrorContent = $_.Exception.Response.Content.ReadAsStringAsync().Result
            Write-Error "Detailed Error: $ErrorContent"
        }
    }
}




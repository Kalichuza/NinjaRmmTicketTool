# NinjaRmmTicketTool
 An Unofficial API modue for NinjaONE ticket creation.
### README.md

# NinjaRmmTicketTool

NinjaRmmTicketTool is a PowerShell module designed to create tickets in NinjaRMM using a streamlined process. This module is in no way  allows for easy authentication and ticket creation using NinjaRMM's API. 

## Installation

1. **Clone the Repository:**
    ```shell
    git clone https://github.com/yourusername/NinjaRmmTicketTool.git
    ```
   
2. **Navigate to the Module Directory:**
    ```shell
    cd NinjaRmmTicketTool
    ```

3. **Import the Module:**
    Ensure that the `NinjaRmmTicketTool.psm1` and `NinjaRmmTicketTool.psd1` files are in the same directory.
    ```powershell
    Import-Module -Name .\NinjaRmmTicketTool.psd1 -Force
    ```

## Functions

### 1. `Set-NinjaRmmGlobalSettings`

This function sets the global settings required for the module to interact with NinjaRMM's API.

#### Syntax
```powershell
Set-NinjaRmmGlobalSettings -TokenUrl <String> -ClientID <String> -ClientSecret <String> -RefreshToken <String> -TicketCreationUrl <String>
```

#### Parameters
- **`-TokenUrl`**: The URL endpoint for obtaining the OAuth token.
- **`-ClientID`**: The client ID for the OAuth application.
- **`-ClientSecret`**: The client secret for the OAuth application.
- **`-RefreshToken`**: The refresh token for obtaining a new access token.
- **`-TicketCreationUrl`**: The URL endpoint for creating tickets.

#### Example
```powershell
Set-NinjaRmmGlobalSettings -TokenUrl 'https://mcstech.rmmservice.com/ws/oauth/token' -ClientID 'vXCIXvybtcZ1lOiRrmVE_OqgktQ' -ClientSecret 'IhpGA-fttZJh4w4_yqQ4zHLpmrWIGVUoWplvi4_q7dZNzb81Ng_zgw' -RefreshToken 'd95b2277-43b9-46d2-a63e-d210d8e5b920.Ua-aeWgVWDJu-lVgTPzGXMr4Oj5BEseNOJgp_2GybKY' -TicketCreationUrl 'https://mcstech.rmmservice.com/v2/ticketing/ticket'
```

### 2. `Get-NinjaBearerToken`

This function obtains a new bearer token using the refresh token. It is called automatically when creating a ticket, so there is usually no need to call this function manually.

#### Syntax
```powershell
Get-NinjaBearerToken
```

#### Example
```powershell
Get-NinjaBearerToken
```

### 3. `New-NinjaTicket`

This function creates a new ticket in NinjaRMM.

#### Syntax
```powershell
New-NinjaTicket -Subject <String> -Description <String> -Priority <String> -Status <String> -Type <String> -TicketFormId <String> -ClientID <Int>
```

#### Parameters
- **`-Subject`**: The subject of the ticket.
- **`-Description`**: The description of the ticket.
- **`-Priority`**: The priority of the ticket. Valid values are `NONE`, `HIGH`, `LOW`, and `MEDIUM`.
- **`-Status`**: The status of the ticket.
- **`-Type`**: The type of the ticket.
- **`-TicketFormId`**: The form ID for the ticket.
- **`-ClientID`**: The client ID associated with the ticket.

#### Example
```powershell
New-NinjaTicket -Subject 'CPU with problems' -Description 'Manual PUA cleanup required: WebNavigator Browser at C:\\Users\\Student\\AppData\\Local\\WebNavigatorBrowser\\Application\\2.3.0.13\\Installer\\webnavigatorbrowser.7z' -Priority 'HIGH' -Status '1000' -Type 'PROBLEM' -TicketFormId '2' -ClientID 4
```

## Example Workflow

1. **Import the Module:**
    ```powershell
    Import-Module -Name .\NinjaRmmTicketTool.psd1 -Force
    ```

2. **Set Global Settings:**
    ```powershell
    Set-NinjaRmmGlobalSettings -TokenUrl 'https://mcstech.rmmservice.com/ws/oauth/token' -ClientID 'vXCIXvybtcZ1lOiRrmVE_OqgktQ' -ClientSecret 'IhpGA-fttZJh4w4_yqQ4zHLpmrWIGVUoWplvi4_q7dZNzb81Ng_zgw' -RefreshToken 'd95b2277-43b9-46d2-a63e-d210d8e5b920.Ua-aeWgVWDJu-lVgTPzGXMr4Oj5BEseNOJgp_2GybKY' -TicketCreationUrl 'https://mcstech.rmmservice.com/v2/ticketing/ticket'
    ```

3. **Create a New Ticket:**
    ```powershell
    New-NinjaTicket -Subject 'CPU with problems' -Description 'Manual PUA cleanup required: WebNavigator Browser at C:\\Users\\Student\\AppData\\Local\\WebNavigatorBrowser\\Application\\2.3.0.13\\Installer\\webnavigatorbrowser.7z' -Priority 'HIGH' -Status '1000' -Type 'PROBLEM' -TicketFormId '2' -ClientID 4
    ```

## Troubleshooting

- Ensure all required parameters are provided when setting global settings and creating tickets.
- Check the API endpoints and credentials for accuracy.
- Review any error messages returned by the functions for additional context.


## Legal Notices
Neither I nor this code are in any way affiliated with, related to, or endorsed by NinjaRMM, LLC.  I'm just a user.  If you need support with this PowerShell module, don't go to them.  Open an issue or pull request instead.

This program is free software:  you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful, but **WITHOUT ANY WARRANTY**; without even the implied warranty of **MERCHANTABILITY** or **FITNESS FOR A PARTICULAR PURPOSE**.  Test anything you build with this tool.

## Contributing
The NinjaRMM API is under active development;  thus, so is this module.  Contributions are welcome!

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

By following this README, users should be able to set up and use the NinjaRmmTicketTool module effectively.
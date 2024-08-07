@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'NinjaRmmTicketTool.psm1'

    # Version number of this module.
    ModuleVersion = '1.0.0'

    # Supported PSEditions
    CompatiblePSEditions = @('Desktop', 'Core')

    # ID used to uniquely identify this module
    GUID = '8d1b0b60-fc9f-4d9e-b8f0-7e42db605e67'  # Actual GUID

    # Author of this module
    Author = 'Kevin Cleary'

    # Company or vendor of this module
    CompanyName = 'Kalichuza'

    # Description of the functionality provided by this module
    Description = 'A very unofficial PowerShell module for creating NinjaRMM tickets.'

    # Functions to export from this module
    FunctionsToExport = @(
        'Set-NinjaRmmGlobalSettings',
        'Get-NinjaTicketBearerToken',
        'New-NinjaTicket'
    )

    # Cmdlets to export from this module
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport = @()

    # List of all files packaged with this module
    FileList = @(
        'en-US/about_NinjaRmmTicketTool.help.txt',
        'en-US/NinjaRmmTicketTool-help.xml',
        'NinjaRmmTicketTool.psm1',
        'NinjaRmmTicketTool.psd1',
        'README.md'
    )

    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('NinjaRMM', 'API', 'Ticketing')

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/Kalichuza/NinjaRmmTicketTool/blob/main/LICENSE'  # Replace with your actual license URL

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/Kalichuza/NinjaRmmTicketTool'  # Replace with your actual project URL

            # A URL to an icon representing this module.
            IconUri = 'https://github.com/Kalichuza/NinjaRmmTicketTool/blob/main/NinjaRmmTickwtTool.png?raw=true'  # Replace with your actual icon URL

            # ReleaseNotes of this module
            ReleaseNotes = 'Initial release of NinjaRmmTicketTool module.'
        }
    }

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.1'
}

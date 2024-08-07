@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'NinjaRmmTicketTool.psm1'

    # Version number of this module.
    ModuleVersion = '1.0.0'

    # Supported PSEditions
    CompatiblePSEditions = @('Desktop', 'Core')

    # ID used to uniquely identify this module
    GUID = '00000000-0000-0000-0000-000000000000'

    # Author of this module
    Author = 'Your Name'

    # Company or vendor of this module
    CompanyName = 'Your Company'

    # Description of the functionality provided by this module
    Description = 'A PowerShell module for creating NinjaRMM tickets.'

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
            LicenseUri = 'https://example.com/license'

            # A URL to the main website for this project.
            ProjectUri = 'https://example.com/project'

            # A URL to an icon representing this module.
            IconUri = 'https://example.com/icon'

            # ReleaseNotes of this module
            ReleaseNotes = 'Initial release of NinjaRmmTicketTool module.'
        }
    }
}

# Define server
$server = "fs-blue1"

# Define groups and share names
$groupShares = @{
  "Evil Dead Rise" = "C:\Shares\Evil Dead Rise"
  "The Thing" = "C:\Shares\The Thing"
  "IT" = "C:\Shares\IT"
  "Scream" = "C:\Shares\Scream"
  "Cujo" = "C:\Shares\Cujo"
  "Zombieland" = "C:\Shares\Zombieland"
  "The Cabin in the Woods" = "C:\Shares\The Cabin in the Woods"
  "Jaws" = "C:\Shares\Jaws"
  "Alien" = "C:\Shares\Alien"
  "Us" = "C:\Shares\Us"
  "Hereditary" = "C:\Shares\Hereditary"
  "Doctor Sleep" = "C:\Shares\Doctor Sleep"
  "Smile" = "C:\Shares\Smile"
  "The Exorcist" = "C:\Shares\The Exorcist"
  "The Mist" = "C:\Shares\The Mist"

# OU to link GPO to
$BaseOU = "OU=Groups,OU=Accounts,OU=blue1,DC=BLUE,DC=local"

# Import GroupPolicy module
Import-Module GroupPolicy

# Process groups and create GPO for drive mapping
foreach ($group in $groupShares.Keys) {
  $gpoName = "$group"
  $networkSharePath = $groupShares[$group]

  # Check if GPO exists
  $existingGpo = Get-GPO -Name $gpoName -ErrorAction SilentlyContinue

  if ($null -eq $existingGpo) {
        # Create new GPO
        $newGpo = New-GPO -Name $gpoName
        New-GPLink -GPO $newGpo -Target $BaseOU

        # Retrieve GPO's directory in SYSVOL
        $gpoid = $newGpo.Id.ToString().ToUpper()
        $gpoDirectoryPath = "\\blue.local\SYSVOL\blue.local\Policies\{$gpoid}\User\Preferences\Drives"

        # Ensure directory exists for drive mapping configuration
        if (-Not (Test-Path $gpoDirectoryPath)) {
            New-Item -Path $gpoDirectoryPath -ItemType Directory -Force
        }

        # Set access control on the directory
        $acl = Get-Acl $gpoDirectoryPath
        $newAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
        $acl.SetAccessRule($newAccessRule)
        Set-Acl -Path $gpoDirectoryPath -AclObject $acl
  }
}

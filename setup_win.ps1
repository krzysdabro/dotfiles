
function Arrow {
  param (
    [string]$text,
    [string]$color = "Blue"
  )
  Write-Host ":: " -ForegroundColor $color -NoNewline
  Write-Host $text
}


# Check permissions
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
  Arrow "You do not have Administrator rights to run this script! Please re-run this script as an Administrator!" -color Red
  return
}


# Install applications via winget
function Winget-Install {
  param (
    [string]$packageId,
    [string]$custom = ""
  )

  if (winget list --source winget --id $packageId | Select-String $packageId) {
    Arrow "$packageId is already installed" -color Green
    return
  }

  $args = @(
    "install"
    "--id", $packageId
    "--source", "winget"
    "--scope", "user"
  )

  if ($custom -ne "") {
    $args += @("--custom", $custom)
  }

  Arrow "Installing $packageId"
  winget @args
  if ($LASTEXITCODE -ne 0) {
    Arrow "Failed to install $packageId" -color Red
    return
  }

  Write-Host ""
}

Winget-Install "Git.Git" -custom "/o:PathOption=CmdTools"
Winget-Install "gerardog.gsudo"
Winget-Install "Brave.Brave"
Winget-Install "AgileBits.1Password"
Winget-Install "Spotify.Spotify"
Winget-Install "Valve.Steam"
Winget-Install "Microsoft.VisualStudioCode"
Winget-Install "Microsoft.PowerToys"
Winget-Install "RamenSoftware.Windhawk"


# Refresh PATH env
$env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
$env:DOTFILES = "$env:USERPROFILE\dotfiles"


# Clone dotfiles repository if it doesn't exist
if (!(Test-Path $env:DOTFILES)) {
  Arrow "Cloning dotfiles repository"
  git clone https://github.com/krzysdabro/dotfiles.git "$env:DOTFILES"
}


# Setup dotfiles
function Link {
  param (
    [string]$src,
    [string]$dst
  )

  [void](New-Item -Path $dst -ItemType SymbolicLink -Value $src -Force)
}

Arrow "Setting up Git"
[System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", $env:LOCALAPPDATA, [EnvironmentVariableTarget]::User)
Link "$env:DOTFILES\git" "$env:XDG_CONFIG_HOME\git"

Arrow "Setting up Windows Terminal"
Link "$env:DOTFILES\windows\terminal\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

Arrow "Setting up Windows PowerShell"
Link "$env:DOTFILES\windows\powershell\profile.ps1" "$PROFILE"

Arrow "Setting up Command Palette"
Link "$env:DOTFILES\windows\command_palette\settings.json" "$env:LOCALAPPDATA\Packages\Microsoft.CommandPalette_8wekyb3d8bbwe\LocalState\settings.json"

Arrow "Setting up PowerToys"
Link "$env:DOTFILES\windows\powertoys\settings.json" "$env:LOCALAPPDATA\Microsoft\PowerToys\settings.json"

# Windows tweaks
function Update-RegistryItem {
  param (
    [string]$path,
    [string]$name,
    [string]$type = "String",
    [object]$value
  )

  if ($path.StartsWith("HKU:\") -And !(Test-Path 'HKU:\')) {
    New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS | Out-Null
  }

  If (!(Test-Path $Path)) {
     New-Item -Path $Path -Force | Out-Null
  }

  if ($value) {
    Set-ItemProperty -Path $path -Name $name -Type $type -Value $value -Force | Out-Null
  } else {
    if ($name) {
      Remove-ItemProperty -Path $Path -Name $name -Force -ErrorAction SilentlyContinue | Out-Null
    } else {
      Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
  }
}

Arrow "Applying Explorer tweaks"
Update-RegistryItem -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "Hidden" -type "DWord" -value 1                                     # Show hidden files
Update-RegistryItem -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "HideFileExt" -type "DWord" -value 0                                # Show file extensions
Update-RegistryItem -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "LaunchTo" -type "DWord" -value 1                                   # Set "This PC" as default page
Update-RegistryItem -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -value $null  # Remove Home from menu
Update-RegistryItem -path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" -value $null  # Remove Gallery from menu

Arrow "Enabling NumLock on startup"
Update-RegistryItem -path "HKU:\.Default\Control Panel\Keyboard" -name "InitialKeyboardIndicators" -type "DWord" -value 2
Update-RegistryItem -path "HKCU:\Control Panel\Keyboard" -name "InitialKeyboardIndicators" -type "DWord" -value 2

Arrow "Disabling Sticky Keys"
Update-RegistryItem -path "HKCU:\Control Panel\Accessibility\StickyKeys" -name "Flags" -type "DWord" -value 58

Arrow "Disabling GameDVR"
Update-RegistryItem -path "HKCU:\System\GameConfigStore" -name "GameDVR_Enabled" -type "DWord" -value 0
Update-RegistryItem -path "HKCU:\System\GameConfigStore" -name "GameDVR_FSEBehavior" -type "DWord" -value 2 
Update-RegistryItem -path "HKCU:\System\GameConfigStore" -name "GameDVR_HonorUserFSEBehaviorMode" -type "DWord" -value 1
Update-RegistryItem -path "HKCU:\System\GameConfigStore" -name "GameDVR_EFSEFeatureFlags" -type "DWord" -value 0
Update-RegistryItem -path "HKLM:\Software\Policies\Microsoft\Windows\GameDVR" -name "AllowGameDVR" -type "DWord" -value 0
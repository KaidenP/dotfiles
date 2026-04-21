$agePath = Join-Path $env:USERPROFILE ".age_identity"
$sourceDir = "$env:CHEZMOI_SOURCE_DIR"

if (-not (Test-Path $agePath)) {
    & chezmoi age decrypt --output $agePath --passphrase "$sourceDir/.age_identity.age"

    $acl = Get-Acl $agePath
    $acl.SetAccessRuleProtection($true, $true)
    $acl.Access | ForEach-Object {
        $acl.RemoveAccessRule($_)
    }

    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
        [System.Security.Principal.WindowsIdentity]::GetCurrent().User,
        "FullControl",
        "None",
        "None",
        "Allow"
    )
    $acl.AddAccessRule($rule)
    Set-Acl $agePath $acl
}

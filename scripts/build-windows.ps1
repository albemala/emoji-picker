# NOTE: run from scripts directory

$ErrorActionPreference = "Stop" # exit on error

$ScriptsDirectory = Get-Location
$RootDirectory = "$ScriptsDirectory/.."
cd $RootDirectory

# read app version from pubspec.yaml
$AppVersion = select-string -path pubspec.yaml -pattern "^version: (.*)" | % { $_.Matches.Groups[1].Value }

$ArchiveDirectory = "$RootDirectory/windows-builds/$AppVersion"
$AppStoreArchiveDirectory = "$ArchiveDirectory/app-store"
$StandaloneArchiveDirectory = "$ArchiveDirectory/standalone"

# remove existing archive directory for this version
if (Test-Path $ArchiveDirectory) {
    Remove-Item -Recurse -Force $ArchiveDirectory
}
# create archive directories
New-Item -ItemType Directory -Force -Path $AppStoreArchiveDirectory
New-Item -ItemType Directory -Force -Path $StandaloneArchiveDirectory

# clean and build
flutter clean
flutter build windows --release

# copy app data to standalone archive directory
Copy-Item -Path build/windows/runner/Release/data -Destination $StandaloneArchiveDirectory -Recurse
Copy-Item -Path build/windows/runner/Release/Ejimo.exe -Destination $StandaloneArchiveDirectory
Copy-Item -Path build/windows/runner/Release/* -Include *.dll -Destination $StandaloneArchiveDirectory
Copy-Item -Path C:/Windows/System32/msvcp140.dll -Destination $StandaloneArchiveDirectory
Copy-Item -Path C:/Windows/System32/vcruntime140.dll -Destination $StandaloneArchiveDirectory
Copy-Item -Path C:/Windows/System32/vcruntime140_1.dll -Destination $StandaloneArchiveDirectory
# compress standalone app data
$StandaloneArchiveName="Ejimo-Windows.zip"
cd $StandaloneArchiveDirectory
Start-Process "C:\Program Files\7-Zip\7z.exe" -ArgumentList "a","-tzip","../$StandaloneArchiveName",'.' -wait
cd $RootDirectory
# upload standalone to Google Cloud Storage
gcloud storage cp --recursive "$StandaloneArchiveDirectory/../$StandaloneArchiveName" "gs://ejimo-app-releases/$AppVersion/$StandaloneArchiveName"

# read env file
$EnvFilePath = ".env"
$EnvVariables = Get-Content $EnvFilePath | Out-String | ConvertFrom-StringData
# build app store package
dart run msix:create --store -i $EnvVariables.IdentityName -b $EnvVariables.Publisher -u $EnvVariables.PublisherDisplayName
# copy app store package to archive directory
Copy-Item -Path build/windows/runner/Release/app.msix -Destination "$AppStoreArchiveDirectory/Ejimo.msix"

cd $ScriptsDirectory

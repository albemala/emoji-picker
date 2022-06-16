
# read app version from pubspec.yaml
$AppVersion = & dart get-app-version.dart

$ScriptsDirectory = Get-Location
$RootDirectory = "$ScriptsDirectory/.."
$ArchiveDirectory = "$RootDirectory/windows-builds/$AppVersion"
$AppStoreArchiveDirectory = "$ArchiveDirectory/appstore"
$WebStoreArchiveDirectory = "$ArchiveDirectory/webstore"

cd $RootDirectory

echo "------ setup ------"

# remove existing archive folder for this version
rm -r -fo "$ArchiveDirectory"
New-Item -ItemType Directory -Force -Path $AppStoreArchiveDirectory
New-Item -ItemType Directory -Force -Path $WebStoreArchiveDirectory

flutter clean
flutter build windows --release

echo "------ build for app store ------"

$EnvFilePath = ".env"
$EnvVariables = Get-Content $EnvFilePath | Out-String | ConvertFrom-StringData
flutter pub run msix:create --store -i $EnvVariables.IdentityName -b $EnvVariables.Publisher -u $EnvVariables.PublisherDisplayName

echo "------ archive app store build ------"

Copy-Item -Path build/windows/runner/Release/app.msix -Destination "$AppStoreArchiveDirectory/Ejimo.msix"

echo "------ archive web store build ------"

Copy-Item -Path build/windows/runner/Release/data -Destination $WebStoreArchiveDirectory -Recurse
Copy-Item -Path build/windows/runner/Release/Ejimo.exe -Destination $WebStoreArchiveDirectory
Copy-Item -Path build/windows/runner/Release/* -Include *.dll -Destination $WebStoreArchiveDirectory
Copy-Item -Path C:/Windows/System32/msvcp140.dll -Destination $WebStoreArchiveDirectory
Copy-Item -Path C:/Windows/System32/vcruntime140.dll -Destination $WebStoreArchiveDirectory
Copy-Item -Path C:/Windows/System32/vcruntime140_1.dll -Destination $WebStoreArchiveDirectory

cd $WebStoreArchiveDirectory
Start-Process "C:\Program Files\7-Zip\7z.exe" -ArgumentList "a","-tzip","../Ejimo-Windows-$AppVersion.zip",'.' -wait

cd $ScriptsDirectory

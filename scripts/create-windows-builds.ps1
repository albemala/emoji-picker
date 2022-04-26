
# read app version from pubspec.yaml
$AppVersion = & dart get-app-version.dart
$ArchiveDirectory = "windows-builds/$AppVersion"

cd ..

echo "------ setup ------"

# remove existing archive folder for this version
rm -r -fo "$archiveDirectory"

flutter clean
flutter build windows --release

echo "------ build for app store ------"

$EnvFilePath = ".env"
$EnvVariables = Get-Content $EnvFilePath | Out-String | ConvertFrom-StringData
flutter pub run msix:create --store -i $EnvVariables.IdentityName -b $EnvVariables.Publisher -u $EnvVariables.PublisherDisplayName

echo "------ archive app store build ------"

$AppStoreArchiveDirectory = "$ArchiveDirectory/appstore"
mkdir "$AppStoreArchiveDirectory"
cp build/windows/runner/Release/app.msix "$AppStoreArchiveDirectory/Ejimo.msix"

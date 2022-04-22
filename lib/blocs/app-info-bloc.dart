import 'package:package_info_plus/package_info_plus.dart';

class AppInfoBloc {
  String appName() {
    return 'Ejimo';
  }

  Future<String> appVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    var appVersion = packageInfo.version;
    if (packageInfo.buildNumber.isNotEmpty) appVersion += '.${packageInfo.buildNumber}';
    return appVersion;
  }
}

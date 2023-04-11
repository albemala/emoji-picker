import 'package:send_support_email/send_support_email.dart';
import 'package:url_launcher/url_launcher.dart';

const _supportEmailUrl = 'mailto:albemala@gmail.com';
const _twitterUrl = 'https://twitter.com/albemala';
const _repositoryUrl = 'https://github.com/albemala/emoji-picker';
const _exaboxWebsiteUrl = 'https://exabox.app';
const _hexeeWebsiteUrl = 'https://hexee.app/';
const _wmapWebsiteUrl = 'https://wmap.albemala.me/';
const _iroIroWebsiteUrl = 'https://iro-iro.albemala.me/';

class UrlsBloc {
  Future<void> sendFeedback() async {
    final supportEmail = await generateSupportEmail(_supportEmailUrl);
    await _open(supportEmail);
  }

  Future<void> openTwitter() async {
    await _open(_twitterUrl);
  }

  Future<void> openExaboxWebsite() async {
    await _open(_exaboxWebsiteUrl);
  }

  Future<void> openHexeeWebsite() async {
    await _open(_hexeeWebsiteUrl);
  }

  Future<void> openWMapWebsite() async {
    await _open(_wmapWebsiteUrl);
  }

  Future<void> openIroIroWebsite() async {
    await _open(_iroIroWebsiteUrl);
  }

  Future<void> openRepository() async {
    await _open(_repositoryUrl);
  }

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final canOpenUrl = await canLaunchUrl(uri);
    if (!canOpenUrl) return;

    await launchUrl(uri);
  }
}

import 'package:url_launcher/url_launcher.dart';

const _supportEmail = 'mailto:albemala@gmail.com';
const _twitter = 'https://twitter.com/albemala';
const _repository = 'https://github.com/albemala/emoji-picker';
const _exaboxWebsite = 'https://exabox.app';
const _hexeeWebsite = 'https://hexee.app/';
const _wmapWebsite = 'https://wmap.albemala.me/';
const _iroIroWebsite = 'https://iro-iro.albemala.me/';

class UrlsBloc {
  Future<void> sendFeedback() async {
    await _open(_supportEmail);
  }

  Future<void> openTwitter() async {
    await _open(_twitter);
  }

  Future<void> openExaboxWebsite() async {
    await _open(_exaboxWebsite);
  }

  Future<void> openHexeeWebsite() async {
    await _open(_hexeeWebsite);
  }

  Future<void> openWMapWebsite() async {
    await _open(_wmapWebsite);
  }

  Future<void> openIroIroWebsite() async {
    await _open(_iroIroWebsite);
  }

  Future<void> openRepository() async {
    await _open(_repository);
  }

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final canOpenUrl = await canLaunchUrl(uri);
    if (!canOpenUrl) return;

    await launchUrl(uri);
  }
}

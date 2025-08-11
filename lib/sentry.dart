import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void configureSentry(SentryFlutterOptions options) {
  options
    ..dsn = kReleaseMode
        ? 'https://70798e2083374854a9fe9ead98685325@o562204.ingest.us.sentry.io/6549529'
        : ''
    ..beforeSend = _beforeSend
    ..debug = kDebugMode;
}

SentryEvent _beforeSend(SentryEvent event, Hint hint) {
  event.user = SentryUser(id: '');
  event.contexts.culture = SentryCulture();
  event.contexts.device = SentryDevice();
  return event;
}

Future<void> captureException(dynamic exception) async {
  await Sentry.captureException(exception, stackTrace: StackTrace.current);
}

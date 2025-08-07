import 'package:app/urls/defines.dart';
import 'package:app/urls/functions.dart';
import 'package:send_support_email/send_support_email.dart';

Future<void> sendFeedback({String subject = '', String body = ''}) async {
  final email = await generateSupportEmail(
    supportEmailUrl,
    subject: subject,
    body: body,
  );
  await openUri(email);
}

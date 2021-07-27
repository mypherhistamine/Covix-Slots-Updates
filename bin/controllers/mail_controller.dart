import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/hotmail.dart';

import '../models/center_found_model.dart';

class CustomMailer {
  Future sendMailToUser(List<VacCenterFound> centersFound) async {
    var username = 'sentient.optimus.prime@hotmail.com';
    var password = 'Optimus@Prime99';

    final smtpServer = hotmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    if (centersFound.isNotEmpty) {
      centersFound.forEach((element) async {
        final message = Message()
          ..from = Address(username, 'COWIN Platform')
          ..recipients.add('rishabhmishra23599@gmail.com')
          ..subject = 'Dose 1 Slot Available ${DateTime.now().toLocal()}'
          ..text =
              'There is one slot avaialbility for you in your district go to the COWIN Platform now !!';
        // ..html = "<h1>Test</h1>\n<p>Check the website now </p>";

        try {
          final sendReport = await send(message, smtpServer);
          print('Message sent: ' + sendReport.toString());
        } on MailerException catch (e) {
          print('Message not sent.${e.toString()}');
          for (var p in e.problems) {
            print('Problem: ${p.code}: ${p.msg}');
          }
        }
      });
    }
  }
}

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class EmailService {
  sendEmail(
      {required List<String> to,
      required String subject,
      Map<String, dynamic>? templateData,
      required String templateID}) async {
    try {
      final mailer = Mailer(dotenv.env['SENDGRID']!);
      List<Address> toAddresses = to.map((e) => Address(e)).toList();
      final fromAddress = Address('joyceplus.adm@gmail.com', "TOP Nurse Agency");
      final personalization =
          Personalization(toAddresses, dynamicTemplateData: templateData, subject: subject);

      final email = Email([personalization], fromAddress, subject, templateId: templateID);
      await mailer.send(email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

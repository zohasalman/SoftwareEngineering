// import 'dart:typed_data';
import 'package:rateit/vendor.dart';

// import 'firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:qr_utils/qr_utils.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';




Future _generateQR_sendemail(Vendor content) async {
    var image;
    try {
      image = await QrUtils.generateQR(content.vendorId);
      
      String gmailUsername = 'help.rateit@gmail.com';
      String gmailPassword = 'xyz123mn';

      final smtpServer = gmail(gmailUsername, gmailPassword);

      final msg1 = Message()
      ..from = Address(gmailUsername, '')
      ..recipients.add('recipent')
      ..subject = 'Test'
      ..text = 'Plain Text'
      ..html = ''//Form Data
      ..attachments.add(FileAttachment(image));

      try {
        final sendReport = await send(msg1, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
      // Create a smtp client that will persist the connection
      var connection = PersistentConnection(smtpServer);

      // Send the message
      await connection.send(msg1);

      // close the connection
      await connection.close();


    } on PlatformException {
      image = null;
    }
}


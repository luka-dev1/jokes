import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/email_list.dart';
import '../models/joke.dart';

/// Widget that holds a send email button and a progress indicator
/// that indicates if the emails are being sent.
class SendEmails extends StatefulWidget {
  const SendEmails({Key? key}) : super(key: key);

  @override
  State<SendEmails> createState() => _SendEmailsState();
}

class _SendEmailsState extends State<SendEmails> {
  var _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// If the button was clicked, the email sending is in progress
        /// and a progress indicator is displayed.
        _isProcessing
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              )
            : const SizedBox(),
        const SizedBox(
          width: 20,
        ),

        /// Button that triggers the sending of emails.
        GestureDetector(
          onTap: () async {
            if (!_isProcessing) {
              var list = Provider.of<EmailList>(context, listen: false);
              var joke = Provider.of<Joke>(context, listen: false);

              /// If the email list is empty, appropriate snackbar is displayed.
              if (list.emails.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email list is empty.'),
                  ),
                );
              } else {
                _isProcessing = true;
                setState(() {});
                var isSuccessful = await list.sendEmails(joke);
                _isProcessing = false;
                setState(() {});
                if (isSuccessful) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Emails sent successfully.'),
                      ),
                    );
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failure: Emails were not sent.'),
                      ),
                    );
                  }
                }
              }
            }
          },
          child: const Icon(
            Icons.send,
            size: 50,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/email_list.dart';
import 'custom_fab.dart';

/// Field widget that presents a text field and a button for adding new emails.
///
/// It runs a check on a given input to make sure that the
/// input format represent an email.
///
/// It also checks if the email from the input already exists in the list.
class EmailField extends StatefulWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final emailController = TextEditingController();
  var _emailIsValid = true;
  String? _emailErrorText;
  Email? _email;

  /// Checks if the input is valid and if the input email
  /// is not already in the list.
  void _checkEmail() async {
    var list = Provider.of<EmailList>(context, listen: false);

    /// RegExp for an email
    final validEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    var email = emailController.text.toLowerCase();
    if (!validEmail.hasMatch(email)) {
      _emailIsValid = false;
      _emailErrorText = "Please enter valid email address.";
      setState(() {});
    } else {
      _email = Email(email.split("@")[0], email.split("@")[1].split(".")[0]);
      if (list.checkIfExists(_email!)) {
        _emailIsValid = false;
        _emailErrorText = "Email already added!";
        setState(() {});
      } else {
        list.addEmail(_email!);
        emailController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 8,
          fit: FlexFit.tight,
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey,
                labelText: "Email",
                labelStyle: const TextStyle(fontSize: 10),
                counterStyle: const TextStyle(color: Colors.grey),
                errorText: !_emailIsValid ? _emailErrorText : null,
                errorStyle: const TextStyle(fontSize: 10.0),
                errorMaxLines: 2,
                border: const UnderlineInputBorder(),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: CustomFAB(
            onTap: () {
              _checkEmail();
            },
            padding: const EdgeInsets.all(10.0),
            shape: BoxShape.rectangle,
            size: 50,
            color: Colors.black,
            label: const Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

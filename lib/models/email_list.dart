import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'joke.dart';

/// A class that holds the list of all emails the User has provided.
class EmailList with ChangeNotifier {
  /// List of emails.
  final List<Email> _emails = [];

  /// Getters.
  List<Email> get emails => _emails;

  /// Adds new email to the list of emails. Then sorts the list,
  /// first by domain then by name.
  ///
  /// Notifies consumer widgets of an updated list of emails.
  void addEmail(Email email) {
    _emails.add(email);
    _emails.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    _emails.sort((a, b) {
      return a.domain.toLowerCase().compareTo(b.domain.toLowerCase());
    });
    notifyListeners();
  }

  /// Removes an email from the list.
  void removeEmail(Email email) {
    _emails.remove(email);
    notifyListeners();
  }

  /// Sends emails to all of the recipients from the email list.
  /// Returns true if the operation was successful.
  Future<bool> sendEmails(Joke joke) async {
    /// Builds a string of recipients to send to the PHP server.
    /// ( 'email1, email2, email3' etc. )
    var recipients = _buildRecipientsString();

    /// Sends a post to the PHP API. Currently on localhost -10.0.2.2
    try {
      final url = Uri.parse('http://10.0.2.2/phptest/sendEmails.php');
      var response = await http.post(
        url,
        body: {
          'recipients': recipients,
          'content': joke.content,
        },
      );
      var data = jsonDecode(response.body);
      var success = data['success'] == "Success";

      /// API returns 'Success' message if the operation completed successfully.
      if (success) {
        print("Email sent successfully!");
        return true;
      } else {
        print("Failure: Email was not sent!");
        return false;
      }
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  /// Builds a recipients String by concatenating all email Strings.
  String _buildRecipientsString() {
    var recipients = _emails[0].toString();
    for (int i = 1; i < _emails.length; i++) {
      recipients += ", ${_emails[i].toString()}";
    }
    return recipients;
  }

  /// Checks if the email list contains a given email.
  bool checkIfExists(Email newEmail) {
    for (Email email in _emails) {
      if (email.name == newEmail.name && email.domain == newEmail.domain) {
        return true;
      }
    }
    return false;
  }
}

/// A class that represents an email address.
/// It makes it easier to sort emails by given parameters - domain and name.
class Email {
  String name;
  String domain;

  Email(this.name, this.domain);

  @override
  String toString() {
    return "$name@$domain.com";
  }
}

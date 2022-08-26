import 'package:jokes/models/email_list.dart';
import 'package:test/test.dart';

void main() {
  group("EmailList", () {
    test("should initialize an empty list of emails.", () {
      var list = EmailList();
      expect(list.emails.isEmpty, true);
    });

    test(".addEmail(email) should add a new email to the list.", () {
      var list = EmailList();
      list.addEmail(Email("a", "b"));
      expect(list.emails[0].name, "a");
    });

    test(".removeEmail(email) should remove an email from the list.", () {
      var list = EmailList();
      var em = Email("a", "b");
      list.addEmail(em);
      list.removeEmail(em);
      expect(list.emails.isEmpty, true);
    });

    test(".checkIfExists(email) should find an email in the list.", () {
      var list = EmailList();
      var em = Email("a", "b");
      list.addEmail(em);
      expect(list.checkIfExists(em), true);
    });
  });
}

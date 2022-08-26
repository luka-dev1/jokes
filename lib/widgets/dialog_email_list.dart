import 'package:flutter/material.dart';
import 'package:jokes/models/email_list.dart';
import 'package:jokes/widgets/widget_email_field.dart';
import 'package:provider/provider.dart';

/// Dialog that displays all the emails.
///
/// Also presents an input field and a button for adding new emails.
class EmailListDialog extends StatelessWidget {
  const EmailListDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: screenWidth > 800 ? screenWidth * 0.2 : screenWidth * 0.1,
        vertical: 24.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.blueGrey.withOpacity(0.8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Email List",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Consumer<EmailList>(
                  builder: (context, list, child) {
                    return ListView.builder(
                      itemCount: list.emails.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(list.emails[index].toString()),
                            trailing: GestureDetector(
                                onTap: () {
                                  var list = Provider.of<EmailList>(context,
                                      listen: false);
                                  list.removeEmail(list.emails[index]);
                                },
                                child: const Icon(Icons.clear)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: EmailField(),
            ),
          ],
        ),
      ),
    );
  }
}

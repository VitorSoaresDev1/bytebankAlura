import 'package:flutter/material.dart';

const Key transactionAuthDialogTextFieldPassword =
    Key('transactionAuthDialogTextFieldPassword');

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({
    @required this.onConfirm,
  });

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              key: transactionAuthDialogTextFieldPassword,
              controller: _passwordController,
              obscureText: true,
              maxLength: 4,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 64.0, letterSpacing: 24.0),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('Confirm'),
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

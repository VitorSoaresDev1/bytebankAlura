import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDAO = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(BytebankApp(
      contactDAO: mockContactDAO,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferFeatureItem(tester);
    await tester.pumpAndSettle();

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDAO.findAll()).called(1);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, 'Full name');
    });
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Vitor');

    final accountTextField = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, 'Account number');
    });
    expect(accountTextField, findsOneWidget);
    await tester.enterText(accountTextField, '1000');

    final createButton = find.widgetWithText(RaisedButton, 'Create');
    expect(createButton, findsOneWidget);

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContactDAO.save(Contact(0, 'Vitor', 1000)));

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

    verify(mockContactDAO.findAll());
  });
}

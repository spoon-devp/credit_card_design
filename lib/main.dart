import 'package:credit_card_design/colors.dart';
import 'package:credit_card_design/credit_card.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Credit Card',
      home: Scaffold(
        body: Center(
          child: CreditCard(
            height: 230,
            width: 400,
            color: ColorTheme.black,
            cardHolderName: "Şahin Soylu",
            cardNumber: "1523 3486 3499 4562",
            expireDateMonth: 12,
            expireDateYear: 24,
            cardCompany: CardCompany.mastercard,
            cvvNumber: 132,
          ),
        ),
      ),
    );
  }
}

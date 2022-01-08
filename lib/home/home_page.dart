import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smeet_task/payment_card/page/payment_card_page.dart';
import 'package:smeet_task/payment_card/provider/payment_card_provider.dart';
import 'package:smeet_task/phone/page/phone_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smeet's Task"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text("Logic Test"),
              onPressed: () {
                Navigator.of(context).pushNamed(PhonePage.routeName);
              },
            ),
            ElevatedButton(
              child: const Text("UI Test"),
              onPressed: () {
                Provider.of<PaymentCardProvider>(context, listen: false).init();
                Navigator.of(context).pushNamed(PaymentCardPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

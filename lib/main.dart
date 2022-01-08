import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smeet_task/payment_card/provider/payment_card_provider.dart';
import 'package:smeet_task/phone/provider/phone_provider.dart';
import 'package:smeet_task/utils/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PhoneProvider>(
          create: (_) => PhoneProvider(),
        ),
        ChangeNotifierProvider<PaymentCardProvider>(
          create: (_) => PaymentCardProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: MaterialApp(
          title: "Smeet's Task",
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}


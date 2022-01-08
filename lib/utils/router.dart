import 'package:flutter/material.dart';
import 'package:smeet_task/home/home_page.dart';
import 'package:smeet_task/payment_card/page/payment_card_page.dart';
import 'package:smeet_task/phone/page/phone_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String? routeName = settings.name;
  Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;

  switch (routeName) {
    case "/":
      return _getPageRoute(
        routeName: routeName!,
        // widget: const PaymentCardPage(),
        widget: const HomePage(),
      );

    case PhonePage.routeName:
      return _getPageRoute(
        routeName: routeName!,
        widget: const PhonePage(),
      );

    case PaymentCardPage.routeName:
      return _getPageRoute(
        routeName: routeName!,
        widget: const PaymentCardPage(),
      );


    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

PageRoute _getPageRoute({required String routeName, required Widget widget}) =>
    MaterialPageRoute(
        settings: RouteSettings(
          name: routeName,
        ),
        builder: (_) => widget);

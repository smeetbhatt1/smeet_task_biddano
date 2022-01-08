import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smeet_task/payment_card/provider/payment_card_provider.dart';

class BackCardWidget extends StatelessWidget {
  const BackCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey("back_card"),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Security Code",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8,),
          Selector<PaymentCardProvider, String>(
            selector: (_, p) => p.cvvCode,
            builder: (_, value, __) => Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

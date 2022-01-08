import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smeet_task/constants/image_constants.dart';
import 'package:smeet_task/payment_card/provider/payment_card_provider.dart';

class FrontCardWidget extends StatelessWidget {
  const FrontCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey("front_card"),
      width: double.infinity,
      height: 210,
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowChipAndCardType(),
          const SizedBox(height: 20,),
          _buildColumnCardNumber(),
          const SizedBox(height: 16,),
          _buildRowNameAndExpDate(),
        ],
      ),
    );
  }

  Widget _buildRowChipAndCardType() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage(icChip),
          ),
          Selector<PaymentCardProvider, String>(
            selector: (_, p) => p.imgPathCardType,
            builder: (_, value, __) {
              return value == null || value.trim().isEmpty
                  ? const SizedBox()
                  : Image(
                image: AssetImage(value),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColumnCardNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Card Number",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8,),
        Selector<PaymentCardProvider, String>(
          selector: (_, p) => p.cardNo,
          builder: (_, value, __) => Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowNameAndExpDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildColumnName(),
        _buildColumnExpDate(),
      ],
    );
  }

  Widget _buildColumnName() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Card Holder Name",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8,),
          Selector<PaymentCardProvider, String>(
            selector: (_, p) => p.name,
            builder: (_, value, __) => Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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

  Widget _buildColumnExpDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "EXP Date",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8,),
        Selector<PaymentCardProvider, String>(
          selector: (_, p) => p.expDate,
          builder: (_, value, __) => Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }


}

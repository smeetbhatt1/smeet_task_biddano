import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smeet_task/constants/constants.dart';
import 'package:smeet_task/payment_card/provider/payment_card_provider.dart';
import 'package:smeet_task/payment_card/widgets/back_card_widget.dart';
import 'package:smeet_task/payment_card/widgets/front_card_widget.dart';

class PaymentCardPage extends StatefulWidget {
  static const String routeName = "/payment-card-page";

  const PaymentCardPage({Key? key}) : super(key: key);

  @override
  _PaymentCardPageState createState() => _PaymentCardPageState();
}

class _PaymentCardPageState extends State<PaymentCardPage> {
  bool _showFrontSide = true;
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardNumberNode = FocusNode();
  final _nameController = TextEditingController();
  final _nameNode = FocusNode();
  final _expDateController = TextEditingController();
  final _expDateNode = FocusNode();
  final _cvvCodeController = TextEditingController();
  final _cvvCodeNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UI Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFlipAnimation(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 16,),
                      _buildTextFieldCardNumber(),
                      const SizedBox(height: 16,),
                      _buildTextFieldName(),
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextFieldExpDate(),
                          ),
                          const SizedBox(width: 8,),
                          Expanded(
                            child: _buildTextFieldCvvCode(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _switchCard() {
    Provider.of<PaymentCardProvider>(context, listen: false).switchCardSide();
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child:
            _showFrontSide ? const FrontCardWidget() : const BackCardWidget(),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeIn.flipped,
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (_, Widget? widget) {
        final isUnder = const ValueKey("front_card") != widget?.key;
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildTextFieldCardNumber() {
    return TextFormField(
      focusNode: _cardNumberNode,
      controller: _cardNumberController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (s) {
        _cardNumberNode.unfocus();
        _nameNode.requestFocus();
      },
      onTap: () {
        print("on Tap");
      },
      onChanged: Provider.of<PaymentCardProvider>(context, listen: false).onCardNumberChanged,
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      keyboardType: TextInputType.number,
      validator: null,maxLines: 1,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
      ],
      decoration: InputDecoration(
        labelText: "Card Number",
        errorMaxLines: 1,
        enabledBorder: textFieldBorder,
        focusedBorder: textFieldFocusBorder,
        errorBorder: textFieldFocusBorder,
        focusedErrorBorder: textFieldFocusBorder,
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextFormField(
      focusNode: _nameNode,
      controller: _nameController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (s) {
        _nameNode.unfocus();
        _expDateNode.requestFocus();
      },
      onTap: () {
        print("on Tap");
      },
      onChanged: Provider.of<PaymentCardProvider>(context, listen: false).onNameChanged,
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      keyboardType: TextInputType.name,
      validator: null,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: "Name",
        errorMaxLines: 1,
        enabledBorder: textFieldBorder,
        focusedBorder: textFieldFocusBorder,
        errorBorder: textFieldFocusBorder,
        focusedErrorBorder: textFieldFocusBorder,
      ),
    );
  }

  Widget _buildTextFieldExpDate() {
    return TextFormField(
      focusNode: _expDateNode,
      controller: _expDateController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (s) {
        _expDateNode.unfocus();
        _cvvCodeNode.requestFocus();
      },
      onTap: () {
        print("on Tap");
      },
      onChanged: (String value) {
        if (value.trim().length == 2) {
          if (!Provider.of<PaymentCardProvider>(context, listen: false).expDate.endsWith("/")) {
            _expDateController.text += "/";
            _expDateController.selection = TextSelection.fromPosition(
                TextPosition(offset: _expDateController.text.length));
          }
        }
        Provider.of<PaymentCardProvider>(context, listen: false).onExpDateChanged(value);
      },
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      keyboardType: TextInputType.number,
      validator: null,maxLines: 1,
      inputFormatters: <TextInputFormatter>[
        // FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
        LengthLimitingTextInputFormatter(7),
      ],
      decoration: InputDecoration(
        labelText: "Exp Date (MM/YYYY)",
        errorMaxLines: 1,
        enabledBorder: textFieldBorder,
        focusedBorder: textFieldFocusBorder,
        errorBorder: textFieldFocusBorder,
        focusedErrorBorder: textFieldFocusBorder,
      ),
    );
  }

  Widget _buildTextFieldCvvCode() {
    return TextFormField(
      focusNode: _cvvCodeNode,
      controller: _cvvCodeController,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (s) {
        _cvvCodeNode.unfocus();
      },
      onTap: () {
        print("on Tap");
      },
      onChanged: Provider.of<PaymentCardProvider>(context, listen: false).onCvvCodeChanged,
      textCapitalization: TextCapitalization.words,
      autofocus: false,
      keyboardType: TextInputType.number,
      validator: null,maxLines: 1,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(3),
      ],
      decoration: InputDecoration(
        labelText: "Security Code (CVV)",
        errorMaxLines: 1,
        enabledBorder: textFieldBorder,
        focusedBorder: textFieldFocusBorder,
        errorBorder: textFieldFocusBorder,
        focusedErrorBorder: textFieldFocusBorder,
      ),
    );
  }
}

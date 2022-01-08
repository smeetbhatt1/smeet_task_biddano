import 'package:flutter/foundation.dart';
import 'package:smeet_task/constants/constants.dart';
import 'package:smeet_task/constants/image_constants.dart';

class PaymentCardProvider with ChangeNotifier {
  String cardNo = "";
  String imgPathCardType = "";
  String name = "";
  String expDate = "MM/YYYY";
  String cvvCode = "";
  bool showFrontSide = true;

  void init() {
    cardNo = "";
    imgPathCardType = "";
    name = "";
    expDate = "MM/YYYY";
    cvvCode = "";
    showFrontSide = true;
  }

  void onCardNumberChanged(String text) {
    cardNo = text;
    CardType cardType = detectCCType(cardNo);
    switch (cardType) {

      case CardType.otherBrand:
        imgPathCardType = "";
        break;
      case CardType.mastercard:
        imgPathCardType = icMastercard;
        break;
      case CardType.visa:
        imgPathCardType = icVisa;
        break;
      case CardType.americanExpress:
        imgPathCardType = icAmex;
        break;
      case CardType.discover:
        imgPathCardType = icDiscover;
        break;
    }
    notifyListeners();
  }

  void onNameChanged(String text) {
    name = text;
    notifyListeners();
  }

  void onExpDateChanged(String text) {
    expDate = text;
    notifyListeners();
  }

  void onCvvCodeChanged(String text) {
    cvvCode = text;
    notifyListeners();
  }

  void switchCardSide(bool isFront) {
    showFrontSide = isFront;
    notifyListeners();
  }
}
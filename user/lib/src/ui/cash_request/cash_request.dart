import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cashRequstVM = ChangeNotifierProvider((ref) => CashRequestVM(ref));

class CashRequestVM extends ChangeNotifier {
  final Ref ref;
  CashRequestVM(this.ref);

  String amount = '';
  String meetUpLocation = '';


  setAmount(String value){
    amount = value;
    notifyListeners();
  }

  setMeetupLocation(String value){
    meetUpLocation = value;
    print("meetup Location  $value");
    notifyListeners();
  }
}

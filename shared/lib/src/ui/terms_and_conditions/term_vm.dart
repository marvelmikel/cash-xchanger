import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/src/ui/terms_and_conditions/model/terms_model.dart';

final termsModelVM = ChangeNotifierProvider((ref) => TermsVM(ref));

class TermsVM extends ChangeNotifier {
  final Ref _ref;

  TermsVM(this._ref);


  TermsModel model = TermsModel();
}
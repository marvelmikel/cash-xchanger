import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/src/ui/terms_and_conditions/term_vm.dart';

import 'package:sizer/sizer.dart';

class TermsAndConditionsScreen extends ConsumerWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final privacyData = ref.read(termsModelVM);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('Terms & Condition'),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
            child: ListView.builder(
              itemCount: 0,
              itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h, top: 0.1.h),
                  child: Text(
                    privacyData.model.section![index],
                  )),
            )));
  }
}

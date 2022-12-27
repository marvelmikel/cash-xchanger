import 'package:cash_xchanger/cubit/auth_cubit/terms_and_condtons_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/helpers.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Terms & Condition'),
        centerTitle: true,
      ),
      body: BlocBuilder<PrivacyCubit, PrivacyState>(builder: (context, state) {
        if (state is PrivacyLoadingState) {
          return Container(
            color: Colors.white,
            child: showLoaderDialog(context),
          );
        } else if (state is PrivacyLoadedState) {
          final privacyData = state.termsModel;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
            child: ListView.builder(
                itemCount: privacyData!.section!.length,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 0.5.h, top: 0.1.h),
                      child: Text(privacyData.section![index]),
                    )),
          );
        } else if (state is PrivacyErrorState) {
          return const Center(
            child: Icon(Icons.close),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}

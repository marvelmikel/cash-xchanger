import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/database/shared_preferences/temp_database.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/ui/onboard_screen/onboard_screen.dart';
import 'package:cash_xchanger/ui/user/dashboard/dashboard_home/user_dashboard_screen.dart';
import 'package:cash_xchanger/ui/vendor/vendor_dashboard/vendor_dashboar.dart';
import 'package:cash_xchanger/ui/vendor/vendor_welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'database/models/profile_model/profile_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  late ProfileModel userData;

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getProfileDetails();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (getItInstance<TempDataBaseImpl>().getUserData().isNotEmpty) {
          userData = profileModelFromMap(
              getItInstance<TempDataBaseImpl>().getUserData());
        }
        return getItInstance<TempDataBaseImpl>().getUserData().isEmpty
            ? const OnboardScreen()
            : userData.userDetails.userRole == 'user'
                ? const UserDashBoardScreen()
                : userData.userDetails.isDocumentVerified
                    ? const VendorDashboard()
                    : VendorWelcomeScreen(vendorData: [
                        userData.userDetails.username,
                        userData.userDetails.email
                      ]);
      },
    );
  }
}

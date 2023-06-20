import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboard_screen/onboard_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

//  late ProfileModel userData;

  @override
  Widget build(BuildContext context) {
    // context.read<ProfileCubit>().getProfileDetails();
    return OnboardScreen();

    // BlocBuilder<ProfileCubit, ProfileState>(
    // builder: (context, state) {
    //   if (getItInstance<TempDataBaseImpl>().getUserData().isNotEmpty) {
    //     userData = profileModelFromMap(
    //         getItInstance<TempDataBaseImpl>().getUserData());
    //   }
    //   return getItInstance<TempDataBaseImpl>().getUserData().isEmpty
    //       ? const OnboardScreen()
    //       : userData.userDetails.userRole == 'user'
    //           ? const UserDashBoardScreen()
    //           : userData.userDetails.smileID.isNotEmpty
    //               ? const VendorDashboard()
    //               : VendorWelcomeScreen(vendorData: [
    //                   userData.userDetails.firstName,
    //                   userData.userDetails.email,
    //                   userData.userDetails.id,
    //                 ]);
    //  },
    // );
  }
}

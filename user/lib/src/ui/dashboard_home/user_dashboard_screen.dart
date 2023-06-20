import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared/shared.dart';
import 'package:user/src/ui/dashboard_home/widget/user_nav.dart';
import 'package:user/user.dart';

import 'widget/balance_widget.dart';
import 'widget/vendors_submap_view.dart';

class UserDashBoardScreen extends ConsumerStatefulWidget {
  const UserDashBoardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserDashBoardScreen> createState() =>
      _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends ConsumerState<UserDashBoardScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(userDashVM).goOnline();
  }

  @override
  Widget build(BuildContext context) {
    final navigation = ref.read(navProvider);
    final userDash = ref.read(userDashVM);
    return Scaffold(
        drawer: const UserNavigationDrawer(),
        key: userDash.scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const BalanceWidget(),
              InkWell(
                onTap: () => navigation.navigateTo(Routes.fullMapScreen),
                child:  MapSubView(),
              ),
              //   XchangerActions(),
               const TransactionWidget()
            ],
          ),
        ));
  }
}

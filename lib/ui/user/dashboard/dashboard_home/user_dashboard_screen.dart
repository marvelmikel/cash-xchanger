import 'package:cash_xchanger/cubit/book_cash_cubit/book_cash_cubit.dart';
import 'package:cash_xchanger/cubit/profile_cubit/profile_cubit.dart';
import 'package:cash_xchanger/ui/global_widgets/profile_bar_widget.dart';
import 'package:cash_xchanger/ui/shared_ui/dashboard/transaction_widget.dart';
import 'package:cash_xchanger/ui/shared_ui/navigation_drawer/drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/balance_widget.dart';
import 'widget/xchanger_actions.dart';

class UserDashBoardScreen extends StatefulWidget {
  const UserDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<UserDashBoardScreen> createState() => _UserDashBoardScreenState();
}

class _UserDashBoardScreenState extends State<UserDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getProfileDetails();
    context.read<ProfileCubit>().getTransactionHistory(context: context);
    context.read<BookCashCubit>().checkAvailableData();
    return Scaffold(
      drawer: const NavigationDrawer(),
      body: Column(
        children: [
          const ProfileBarWidget(),
          const SizedBox(height: 30),
          Flexible(
            child: Column(
              children: const [
                BalanceWidget(),
                XchangerActions(),
                TransactionWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
}

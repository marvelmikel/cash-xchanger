import 'package:cash_xchanger/cubit/auth_cubit/login_cubit.dart';
import 'package:cash_xchanger/cubit/nav_bar_cubit/nav_drawer_cubit.dart';
import 'package:cash_xchanger/dependency/get_it.dart';
import 'package:cash_xchanger/navigation/global_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'cubit/auth_cubit/register_cubit.dart';
import 'cubit/book_cash_cubit/book_cash_cubit.dart';
import 'cubit/payment_cubit/payment_cubit.dart';
import 'cubit/profile_cubit/profile_cubit.dart';
import 'cubit/vendor_cubit/vendor_cubit.dart';
import 'helpers/colors.dart';
import 'navigation/navigation_service.dart';
import 'navigation/routes.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late RegisterCubit _registerCubit;
  late LoginCubit _loginCubit;
  late ProfileCubit _profileCubit;
  late NavDrawerCubit _navDrawerCubit;
  late PaymentCubit _paymentCubit;
  late BookCashCubit _bookCashCubit;
  late VendorCubit _vendorCubit;

  @override
  void initState() {
    _registerCubit = getItInstance<RegisterCubit>();
    _loginCubit = getItInstance<LoginCubit>();
    _profileCubit = getItInstance<ProfileCubit>();
    _navDrawerCubit = getItInstance<NavDrawerCubit>();
    _paymentCubit = getItInstance<PaymentCubit>();
    _bookCashCubit = getItInstance<BookCashCubit>();
    _vendorCubit = getItInstance<VendorCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _registerCubit.close();
    _loginCubit.close();
    _profileCubit.close();
    _navDrawerCubit.close();
    _paymentCubit.close();
    _bookCashCubit.close();
    _vendorCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: _registerCubit),
                  BlocProvider.value(value: _loginCubit),
                  BlocProvider.value(value: _profileCubit),
                  BlocProvider.value(value: _navDrawerCubit),
                  BlocProvider.value(value: _paymentCubit),
                  BlocProvider.value(value: _bookCashCubit),
                  BlocProvider.value(value: _vendorCubit),
                ],
                child: MaterialApp(
                  title: 'xChanger',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: GlobalColors.materialPrimaryColor,
                    fontFamily: 'nunito',
                  ),
                  navigatorKey:
                      getItInstance<NavigationServiceImpl>().navigationKey,
                  initialRoute: Routes.homePage,
                  onGenerateRoute: (value) =>
                      GlobalRouter.generateRoutes(value),
                ));
          },
        ));
  }
}

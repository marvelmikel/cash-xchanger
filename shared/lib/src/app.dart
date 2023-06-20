import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeProvider);
    final nav = ref.read(navProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Sizer(builder: (context, orientation, deviceType) {
        return OKToast(
          dismissOtherOnShow: true,
          animationCurve: Curves.easeInOutExpo,
          animationDuration: const Duration(milliseconds: 400),
          animationBuilder: (context, child, controller, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(controller),
              child: child,
            );
          },
          handleTouch: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: theme,
            navigatorKey: nav.navigationKey,
            onGenerateRoute: (value) => GlobalRouter.generateRoutes(value),
            initialRoute: Routes.homePage,
          ),
        );
      }),
    );
  }
}

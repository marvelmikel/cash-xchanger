

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class NavigationService {
  Future<dynamic> navigateTo(String routeName, {dynamic arguments});

  Future<dynamic> replaceWith(String routeName, {dynamic arguments});

  void pop({dynamic v});

  Future<dynamic> replaceUntil({required context, required routeName});
}

class NavigationServiceImpl extends NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  @override
  void pop({dynamic v = false}) {
    return _navigationKey.currentState!.pop(v);
  }

  @override
  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<dynamic> replaceWith(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  @override
  Future replaceUntil(
      {required context, required routeName, dynamic arguments}) async {
    Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}

final navProvider = Provider((_) => NavigationServiceImpl());


import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/shared.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await TempStorage.instance.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(Providers.init(const App()));
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routescom/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('appParameters');
  await Hive.openBox('voiceParameters');
  await Hive.openBox('routeCards');
  await Hive.openBox('backupRouteCards');
  runApp(
    const ProviderScope(
      child: RoutesCOM(),
    ),
  );
}

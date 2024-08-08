import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:routescom/core/constants/constants.dart';
import 'package:routescom/core/theme/color_app.dart';
import 'package:routescom/src/communication/presentation/views/pages/communication_page.dart';

class RoutesCOM extends StatelessWidget {
  const RoutesCOM({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: TAColors.brandblue),
          home: const CommunicationPage(),
        );
      },
    );
  }
}

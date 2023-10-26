import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/pages.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'controllers/club_controller.dart';
import 'controllers/parameters_controller.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final Pages pages=Pages();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>LicenceProvider()),
        ChangeNotifierProvider(create: (_)=>ClubProvider()),
        ChangeNotifierProvider(create: (_)=>ParameterProvider()),
        ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return Directionality(
                    textDirection: TextDirection.rtl,

            child: MaterialApp.router(
               debugShowCheckedModeBanner: false,
              title: 'FTWKF',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routerConfig: pages.router,
            ),
          );
        }
      ),
    );
  }
}

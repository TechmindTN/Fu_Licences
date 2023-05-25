import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/pages.dart';
import 'package:fu_licences/screens/licence/licence_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'controllers/club_controller.dart';

void main() {
  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final Pages pages=Pages();
  @override
  Widget build(BuildContext context) {
    print('aaa');
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create: (_)=>LicenceProvider()),
        ChangeNotifierProvider(create: (_)=>ClubProvider()),
        ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            
             debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
             
              
              primarySwatch: Colors.blue,
            ),
            routerConfig: pages.router,
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

 

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
 

//   @override
//   Widget build(BuildContext context) {
   
//     return  LicencePage();
    
//   }
// }

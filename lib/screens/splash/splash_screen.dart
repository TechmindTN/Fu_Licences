import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/licence_controller.dart';

class MySplashScreen extends StatefulWidget{
  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  late Widget next;
  late LicenceProvider licenceController;

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    licenceController.checkLogin(context);
    // licenceController.checkLogin(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/logo-ftwkf.png")),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
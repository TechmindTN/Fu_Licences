import 'package:desktop_window/desktop_window.dart';
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
    print('bbb');
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    // licenceController.clearPrefs();
    licenceController.checkLogin(context);
    // licenceController.checkLogin(context);
    // TODO: implement initState
    super.initState();
    print('ccc');
  }

  @override
  Future<void> didChangeDependencies() async {
    
    await DesktopWindow.setFullScreen(true);
    Size size=await DesktopWindow.getWindowSize();
    await DesktopWindow.setMinWindowSize(size);
                    
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/licence_controller.dart';

class MySplashScreen extends StatefulWidget{
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  late Widget next;
  late LicenceProvider licenceController;

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    // licenceController.clearPrefs();
    licenceController.checkLogin(context);
    // licenceController.checkLogin(context);
    // TODO: implement initState
    super.initState();
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
    return Directionality(
              textDirection: TextDirection.rtl,

      child: Scaffold(
        body: Center(child: Image.asset("assets/images/logo-ftwkf.png")),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
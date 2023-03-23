import 'package:flutter/material.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/home/home_widgets.dart';
import 'package:provider/provider.dart';

import '../../controllers/licence_controller.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    // licenceController.login(context,login,);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      drawer: MyDrawer(licenceController,context),
      body: CustomScrollView(
        slivers: [
          MyAppBar((licenceController.currentUser.club!.id==null)?"ADMIN":licenceController.currentUser.club!.name,context,true,licenceController,false),
          // HomeCorps
          SliverToBoxAdapter(
            child: Column(
              children: [
                imageWidget(),
                SeasonWidget(),
                StatItems(),
                MyChart(),
                RecentLicences()
              ],
            ),
          )

        ],
        // child: Container(child: Center(
        //   child: Text("Home Screen"),
        // )),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
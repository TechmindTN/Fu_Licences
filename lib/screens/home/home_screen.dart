import 'package:flutter/material.dart';
import 'package:fu_licences/network/apis.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/home/home_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
        licenceController.checkVersion(context);

    ////print(Apis.tempToken);
    // licenceController.login(context,login,);
    // TODO: implement initState
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    // await licenceController.getGeneralStats();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
              textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: Color(0xfffafafa),
        drawer: MyDrawer(licenceController,context),
        body: Consumer<LicenceProvider>(
          builder: (context,licenceController,child) {
            return FutureBuilder(
              future: (licenceController.currentUser.club==null)?licenceController.getGeneralStats():licenceController.getClubStats(),
              builder: (context,snapshot) {
                return CustomScrollView(
                  slivers: [
                    MyAppBar((licenceController.currentUser.club!.id==null)?"ADMIN":licenceController.currentUser.club!.name,context,true,licenceController,false,false),
                    // HomeCorps
                    SliverToBoxAdapter(
                      child: Row(
                        
                        children: [
                          Container(width: 30.w,
                          height: 95.w,
                          color: const Color.fromARGB(255, 66, 144, 208),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/logo-ftwkf.png"),
                                    SizedBox(height: 0.5.h,),
                                    Divider(color: Colors.white,),
                                  InkWell(
                                    onTap: (){
                                      // GoRouter.of(context).go(Routes.LicenceListScreen);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 66, 144, 208)
                                      ),
                                      child: Center(child: Text('الشاشة الرئيسية',style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ),
                                //  SizedBox(height: 0.5.h,),
                                    Divider(color: Colors.white,),
                                //  SizedBox(height: 0.5.h,),
                                  InkWell(
                                    onTap: (){
                                      GoRouter.of(context).go(Routes.LicenceListScreen);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 66, 144, 208)
                                      ),
                                      child: Center(child: Text('الاجازات',style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ),
                                  Divider(color: Colors.white,),
                                   InkWell(
                                    onTap: (){
                                      GoRouter.of(context).go(Routes.AthleteLicenceListScreen);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 66, 144, 208)
                                      ),
                                      child: Center(child: Text("الرياضيين",style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ),
                                //  SizedBox(height: 0.5.h,),
                                    Divider(color: Colors.white,),
                                   InkWell(
                                    onTap: (){
                                      GoRouter.of(context).go(Routes.ArbitratorLicenceListScreen);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 66, 144, 208)
                                      ),
                                      child: Center(child: Text("الحكام",style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ),
                                //  SizedBox(height: 0.5.h,),
                                    Divider(color: Colors.white,),
                                   InkWell(
                                    onTap: (){
                                      GoRouter.of(context).go(Routes.CoachLicenceListScreen);
                                    },
                                    child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 66, 144, 208)
                                      ),
                                      child: Center(child: Text("المدربين",style: TextStyle(color: Colors.white,fontSize: 20),))),
                                  ),
                                //  SizedBox(height: 0.5.h,),
                                    if(licenceController.currentUser.club!.id==null)
                                    Column(
                                      children: [
                                        Divider(color: Colors.white,),
                                        InkWell(
                                      onTap: (){
                                        GoRouter.of(context).go(Routes.ClubListScreen);
                                      },
                                      child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 66, 144, 208)
                                      ),
                                      child: Center(child: Text("النوادي",style: TextStyle(color: Colors.white,fontSize: 20),))),
                                    ),
                                //  SizedBox(height: 0.5.h,),
                                  //  SizedBox(height: 0.5.h,),
                                    Divider(color: Colors.white,),
                                    InkWell(
                                      onTap: (){
                                        GoRouter.of(context).go(Routes.SelectParameterScreen);
                                      },
                                      child: Container(
                                      width: 30.w,
                                      height: 4.h,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 66, 144, 208)
                                      ),
                                      child: Center(child: Text('الاعدادات',style: TextStyle(color: Colors.white,fontSize: 20),))),
                                    ),
                                    // SizedBox(height: 0.5.h,),
                                   
                                      ],
                                    ),
                                //  SizedBox(height: 0.5.h,),
                                     Divider(color: Colors.white,),
                                ],),
                              ],
                            ),
                          ),
    
                          // FutureBuilder(
                          //   future: licenceController.getGeneralStats(),
                          //   builder: (context,snapshot) {
                          //     // licenceController.notify();
                          //     return
                               Container(
                                // color: Colors.red,
                                width: 130.w,
                                height: 48.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    // imageWidget(),
                                    SeasonWidget(),
                                    StatItems(licenceController.stats,context,licenceController),
                                    MyChart(licenceController.stats),
                                    
                                    // RecentLicences()
                                  ],
                                ),
                              ),
                              // ;
                          //   }
                          // ),
                          Container(
                            width: 31.w,
                          height: 95.w,
                            color: const Color.fromARGB(255, 66, 144, 208),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 20.w,
                                  width: 30.w,
                                  color: const Color.fromARGB(255, 66, 144, 208),
                                  child: BarChartSample1(txt:"الرياضيين"),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Container(
                                  height: 20.w,
                                  width: 30.w,
                                  color: const Color.fromARGB(255, 66, 144, 208),
                                  child: BarChartSample1(txt:"الحكام"),
                                ),
                                Divider( color: Colors.white,),
                                Container(
                                  height: 20.w,
                                  width: 30.w,
                                  color: const Color.fromARGB(255, 66, 144, 208),
                                  child: BarChartSample1(txt:"المدربين"),
                                ),
                          
                                
                              ],
                            ),
                          )
                        ],
                      ),
                    )
    
                  ],
                  // child: Container(child: Center(
                  //   child: Text("Home Screen"),
                  // )),
                );
              }
            );
          }
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
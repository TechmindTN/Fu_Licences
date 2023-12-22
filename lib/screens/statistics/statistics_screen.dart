import 'package:flutter/material.dart';
import 'package:fu_licences/models/club.dart';
import 'package:fu_licences/models/discipline.dart';
import 'package:fu_licences/models/season.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/inputs.dart';
import 'package:fu_licences/widgets/home/home_widgets.dart';
import 'package:fu_licences/widgets/stats/stats_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/licence_controller.dart';

class StatsScreen extends StatefulWidget{
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  late LicenceProvider licenceController;
  late Future future;
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    // future =licenceController.getDetailedStats();
    super.initState();
  }

@override
  void dispose() {
     licenceController.selectedClub=Club(id: -1,name: "");
                                licenceController.selectedSeason=Season(id: -1,seasons: "");
                                licenceController.selectedDiscipline=Discipline(id: -1,name: "");
                                licenceController.detailedStats=[];
                                // licenceController.statsWidget=SizedBox();
                                // licenceController.notify();
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
              textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: const Color(0xfffafafa),
        drawer: MyDrawer(licenceController,context),
        body: Consumer<LicenceProvider>(
          builder: (context,licenceController,child) {
            // return FutureBuilder(
            //   future: future,
            //   builder: (context,snapshot) {
                return CustomScrollView(
                  slivers: [
                    MyAppBar("الاحصائيات",context,true,licenceController,false,false),
                    SliverToBoxAdapter(
                      child: SizedBox(
                      //  width: 130.w,
                      //  height: 48.h,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                ClubSelectInput("النادي", licenceController.selectedClub, licenceController),
                                DisciplineSelectInput("الرياضة", licenceController.selectedDiscipline, licenceController),
                                SeasonSelectInput("الموسم", licenceController.selectedSeason, licenceController)

                              ],),
                              SizedBox(height: 2.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [ElevatedButton(onPressed: () async {
                                await licenceController.getDetailedStats();
                              }, child: Text("تاكيد")),
                              SizedBox(width: 5.w,),
                              ElevatedButton(onPressed: (){
                                licenceController.selectedClub=Club(id: -1,name: "");
                                licenceController.selectedSeason=Season(id: -1,seasons: "");
                                licenceController.selectedDiscipline=Discipline(id: -1,name: "");
                                // licenceController.statsWidget=SizedBox();
                                licenceController.detailedStats=[];
                                licenceController.isLoading=false;
                                licenceController.notify();
                              }, child: Text("الغاء")),],
                              ),
                              
                              SizedBox(height: 5.h)
                            ],
                          ),
                          
                          
                        //  licenceController.statsWidget
                         ],
                       ),
                              ),
                    ),
                    SliverToBoxAdapter(
                      child: (licenceController.isLoading==false)?Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                StatCell(txt: "النادي",isColored: true,),
                                StatCell(txt: "ذكور قدماء"),
                                StatCell(txt: "ذكور اكابر"),
StatCell(txt: "ذكور اواسط"),
StatCell(txt: "ذكور اصاغر"),
StatCell(txt: "ذكور اداني"),
StatCell(txt: "ذكور صغار الاداني"),
StatCell(txt: "ذكور اشبال"),
StatCell(txt: "ذكور اشبال"),
StatCell(txt: "مجموع الذكور",isColored: true,),
StatCell(txt: "اناث قدماء"),
                                StatCell(txt: "اناث اكابر"),
StatCell(txt: "اناث اواسط"),
StatCell(txt: "اناث اصاغر"),
StatCell(txt: "اناث اداني"),
StatCell(txt: "اناث صغار الاداني"),
StatCell(txt: "اناث اشبال"),
StatCell(txt: "اناث اشبال"),
StatCell(txt: "مجموع الاناث",isColored: true,),
StatCell(txt: "المجموع",isColored: true,),


                              ],),
                              Column(
                            children: [
                              for(var stat in licenceController.detailedStats)
                              Directionality(
                                 textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                            StatCell(txt: stat['club'],isColored: true,),
                            StatCell(txt: stat['males']["قدماء"].toString()),
                            StatCell(txt: stat['males']["اكابر"].toString()),
                            StatCell(txt: stat['males']["اواسط"].toString()),
                            StatCell(txt: stat['males']["اصاغر"].toString()),
                            StatCell(txt: stat['males']["اداني"].toString()),
                            StatCell(txt: stat['males']["صغار الاداني"].toString()),
                            StatCell(txt: stat['males']["اشبال"].toString()),
                            StatCell(txt: stat['males']["مدارس"].toString()),
                            StatCell(txt: stat['males']["total"].toString(),isColored: true,),
                                    StatCell(txt: stat['females']["قدماء"].toString()),
                            StatCell(txt: stat['females']["اكابر"].toString()),
                            StatCell(txt: stat['females']["اواسط"].toString()),
                            StatCell(txt: stat['females']["اصاغر"].toString()),
                            StatCell(txt: stat['females']["اداني"].toString()),
                            StatCell(txt: stat['females']["صغار الاداني"].toString()),
                            StatCell(txt: stat['females']["اشبال"].toString()),
                            StatCell(txt: stat['females']["مدارس"].toString()),
                            StatCell(txt: stat['females']["total"].toString(),isColored: true,),
                            StatCell(txt: stat['total'].toString(),isColored: true,),


                                  ],
                                ),
                              )
                            ],
                          )
                            ],
                          ):Center(child: CircularProgressIndicator(),),
                    )
    
                  ],
          
                );
            //   }
            // );
          }
        ),
      ),
    );

  }
}
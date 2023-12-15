// ignore_for_file: non_constant_identifier_names, no_logic_in_create_state

import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/Stats.dart';
import 'package:fu_licences/models/season.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Widget imageWidget(){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: SizedBox(
      width: 120.w,
      height: 17.h,
      child: ClipRRect(
  borderRadius: BorderRadius.circular(5),
        child: Image.asset('assets/images/image.PNG',
        fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget SeasonWidget(LicenceProvider licenceController){
  licenceController.activeSeason=licenceController.parameters!.seasons!.firstWhere((element) => element.activated==true);
  return  Directionality(
            textDirection: TextDirection.rtl,

    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("الموسم ",
            style: TextStyle(
              fontSize: 20
            ),
            ),
            Text(licenceController.activeSeason.seasons!,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xff2DA9E0)
            ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget StatItems(Stats stats,context,LicenceProvider licenceController){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Padding(
      padding: const EdgeInsets.only(bottom:12.0),
      child: SizedBox(
        width: 90.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(licenceController.currentUser.club!.id==null)
            InkWell(
              onTap: (){
                GoRouter.of(context).go(Routes.ClubListScreen);
              },
              child: StatItem("النوادي",stats.clubs.toString(),"assets/icons/club-white.png")),
            InkWell(
               onTap: (){
                GoRouter.of(context).go(Routes.AthleteLicenceListScreen);
              },
              child: StatItem("الرياضيين",stats.athletes.toString(),"assets/icons/running-white.png")),
            InkWell(
               onTap: (){
                GoRouter.of(context).go(Routes.CoachLicenceListScreen);
              },
              child: StatItem("المدربين",stats.coaches.toString(),"assets/icons/coach-white.png")),
            InkWell(
               onTap: (){
                GoRouter.of(context).go(Routes.ArbitratorLicenceListScreen);
              },
              child: StatItem("الحكام",stats.arbitrators.toString(),"assets/icons/referee-white.png"))
          ],
        ),
      ),
    ),
  );
}

Widget StatItem(txt,val,img){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Column(
      children: [
        Container(
          width: 22 .w,
          height: 10.h,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 66, 144, 208),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
             BoxShadow(color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 2))
          ]
          ),
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(img,
              scale: 10,
              ),
              Text(val,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white
              ),
              ),
              Text(txt,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15
        ),
        )
            ],
          )),
        ),
        const SizedBox(height: 10,),
      ],
    ),
  );
}

Widget MyChart(Stats stats){
  //print('active '+stats.activeLicences.toString());
  //print('pending '+stats.pendingLicences.toString());
  //print('expired '+stats.expiredLicences.toString());
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Padding(
      padding: const EdgeInsets.only(top:12.0),
      child: SizedBox(
        width: 90.w,
        height: 23.h,
        child: Column(
          children: [
            const SizedBox(height: 16,),
            Container
            (
              width: 90.w,
              height: 21.h,
              decoration: const BoxDecoration(color:  Color.fromARGB(255, 66, 144, 208),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 2)
                )
              ]
              ),
              child: Column(
                children: [
                   const Text("حالة الاجازات",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white
            ),
            ),
            SizedBox(height: 2.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyLegend(),
                      SizedBox(
                        width: 60.w,
              height: 1.h,
                        child: PieChart(
                        swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                        swapAnimationCurve: Curves.linear, // Optional
                        PieChartData(
                          startDegreeOffset: 0,
                          centerSpaceRadius: 0,
                          sectionsSpace: 0,
                          sections: [
                            PieChartSectionData(
                              radius: 120,
                              badgeWidget: Badge(label: Text(stats.expiredLicences.toString(),
                              style: const TextStyle(fontSize: 14),
                              )),
                               badgePositionPercentageOffset: 1.3,
                              showTitle: false,
                            color: Colors.red,
                            value: (stats.expiredLicences!/100)*100,
                            title: stats.expiredLicences.toString(),
                          ),
                           PieChartSectionData(
                             badgeWidget: Badge(
                              backgroundColor: Colors.orange,
                              label: Text(stats.pendingLicences.toString(),
                              style: const TextStyle(fontSize: 14),
                              )),
                               badgePositionPercentageOffset: 1.3,
                              showTitle: false,
                                             radius: 120,
                            color: Colors.orange,
                            value: (stats.pendingLicences!/100)*100,
                            title: stats.pendingLicences.toString()
                          ), PieChartSectionData(
                            color: Colors.green,
                            value: (stats.activeLicences!/100)*100,                
                            radius: 120,
                             badgeWidget: Badge(
                              backgroundColor: Colors.green,
                              label: Text(stats.activeLicences.toString(),
                              style: const TextStyle(fontSize: 14),
                              )),
                               badgePositionPercentageOffset: 1.3,
                              showTitle: false,
                            title: stats.activeLicences.toString()
                          ),
                          ]
                        ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),)
          ],
        ),
      ),
    ),
  );
}

Widget MyLegend(){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: SizedBox(
      width: 30.w,
      height: 15.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [LegendItem("نشطة",Colors.green),
        LegendItem("في الانتظار",Colors.orange),
        LegendItem("منتهية",Colors.red)
        ],
      ),
    ),
  );
}

LegendItem(txt,color){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Padding(
      padding: const EdgeInsets.only(right:16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(color: color,
            borderRadius: const BorderRadius.all(Radius.circular(500))
            ),
          ),
      const SizedBox(width: 10,),
          Text(txt,
          style: const TextStyle(
            fontSize: 16,
              color: Colors.white
          ),
          )
        ],
      ),
    ),
  );
}

Widget RecentLicences(){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: SizedBox(
      width: 90.w,
      height: 30.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("الاجازات الاخيرة",
          style: TextStyle(
            fontSize: 20
          ),
          ),
          const SizedBox(height: 10,),
          SizedBox( width: 90.w,
      height: 20.h,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                RecentLicenceItem(),
                RecentLicenceItem(),
                RecentLicenceItem(),
                RecentLicenceItem(),
                RecentLicenceItem(),
              ],
            ),
          ),
        ],
      )
    ),
  );
}

Widget RecentLicenceItem(){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Padding(
      padding: const EdgeInsets.only(right:20.0,),
      child: Container(
        width: 50.w,
        height: 5.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.grey
        ),
      ),
    ),
  );
}

class BarChartSample1 extends StatefulWidget {
  final String txt;
  BarChartSample1({super.key, required this.txt});
  List<Color> get availableColors => const <Color>[
        Colors.purple,
        Colors.yellow,
        Colors.blue,
        Colors.orange,
        Colors.pink,
        Colors.red,
      ];
  final Color barBackgroundColor =
      Colors.white.withOpacity(0.3);
  final Color barColor = Colors.white;
  final Color touchedBarColor = Colors.blue;

  @override
  State<StatefulWidget> createState() => BarChartSample1State(txt:txt);
}

class BarChartSample1State extends State<BarChartSample1> {
  final String txt;
  late LicenceProvider licenceController;
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  bool isPlaying = false;
  BarChartSample1State({required this.txt});

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
              textDirection: TextDirection.rtl,

      child: SizedBox(
        height: 20.w,
                        width: 30.w,
        child: Column(
          children: [
            Text(txt,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
            SizedBox(height: 1.h,),
            Expanded(
              child: AspectRatio(
                aspectRatio: 20,
                child: BarChart(
                   mainBarData(),
                  swapAnimationDuration: animDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(4, (i) {
    if(txt=="الرياضيين"){
      switch (i) {
          case 0:
            return makeGroupData(0, (licenceController.stats.athletesLicences!.total!/1)*1,isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, (licenceController.stats.athletesLicences!.active!/1)*1, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, (licenceController.stats.athletesLicences!.pending!/1)*1, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, (licenceController.stats.athletesLicences!.expired!/1)*1, isTouched: i == touchedIndex);
          // case 4:
          //   return makeGroupData(4, 9, isTouched: i == touchedIndex);
          // case 5:
          //   return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          // case 6:
          //   return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
    }
    else if(txt=="الحكام"){
      switch (i) {
          case 0:
            return makeGroupData(0, (licenceController.stats.arbitratorsLicences!.total!/1)*1,isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, (licenceController.stats.arbitratorsLicences!.active!/1)*1, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, (licenceController.stats.arbitratorsLicences!.pending!/1)*1, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, (licenceController.stats.arbitratorsLicences!.expired!/1)*1, isTouched: i == touchedIndex);
          // case 4:
          //   return makeGroupData(4, 9, isTouched: i == touchedIndex);
          // case 5:
          //   return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          // case 6:
          //   return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
    }
    else{
      switch (i) {
          case 0:
            return makeGroupData(0, (licenceController.stats.coachesLicences!.total!/1)*1,isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, (licenceController.stats.coachesLicences!.active!/1)*1, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, (licenceController.stats.coachesLicences!.pending!/1)*1, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, (licenceController.stats.coachesLicences!.expired!/1)*1, isTouched: i == touchedIndex);
          // case 4:
          //   return makeGroupData(4, 9, isTouched: i == touchedIndex);
          // case 5:
          //   return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          // case 6:
          //   return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
    }
        
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'المجموع';
                break;
              case 1:
                weekDay = 'نشطة';
                break;
              case 2:
                weekDay = 'في الانتظار';
                break;
              case 3:
                weekDay = 'منتهية';
                break;
              // case 4:
              //   weekDay = 'Friday';
              //   break;
              // case 5:
              //   weekDay = 'Saturday';
              //   break;
              // case 6:
              //   weekDay = 'Sunday';
              //   break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData:  FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      // fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('المجموع', style: style);
        break;
      case 1:
        text = const Text('نشطة', style: style);
        break;
      case 2:
        text = const Text('في الانتظار', style: style);
        break;
      case 3:
        text = const Text('منتهية', style: style);
        break;
      // case 4:
      //   text = const Text('F', style: style);
      //   break;
      // case 5:
      //   text = const Text('S', style: style);
      //   break;
      // case 6:
      //   text = const Text('S', style: style);
      //   break;
      default:
        text = const Text('', style: style);
        break;
    }
    return Directionality(
              textDirection: TextDirection.rtl,

      child: SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16,
        child: text,
      ),
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(4, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              (licenceController.stats.athletesLicences!.total!/1)*1,
              // Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              (licenceController.stats.athletesLicences!.active!/1)*1,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
             (licenceController.stats.athletesLicences!.pending!/1)*1,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
             (licenceController.stats.athletesLicences!.expired!/1)*1,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          // case 4:
          //   return makeGroupData(
          //     4,
          //     Random().nextInt(15).toDouble() + 6,
          //     barColor: widget.availableColors[
          //         Random().nextInt(widget.availableColors.length)],
          //   );
          // case 5:
          //   return makeGroupData(
          //     5,
          //     Random().nextInt(15).toDouble() + 6,
          //     barColor: widget.availableColors[
          //         Random().nextInt(widget.availableColors.length)],
          //   );
          // case 6:
          //   return makeGroupData(
          //     6,
          //     Random().nextInt(15).toDouble() + 6,
          //     barColor: widget.availableColors[
          //         Random().nextInt(widget.availableColors.length)],
          //   );
          default:
            return throw Error();
        }
      }),
      gridData:  FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget imageWidget(){
  return SizedBox(
    width: 90.w,
    height: 15.h,
    // decoration: BoxDecoration(
    //   color: Colors.red,
    //   // borderRadius: BorderRadius.all(Radius.circular(200))
    // ),
    child: ClipRRect(
borderRadius: BorderRadius.circular(5),
      child: Image.asset('assets/images/image.PNG',
      fit: BoxFit.fill,
      
      ),
    ),
  );
}

Widget SeasonWidget(){
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("الموسم ",
          style: TextStyle(
            fontSize: 20
          ),
          ),
          Text("2022-2023",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff2DA9E0)
          ),
          )
        ],
      ),
    ),
  );
}

Widget StatItems(){
  return Padding(
    padding: const EdgeInsets.only(bottom:12.0),
    child: SizedBox(
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatItem("النوادي","50"),
          StatItem("الاجازات","500"),
          StatItem("المسابقات","10")
        ],
      ),
    ),
  );
}

Widget StatItem(txt,val){
  return Column(
    children: [
      Container(
        width: 22 .w,
        height: 12.h,
        decoration: const BoxDecoration(color: Color(0xff92DDFF,
        
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),

        boxShadow: [
           BoxShadow(color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 2))
        ]
        ),
        child: Center(child: Text(val,
        style: const TextStyle(
          fontSize: 22
        ),
        )),
      ),
      const SizedBox(height: 10,),
      Text(txt,
      style: const TextStyle(
        fontSize: 15
      ),
      )
    ],
  );
}


Widget MyChart(){
  return Padding(
    padding: const EdgeInsets.only(top:12.0),
    child: SizedBox(
      width: 90.w,
      height: 40.h,
      child: Column(
        children: [
          const Text("حالة الاجازات",
          style: TextStyle(
            fontSize: 20
          ),
          ),
          const SizedBox(height: 16,),
          Container
          
          (
            
            width: 90.w,
            height: 30.h,
            decoration: const BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 2)
              )
            ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyLegend(),
                SizedBox(
                  width: 60.w,
            height: 30.h,
                  child: PieChart(
                  swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                  swapAnimationCurve: Curves.linear, // Optional
                  PieChartData(
                    
                    startDegreeOffset: 0,
                          
                    centerSpaceRadius: 0,
                    sectionsSpace: 0,
                    sections: [
                      PieChartSectionData(
                        radius: 70,
                        badgeWidget: const Badge(label: Text("20",
                        style: TextStyle(fontSize: 14),
                        
                        )),
                         badgePositionPercentageOffset: 1.3,
                        showTitle: false,
                      color: Colors.red,
                      value: 20,
                      title: "20",
                     
                    ),
                     PieChartSectionData(
                       badgeWidget: const Badge(
                        backgroundColor: Colors.orange,
                        label: Text("80",
                        style: TextStyle(fontSize: 14),
                        
                        )),
                         badgePositionPercentageOffset: 1.3,
                        showTitle: false,
                                       radius: 70,
                          
                      color: Colors.orange,
                      value: 80,
                      title: "80"
                    ), PieChartSectionData(
                      color: Colors.green,
                      value: 400,                radius: 70,
                          
                       badgeWidget: const Badge(
                        backgroundColor: Colors.green,
                        label: Text("400",
                        style: TextStyle(fontSize: 14),
                        
                        )),
                         badgePositionPercentageOffset: 1.3,
                        showTitle: false,
                      title: "400"
                    ),
                    //  PieChartSectionData(
                    //   color: Colors.blue,
                    //   value: 100,
                    //   title: "نشطة"
                    // ),
                    ]
                  ),
                          
                        ),
                ),
              ],
            ),)
        ],
      ),
    ),
  );
}


Widget MyLegend(){
  return SizedBox(
    // color: Colors.red,
    width: 30.w,
    height: 15.h,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [LegendItem("نشطة",Colors.green),
      LegendItem("في الانتظار",Colors.orange),
      LegendItem("منتهية",Colors.red)
      ],
    ),
  );
}

LegendItem(txt,color){
  return Padding(
    padding: const EdgeInsets.only(left:16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color,
          borderRadius: const BorderRadius.all(Radius.circular(500))
          ),
        ),
    const SizedBox(width: 10,),
        Text(txt)
      ],
    ),
  );
}

Widget RecentLicences(){
  return SizedBox(

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
  );
}
Widget RecentLicenceItem(){
  return Padding(
    padding: const EdgeInsets.only(right:20.0,),
    child: Container(
      width: 50.w,
      height: 5.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        
        color: Colors.grey
      ),
    ),
  );
}

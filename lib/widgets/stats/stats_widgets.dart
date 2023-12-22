import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StatCell extends StatelessWidget{
  final String txt;
  final bool isColored;

  const StatCell({super.key, required this.txt,  this.isColored=false});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (isColored==true)?Colors.grey:Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1
        )
      ),
      width: 9.w,
      height: 3.h,
      child: Center(child: Text(txt)),);
    // TODO: implement build
    throw UnimplementedError();
  }

}
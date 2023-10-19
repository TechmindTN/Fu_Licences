import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:sizer/sizer.dart';

AthleteMediaModal(LicenceProvider licenceController,context,String? toFillImage){
  return Column(
    children: [
      InkWell(
        onTap: (() {
          
          licenceController.pickAthleteImage(true,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 5.w,),
              Text('فتح البوم الصور')
            ],
          ),
          
        ),
      ),
      InkWell(
        onTap: (() {
          
          licenceController.pickAthleteImage(false,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 5.w,),
              Text('فتح آلة التصوير'),
            ],
          ),
          
        ),
      ),

    ],
  );
}
CoachMediaModal(LicenceProvider licenceController,context,String? toFillImage){
  return Column(
    children: [
      InkWell(
        onTap: (() async {
          // await licenceController.pickCoachImage(true,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 5.w,),
              Text('فتح البوم الصور')
            ],
          ),
          
        ),
      ),
      InkWell(
        onTap: (() {
          // licenceController.pickCoachImage(false,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 5.w,),
              Text('فتح آلة التصوير'),
            ],
          ),
          
        ),
      ),

    ],
  );
}

ArbitreMediaModal(LicenceProvider licenceController,context,String? toFillImage){
  return Column(
    children: [
      InkWell(
        onTap: (() async {
          // await licenceController.pickArbitreImage(true,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 5.w,),
              Text('فتح البوم الصور')
            ],
          ),
          
        ),
      ),
      InkWell(
        onTap: (() {
          // licenceController.pickArbitreImage(false,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 5.w,),
              Text('فتح آلة التصوير'),
            ],
          ),
          
        ),
      ),

    ],
  );
}

EditMediaModal(LicenceProvider licenceController,context,String? imageName,img){
  return Column(
    children: [
      InkWell(
        onTap: (() {
          
          licenceController.pickAthleteImage(true,context,imageName);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 5.w,),
              Text('فتح البوم الصور')
            ],
          ),
          
        ),
      ),
      InkWell(
        onTap: (() {
          
          licenceController.pickAthleteImage(false,context,imageName);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 5.w,),
              Text('فتح آلة التصوير'),
            ],
          ),
          
        ),
      ),

    ],
  );
}
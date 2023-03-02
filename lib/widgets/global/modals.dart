import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:sizer/sizer.dart';

MediaModal(LicenceProvider licenceController,context,String? toFillImage){
  return Column(
    children: [
      InkWell(
        onTap: (() {
          
          licenceController.pickImage(true,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 5.w,),
              Text("Ouvrir le gallerie des photos")
            ],
          ),
          
        ),
      ),
      InkWell(
        onTap: (() {
          
          licenceController.pickImage(false,context,toFillImage);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 5.w,),
              Text("Ouvrir la camera"),
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
          
          licenceController.pickImage(true,context,imageName);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.photo),
              SizedBox(width: 5.w,),
              Text("Ouvrir le gallerie des photos")
            ],
          ),
          
        ),
      ),
      InkWell(
        onTap: (() {
          
          licenceController.pickImage(false,context,imageName);
        }),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.camera_alt),
              SizedBox(width: 5.w,),
              Text("Ouvrir la camera"),
            ],
          ),
          
        ),
      ),

    ],
  );
}
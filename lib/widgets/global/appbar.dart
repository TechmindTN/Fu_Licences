import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../router/routes.dart';

Widget MyAppBar(title,context,isDrawer,LicenceProvider licenceController,isActions){
  return SliverAppBar(
    actions: (isActions)?[
            PopupMenuButton(
              
              // surfaceTintColor: Colors.white,
              color: Colors.white,
              icon: Icon(Icons.more_vert,color: Colors.black,),
              itemBuilder: (context){
                    //  if(licenceController.currentUser.club!.id!=null)
                     return [
                            PopupMenuItem<int>(
                              
                                value: 0,
                                child: Text("Modifier"),
                            ),

                            PopupMenuItem<int>(
                                value: 1,
                                child: Text("Modifier les images"),
                            ),

                            PopupMenuItem<int>(
                                value: 2,
                                child: Text("Renouvellement"),
                            ),
                            
                        ];
                       
                   },
                   onSelected:(value){
                    if(licenceController.selectedFullLicence!.licence!.role=="Athlete")
                      if(value == 0){
                        GoRouter.of(context).push(Routes.EditAthleteLicenceScreen);
                        // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceScreen())));
                        //  print("My account menu is selected.");
                      }else if(value == 1){
                        GoRouter.of(context).push(Routes.EditAthleteImagesScreen);
                        // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
                        //  print("Settings menu is selected.");
                      }else if(value == 2){
                        GoRouter.of(context).push(Routes.RenewAthleteImages);
                        // Navigator.push(context, MaterialPageRoute(builder: ((context) => RenewLicenceImages())));
                         print("Logout menu is selected.");
                      }
                   }
                   )
          ]:[],
    surfaceTintColor: Colors.white,
     floating: true,
            snap: true,
            pinned: false,
            foregroundColor: Colors.white,
    // collapsedHeight: 10.h,
    leading: Visibility(
      visible: isDrawer,
      child: Builder(
        builder: (context) {
          return IconButton(icon:Icon(Icons.short_text_rounded),
          onPressed: ( ){
            Scaffold.of(context).openDrawer();
          },
          color: Colors.black,
          );
        }
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(title,
    style: TextStyle(color: Colors.black),
    ),
  );
}



Widget MyDrawer(){
  return Drawer(
    
    width: 60.w,
    child: SingleChildScrollView(
      child: Column(
        children: [
          IdentifierField(),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
          DrawerField(Icons.list,"Licences"),
        ],
      ),
    ),
    backgroundColor: Colors.white,

  );
}

Widget IdentifierField(){
  return Container(
    // color: Colors.red,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(
        width: 1,
        color: Colors.black,

      ))
    ),
    height: 15.h,
   child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 8.w,
            child: Container(
              width: 14.w,
              
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(

                  color: Colors.black12,
                  blurRadius: 10,

                )],
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset("assets/icons/activism.png"),
              )),
          ),
          SizedBox(width: 5.w,),
          Text("Power Club",
          style: TextStyle(
            fontSize: 20
          ),
          )
        ],
      ),
      // SizedBox(),
      
   ]),


  );
}


Widget DrawerField(icon,txt){
   return Container(
    // color: Colors.red,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(
        width: 1,
        color: Colors.black,

      ))
    ),
    height: 10.h,
   child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Row(
        children: [
          Icon(icon),
          SizedBox(width: 5.w,),
          Text(txt,
          style: TextStyle(
            fontSize: 20
          ),
          )
        ],
      ),
      // SizedBox(),
      
   ]),


  );
}


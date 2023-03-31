import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../router/routes.dart';

Widget MyAppBar(title,context,isDrawer,LicenceProvider licenceController,isActions,isback){
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
    leading: (isback)?IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
      GoRouter.of(context).pop();
    },):Visibility(
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



Widget MyDrawer(LicenceProvider licenceController,context){
  return Drawer(
    
    width: 30.w,
    child: SingleChildScrollView(
      child: Column(
        children: [
          IdentifierField(licenceController,context),
          DrawerField(Icons.home,"Home",Routes.Home,context),
          DrawerField(Icons.list,"Licences",Routes.LicenceListScreen,context),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
          // DrawerField(Icons.list,"Licences"),
        ],
      ),
    ),
    backgroundColor: Colors.white,

  );
}

Widget IdentifierField(LicenceProvider licenceController,context){
  return Container(
    // color: Colors.red,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(
        width: 1,
        color: Colors.black,

      ))
    ),
    height: 10.h,
   child: Center(
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 4.w,
                  child: Container(
                    width: 7.w,
                    
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
                      
                      child: Image.asset("assets/images/logo-ftwkf.png",
                      // scale: 0.,
                      ),
                    )),
                ),
                SizedBox(width: 2.w,),
                Text((licenceController.currentUser.club!.id!=null)?licenceController.currentUser.club!.name.toString():"Admin",
                style: TextStyle(
                  fontSize: 20
                ),
                )
              ],
            ),
            // SizedBox(),
            
         ]),
         SizedBox(height: 1.h,),
         InkWell(
          onTap: () {
            showDialog(context: context, builder: (context){
              return LogoutDialog(licenceController,context);
            });
            // licenceController.logout(context);
          },
           child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Color(0xff2DA9E0),width: 2 )
              // color: Color(0xff92DDFF),
              // color: Colors.red,
            
            ),
            width: 20.w,
            
            height: 3.h,
            child: Center(child: Text("Logout",
            style: TextStyle(
              color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18
         
            ),
            ),),
                 ),
         )
       ],
     ),
   ),


  );
}


Widget DrawerField(icon,txt,togo,context,){
   return InkWell(
    onTap: (){
      GoRouter.of(context).go(togo);
    },
     child: Container(
      // color: Colors.red,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(
          width: 1,
          color: Colors.black,
   
        ))
      ),
      height: 4.h,
     child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 6.w,),
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 3.w,),
            Text(txt,
            style: TextStyle(
              fontSize: 20
            ),
            )
          ],
        ),
        // SizedBox(),
        
     ]),
   
   
     ),
   );
}


Widget LogoutDialog(LicenceProvider licenceController,context){
  return AlertDialog(
    title: Text("Logout"),
    content: Text("Voulez vous vraiment quitter?"),
    actions: [
      TextButton(onPressed: (){
        licenceController.logout(context);
      }, child: Text("Logut",
      style: TextStyle(
        color: Colors.red
      ),
      )),
      TextButton(onPressed: (){}, child: Text("Cancel"))
    ],
  );
}


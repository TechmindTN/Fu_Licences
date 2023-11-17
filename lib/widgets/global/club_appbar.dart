// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../router/routes.dart';

Widget MyClubAppBar(title,context,isDrawer,LicenceProvider licenceController,isActions,isback){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: SliverAppBar(
      
      actions: (isActions)?[
              PopupMenuButton(
                
                // surfaceTintColor: Colors.white,
                color: Colors.white,
                icon: const Icon(Icons.more_vert,color: Colors.black,),
                itemBuilder: (context){
                      //  if(licenceController.currentUser.club!.id!=null)
                       return [
                              const PopupMenuItem<int>(
                                
                                  value: 0,
                                  child: Text("تعديل النادي"),
                              ),
  
                              const PopupMenuItem<int>(
                                  value: 1,
                                  child: Text("تعديل صور النادي"),
                              ),
  
                              const PopupMenuItem<int>(
                                  value: 2,
                                  child: Text("تعديل كلمة المرور"),
                              ),
                              
                          ];
                         
                     },
                     onSelected:(value){
                      if(value==0){
                                                GoRouter.of(context).push(Routes.EditClubScreen);
  
                      }
                      else if(value==2){
                        GoRouter.of(context).push(Routes.ChangePassword);
                      }
  
                    //   if(licenceController.selectedFullLicence!.licence!.role=="رياضي"){
                    //     if(value == 0){
                    //       GoRouter.of(context).push(Routes.EditAthleteLicenceScreen);
                    //       // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceScreen())));
                    //     }else if(value == 1){
                    //       GoRouter.of(context).push(Routes.EditAthleteImagesScreen);
                    //       // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
                    //     }else if(value == 2){
                    //       GoRouter.of(context).push(Routes.RenewAthleteImages);
                    //       // Navigator.push(context, MaterialPageRoute(builder: ((context) => RenewLicenceImages())));
                    //     }
                    //  }
                    //   else if(licenceController.selectedFullLicence!.licence!.role=="حكم"){
                    //     if(value==0){
                    //       GoRouter.of(context).push(Routes.EditArbitratorLicenceScreen);
                    //     }
                    //     else if(value == 1){
                    //       GoRouter.of(context).push(Routes.EditArbitratorImagesScreen);
                    //       // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
                    //     }
                    //     else if(value == 2){
                    //       GoRouter.of(context).push(Routes.RenewArbitratorImagesScreen);
                    //       // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
                    //     }
                    //   }
                    //   else if(licenceController.selectedFullLicence!.licence!.role=="مدرب"){
                    //     if(value==0){
                    //       GoRouter.of(context).push(Routes.EditCoachLicenceScreen);
                    //     }
                    //     else if(value == 1){
                    //       GoRouter.of(context).push(Routes.EditCoachImagesScreen);
                    //       // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
                    //     }
                    //     else if(value == 2){
                    //       GoRouter.of(context).push(Routes.RenewCoachImagesScreen);
                    //       // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
                    //     }
                    //   }
                     }
                    
                     )
            ]:[],
      surfaceTintColor: Colors.white,
       floating: true,
              snap: true,
              pinned: false,
              foregroundColor: Colors.white,
      // collapsedHeight: 10.h,
      leading: (isback)?IconButton(icon:const Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
        GoRouter.of(context).pop();
      },):Visibility(
        visible: isDrawer,
        child: Builder(
          builder: (context) {
            return IconButton(icon:const Icon(Icons.short_text_rounded),
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
      style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}



Widget MyDrawer(LicenceProvider licenceController,context){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Drawer(
      
      width: 30.w,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            IdentifierField(licenceController,context),
            DrawerField(Icons.home,'الشاشة الرئيسية',Routes.Home,context),
            DrawerField(Icons.list,'الاجازات',Routes.LicenceListScreen,context),
            DrawerField(Icons.list,"النوادي",Routes.ClubListScreen,context),
            DrawerField(Icons.list,'الاعدادات',Routes.SelectParameterScreen,context),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
            // DrawerField(Icons.list,'الاجازات'),
          ],
        ),
      ),
  
    ),
  );
}

Widget IdentifierField(LicenceProvider licenceController,context){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Container(
      // color: Colors.red,
      decoration: const BoxDecoration(
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
                        boxShadow: const [BoxShadow(
     
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
                  style: const TextStyle(
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
                border: Border.all(color: const Color(0xff2DA9E0),width: 2 )
                // color: Color(0xff92DDFF),
                // color: Colors.red,
              
              ),
              width: 20.w,
              
              height: 3.h,
              child: const Center(child: Text("تسجيل الخروج",
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
  
  
    ),
  );
}


Widget DrawerField(icon,txt,togo,context,){
   return Directionality(
            textDirection: TextDirection.rtl,

     child: InkWell(
      onTap: (){
        GoRouter.of(context).go(togo);
      },
       child: Container(
        // color: Colors.red,
        decoration: const BoxDecoration(
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
              style: const TextStyle(
                fontSize: 20
              ),
              )
            ],
          ),
          // SizedBox(),
          
       ]),
     
     
       ),
     ),
   );
}


Widget LogoutDialog(LicenceProvider licenceController,context){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: AlertDialog(
      title: const Text("تسجيل الخروج"),
      content: const Text("هل تود فعلا الخروج؟؟"),
      actions: [
        TextButton(onPressed: (){
          licenceController.logout(context);
        }, child: const Text("تسجيل الخروج",
        style: TextStyle(
          color: Colors.red
        ),
        )),
        TextButton(onPressed: (){}, child: const Text("الغاء"))
      ],
    ),
  );
}


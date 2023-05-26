import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/licence_controller.dart';
import '../../router/routes.dart';

Widget ParamCard( param, context,LicenceProvider licenceController) {
  // if(licenceController.currentUser.club!.id==null){
    String img="assets/images/logo-ftwkf.png";
  //  if (role.roles == "Athlete") {
  //             print('athlete');
  //             img="assets/icons/running-white.png";
  //           }
  //           else if (role.roles == "Entraineur") {
  //             img="assets/icons/coach-white.png";
  //           }else if (role.roles == "Arbitre") {
  //             img="assets/icons/referee-white.png";
  //           }else if (role.roles == "club") {
  //             img="assets/icons/club-white.png";
  //           }
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {
            // licenceController.selectedRole=role;
            if (param == "Ligue") {
              
              GoRouter.of(context).push(Routes.LigueListScreen);
             
            }
            else if (param== "Categorie") {
              // img="assets/icons/coach.png";
              GoRouter.of(context).push(Routes.CategoryListScreen);
             
            }
             else if (param == "Grade") {
              GoRouter.of(context).push(Routes.GradeListScreen);
             
            }
            else if (param == "Degree") {
              GoRouter.of(context).push(Routes.DegreeListScreen);
              
            }
            else if (param == "Discipline") {
              GoRouter.of(context).push(Routes.DisciplineListScreen);
              
            }
            else if (param == "Poids") {
              GoRouter.of(context).push(Routes.WeightListScreen);
              
            }
            else if (param == "Saison") {
              GoRouter.of(context).push(Routes.SeasonListScreen);
              
            }
          }),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xff92DDFF,
        
        )  ),
              width: 20.w,
              height: 12.h,
              child: Center(child: 
              Image.asset(img,
              width: 12.w,
              )
              )),
        ),
      ),
      Text(param,
         style: TextStyle(
                fontSize: 18
              ),)
    ],
  );
  // }

  //  else{
  //   if(role.roles=="club"||role.roles=="manager"){
  //     return SizedBox();
  //   }
  //   else{
  //      return Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: InkWell(
  //     onTap: (() {
  //       licenceController.selectedRole=role;
  //       // if (role.roles == "Athlete") {
  //       //   GoRouter.of(context).push(Routes.UploadAthleteImagesScreen);
  //       //   // Navigator.push(context,
  //       //   //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
  //       // }
  //       // else if (role.roles == "Entraineur") {
  //       //   GoRouter.of(context).push(Routes.UploadCoachImagesScreen);
  //       //   // Navigator.push(context,
  //       //   //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
  //       // }else if (role.roles == "Arbitre") {
  //       //   GoRouter.of(context).push(Routes.UploadArbitreImagesScreen);
  //       //   // Navigator.push(context,
  //       //   //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
  //       // }
  //       // else if (role.roles == "club") {
  //       //   GoRouter.of(context).push(Routes.AddProfileScreen);
  //       //   // Navigator.push(context,
  //       //   //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
  //       // }
  //     }),
  //     child: Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(5)),
  //             color: Colors.red),
  //         width: 60.w,
  //         height: 10.h,
  //         child: Center(child: Text(role.roles!))),
  //   ),
  // );
  //   }

  // }
}
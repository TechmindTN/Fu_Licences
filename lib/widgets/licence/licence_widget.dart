import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/models/role.dart';
import 'package:fu_licences/screens/licence/addlicence/add_licence_screen.dart';
import 'package:fu_licences/screens/licence/addlicence/upload_athlete_images_screen.dart';
import 'package:fu_licences/screens/licence/filtered_licences_list.dart';
import 'package:fu_licences/screens/licence/licence_screen.dart';
import 'package:fu_licences/widgets/global/modals.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../global/utils.dart';
import '../../router/routes.dart';
import '../global/inputs.dart';

Widget LicenceItem(
    FullLicence fullLicence, LicenceProvider licenceController, context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        // autogroupqd1zLpG (F37U4uNLqRBdFGbp4sQD1z)

        // //width: double.infinity,
        //height: double.infinity,
        width: 90.w,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            licenceController.selectedFullLicence = fullLicence;
            // Navigator.push(context,
            //     MaterialPageRoute(builder: ((context) => LicenceScreen())));
            GoRouter.of(context).push(Routes.LicenceScreen);
            // Navigator.pushNamed(context, Routes.LicenceScreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // autogroupitbe2SC (F37UKZcanBTmfvyEYdiTBE)
                  margin: EdgeInsets.fromLTRB(2, 0, 0, 6),
                  //width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // licencenum16358749xKr (1:62)
                        margin: EdgeInsets.fromLTRB(0, 0, 27, 0),
                        child: Text(
                          'num : ' + fullLicence.licence!.numLicences!,
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Text(
                        // valideTXW (1:64)
                        fullLicence.licence!.state!,
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.2125,
                          color: (fullLicence.licence!.state.toString() ==
                                  "Activee")
                              ? Color(0xff02ce16)
                              : (fullLicence.licence!.state.toString() ==
                                      "En Attente")
                                  ? Color(0xfff5700a)
                                  : Color(0xfffc0303),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // autogroupubylbtc (F37UQoxqf6Dn3wXHhuubYL)
                  margin: EdgeInsets.fromLTRB(0, 0, 110, 3),
                  //width: double.infinity,
                  height: 18.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // man2L5W (2:231)
                        margin: EdgeInsets.fromLTRB(0, 2, 2, 0),
                        width: 65,
                        height: 65,
                        child: (fullLicence.profile!.profilePhoto != null &&
                                fullLicence.profile!.profilePhoto != "")
                            ? Image.network(fullLicence.profile!.profilePhoto!)
                            : Image.asset(
                                'assets/icons/man.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                      Container(
                        // autogroupf8ygfNg (F37UWyTEf3kHxVUS2BF8YG)
                        //height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // athletecYp (1:65)
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(
                                fullLicence.licence!.role!,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2125,
                                  color: Color(0xff717171),
                                ),
                              ),
                            ),
                            Container(
                              // mohsenclub8XA (1:63)
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                              child: Text(
                                fullLicence.licence!.club.toString(),
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2125,
                                  color: Color(0xff717171),
                                ),
                              ),
                            ),
                            Text(
                              // akaberTZS (2:232)
                              fullLicence.licence!.categorie.toString(),
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xff717171),
                              ),
                            ),
                            Text(
                              fullLicence.profile!.state.toString(),
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xff717171),
                              ),
                            ),
                            Text(
                              fullLicence.licence!.seasons.toString()!,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.2125,
                                color: Color(0xff717171),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   // benarouscBS (2:233)
                //   margin: EdgeInsets.fromLTRB(0, 0, 68, 5),
                //   child: Text(
                //     'Ben Arous',
                //     style: SafeGoogleFont (
                //       'Inter',
                //       fontSize: 18,
                //       fontWeight: FontWeight.w400,
                //       height: 1.2125,
                //       color: Color(0xff717171),
                //     ),
                //   ),
                // ),
                // Container(
                //   // 8Qg (2:234)
                //   margin: EdgeInsets.fromLTRB(0, 0, 58, 0),
                //   child: Text(
                //     '2022-2023',
                //     style: SafeGoogleFont (
                //       'Inter',
                //       fontSize: 18,
                //       fontWeight: FontWeight.w400,
                //       height: 1.2125,
                //       color: Color(0xff717171),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget LicenceRow(String key, dynamic value) {
  return Container(
    // autogroup88fjWYp (F37ZNvBnENG3MzFKy188fJ)
    margin: EdgeInsets.fromLTRB(51, 0, 36, 24),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // ageqb6 (1:95)
          // margin: EdgeInsets.fromLTRB(0, 0, 120, 0),
          child: Text(
            key,
            style: SafeGoogleFont(
              'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1.2125,
              color: Color(0xff717171),
            ),
          ),
        ),
        Text(
          // MZS (1:96)
          value.toString(),
          style: SafeGoogleFont(
            'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.2125,
            color: Color(0xff717171),
          ),
        ),
      ],
    ),
  );
}

Widget RolePhotos(FullLicence fullLicence,context,LicenceProvider licenceController) {
  if (fullLicence.licence!.role == "Athlete") {
    return AthletePhotosWidget(fullLicence,licenceController,context);
  } else if (fullLicence.licence!.role == "Arbitre") {
    return ArbitratorPhotosWidget(fullLicence,licenceController,context);
  } else if (fullLicence.licence!.role == "Entraineur") {
    return CoachPhotosWidget(fullLicence,licenceController,context);
  } else {
    return SizedBox();
  }
}

Widget ArbitratorPhotosWidget(FullLicence fullLicence,LicenceProvider licenceController,context) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      (fullLicence.arbitrator!.identityPhoto != null &&
              fullLicence.arbitrator!.identityPhoto != "")
          ? InkWell(
            onTap: () {
                        licenceController.showImage(context,fullLicence.arbitrator!.identityPhoto);
                      },
            child: Image.network(
                fullLicence.arbitrator!.identityPhoto!,
                width: 40.w,
              ),
          )
          : Image.asset(
              'assets/icons/man.png',
              width: 40.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.arbitrator!.photo != null &&
              fullLicence.arbitrator!.photo != "")
          ? InkWell(
            onTap: () {
                        licenceController.showImage(context,fullLicence.arbitrator!.photo);
                      },
            child: Image.network(
                fullLicence.arbitrator!.photo!,
                width: 40.w,
              ),
          )
          : Image.asset(
              'assets/icons/man.png',
              width: 40.w,
              fit: BoxFit.cover,
            ),
    ]),
  );
}

Widget CoachPhotosWidget(FullLicence fullLicence,LicenceProvider licenceController,context) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      (fullLicence.coach!.identityPhoto != null &&
              fullLicence.coach!.identityPhoto != "")
          ? InkWell(
            onTap: () {
                        licenceController.showImage(context,fullLicence.coach!.identityPhoto);
                      },
            child: Image.network(
                fullLicence.coach!.identityPhoto!,
                width: 20.w,
              ),
          )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.coach!.photo != null && fullLicence.coach!.photo != "")
          ? InkWell(
            onTap: () {
                        licenceController.showImage(context,fullLicence.coach!.photo);
                      },
            child: Image.network(
                fullLicence.coach!.photo!,
                width: 20.w,
              ),
          )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.coach!.degreePhoto != null &&
              fullLicence.coach!.degreePhoto != "")
          ? InkWell(
            onTap: () {
                        licenceController.showImage(context,fullLicence.coach!.degreePhoto);
                      },
            child: Image.network(
                fullLicence.coach!.degreePhoto!,
                width: 20.w,
              ),
          )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.coach!.gradePhoto != null &&
              fullLicence.coach!.gradePhoto != "")
          ? InkWell(
            onTap: () {
                        licenceController.showImage(context,fullLicence.coach!.gradePhoto);
                      },
            child: Image.network(
                fullLicence.coach!.gradePhoto!,
                width: 20.w,
              ),
          )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
    ]),
  );
}

Widget AthletePhotosWidget(FullLicence fullLicence,LicenceProvider licenceController,context) {
  print('object');
  return Container(
    constraints: BoxConstraints(maxWidth: 100.w),
    width: 100.w,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 18.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (fullLicence.athlete!.identityPhoto != null &&
                        fullLicence.athlete!.identityPhoto != "")
                    ? InkWell(
                      onTap: () {
                        licenceController.showImage(context,fullLicence.athlete!.identityPhoto);
                      },
                      child: Image.network(
                          fullLicence.athlete!.identityPhoto!,
                          fit: BoxFit.cover,
                          width: 30.w,
                        ),
                    )
                    : Image.asset(
                        'assets/icons/man.png',
                        fit: BoxFit.cover,
                        width: 30.w,
                      ),
                Center(child: Text('Identite'))
              ],
            ),
          ),
          Container(
            height: 18.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (fullLicence.athlete!.photo != null &&
                        fullLicence.athlete!.photo != "")
                    ? InkWell(
                      onTap: () {
                        licenceController.showImage(context,fullLicence.athlete!.photo);
                      },
                      child: Image.network(
                          fullLicence.athlete!.photo!,
                          fit: BoxFit.cover,
                          width: 30.w,
                        ),
                    )
                    : Image.asset(
                        'assets/icons/man.png',
                        fit: BoxFit.cover,
                        width: 30.w,
                      ),
                Center(child: Text('Assurance'))
              ],
            ),
          ),
          Container(
            height: 18.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (fullLicence.athlete!.medicalPhoto != null &&
                        fullLicence.athlete!.medicalPhoto != "")
                    ? InkWell(
                      onTap: () {
                        licenceController.showImage(context,fullLicence.athlete!.medicalPhoto);
                      },
                      child: Image.network(
                          fullLicence.athlete!.medicalPhoto!,
                          fit: BoxFit.cover,
                          width: 30.w,
                        ),
                    )
                    : Image.asset(
                        'assets/icons/man.png',
                        fit: BoxFit.cover,
                        width: 30.w,
                      ),
                Center(child: Text('Fiche medical'))
              ],
            ),
          ),
        ]),
  );
}

Widget RoleCard(Role role, context,LicenceProvider licenceController) {
  if(licenceController.currentUser.club!.id==null){

  
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {
            licenceController.selectedRole=role;
            if (role.roles == "Athlete") {
              GoRouter.of(context).push(Routes.UploadAthleteImagesScreen);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
            }
            else if (role.roles == "Entraineur") {
              GoRouter.of(context).push(Routes.UploadCoachImagesScreen);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
            }else if (role.roles == "Arbitre") {
              GoRouter.of(context).push(Routes.UploadArbitreImagesScreen);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
            }
          }),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey  ),
              width: 35.w,
              height: 20.h,
              child: Center(child: 
              Image.asset("assets/images/logo-ftwkf.png")
              )),
        ),
      ),
      Text(role.roles!,
         style: TextStyle(
                fontSize: 18
              ),)
    ],
  );}

   else{
    if(role.roles=="club"||role.roles=="manager"){
      return SizedBox();
    }
    else{
       return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (() {
        licenceController.selectedRole=role;
        if (role.roles == "Athlete") {
          GoRouter.of(context).push(Routes.UploadAthleteImagesScreen);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
        }
        else if (role.roles == "Entraineur") {
          GoRouter.of(context).push(Routes.UploadCoachImagesScreen);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
        }else if (role.roles == "Arbitre") {
          GoRouter.of(context).push(Routes.UploadArbitreImagesScreen);
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => UploadLicenceImages())));
        }
      }),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.red),
          width: 60.w,
          height: 10.h,
          child: Center(child: Text(role.roles!))),
    ),
  );
    }

  }
}

Widget AthleteImageUploadWidget(txt, licenceController, context,
    String? toFillImage, String? placeHolderImage) {
  return Consumer<LicenceProvider>(

    builder: (context,licenceController,child) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (() {}),
              child: Container(
                  decoration: BoxDecoration(
                    image: (placeHolderImage != null)
                      ? DecorationImage(image: NetworkImage(placeHolderImage,
                      
                      ),
                      fit: BoxFit.cover
                      ):null,
                    boxShadow: [
                      BoxShadow(color: Colors.black26),
                      BoxShadow(
                        color: Color(0xffD9D9D9),
                        spreadRadius: -12,
                        blurRadius: 20,

                      )
                    ],
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      // color: Color(0xffD9D9D9)
                      ),
                  width: 60.w,
                  height: 45.h,
                  // child: (placeHolderImage != null)
                  //     ? Image.network(placeHolderImage,
                  //     fit: BoxFit.fill,

                  //     )
                  //     : Center()
                      ),
            ),
          ),
          // Text(placeHolderImage.toString()),
          Text(txt),
          SizedBox(
            height: 1.h,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AthleteMediaModal(licenceController, context, toFillImage);
                  });
            },
            label: Text("Select"),
          )
        ],
      );
    }
  );
}


Widget CoachImageUploadWidget(txt, licenceController, context,
    String? toFillImage, String? placeHolderImage) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {}),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.red),
              width: 60.w,
              height: 40.h,
              child: (placeHolderImage != null)
                  ? Image.network(placeHolderImage)
                  : Center()),
        ),
      ),
      // Text(placeHolderImage.toString()),
      Text(txt),
      SizedBox(
        height: 1.h,
      ),
      FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return CoachMediaModal(licenceController, context, toFillImage);
              });
        },
        label: Text("Select"),
      )
    ],
  );
}

Widget ArbitreImageUploadWidget(txt, licenceController, context,
    String? toFillImage, String? placeHolderImage) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {}),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.red),
              width: 60.w,
              height: 40.h,
              child: (placeHolderImage != null)
                  ? Image.network(placeHolderImage)
                  : Center()),
        ),
      ),
      // Text(placeHolderImage.toString()),
      Text(txt),
      SizedBox(
        height: 1.h,
      ),
      FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ArbitreMediaModal(licenceController, context, toFillImage);
              });
        },
        label: Text("Select"),
      )
    ],
  );
}

Widget AthleteImageEditWidget(
    txt, LicenceProvider licenceController, context, imageName, img) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {}),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.red),
              width: 60.w,
              height: 40.h,
              child: (img != null) ? Image.network(img) : Center()),
        ),
      ),
      // Text(placeHolderImage.toString()),
      Text(txt),
      SizedBox(
        height: 1.h,
      ),
      FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return EditMediaModal(
                    licenceController, context, imageName, img);
              });
        },
        label: Text("Select"),
      )
    ],
  );
}

SearchDialog(LicenceProvider licenceController, numControl, context) {
  return AlertDialog(
    title: Text('Recherche avec numero de licence'),
    content: Container(
        width: 70.w,
        height: 10.h,
        child: Center(
          child: TextFormField(
            controller: numControl,
          ),
        )),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              licenceController.findLicence(numControl.text, context);
            },
            child: Container(
              child: Center(child: Text('Confirmer')),
            ),
          )
        ],
      )
    ],
  );
}

FilterDialog(LicenceProvider licenceController, context) {
  return AlertDialog(
    
    contentPadding: EdgeInsets.only(left: 4,right: 4,top: 24,bottom: 20),
    insetPadding: EdgeInsets.symmetric(horizontal: 36,vertical: 24),
    scrollable: true,
    title: Center(child: Text('Filtrer')),
    content: Container(
        width: 100.w,
        // height: 90.h,
        child: Center(
          child: Column(
            
            children: [
              SeasonSelectInput('Season',licenceController.selectedSeason,licenceController),
              
              GategorySelectInput('Categorie',licenceController.filteredCategory,licenceController),
                  GradeSelectInput('Grade',licenceController.filteredGrade,licenceController)	,
                  DegreeSelectInput('Degree',licenceController.filteredDegree,licenceController),
                  DisciplineSelectInput('Discipline',licenceController.filteredDiscipline,licenceController)	,
                
                  WeightSelectInput('Poids',licenceController.filteredWeight,licenceController),
                  if(licenceController.currentUser.club?.id==null)
                  ClubSelectInput('Club',licenceController.filteredClub,licenceController),
                   SelectInput('Sexe',licenceController.filteredSex,licenceController,['Male','Femelle']),
                   SelectInput('Etat',licenceController.filteredStatus,licenceController,['Activee','En Attente','Expiree']),
            ],
          ),

          // child: TextFormField(
          //   controller: numControl,
          // ),
        )),
        actionsPadding: EdgeInsets.all(0),
    actions: [
      Container(
        color: Color(0xff4C9AFF),
        width: 100.w,
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                licenceController.filterLicences(context);
                
                // licenceController.findLicence(numControl.text, context);
              },
              child: Container(
                
                child: Center(child: Text('Confirmer',
                style: TextStyle(
                  color: Colors.white
                ),
                )),
              ),
            )
          ],
        ),
      )
    ],
  );
}


Widget LicenceListHeader(LicenceProvider licenceController,numControl,context){
  return Center(
    child: Container(
      width: 90.w,
      child: Column(
       children: [
        // SizedBox(height: 5.h,),
         FirstRow(licenceController),
         SizedBox(height: 3.h,),
        SearchFilter(licenceController,numControl,context),
        SizedBox(height: 3.h,)
       ],
      ),
    ),
  );
}

Widget FirstRow(LicenceProvider licenceController){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text("Total: "+licenceController.fullLicences.length.toString(),
     style: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20
    ),),
    Text("Details de filtre >>",
    style: TextStyle(
      color: Color(0xff2DA9E0),
      fontSize: 20,
      // fontWeight: FontWeight.w600
    ),
    )
  ],);
}

Widget SearchFilter(LicenceProvider licenceController,numControl,context){
  return Row(
    children: [
      SearchField(licenceController,numControl,context),
      SizedBox(width: 5.w,),
      FilterField(licenceController,context)
    ],
  );
}

Widget SearchField(LicenceProvider licenceController,numControl,context){
  return Container(
    width: 68.w,
    height: 8.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0,2)
        )
      ],
      color: Colors.white
    ),
    child: SearchInput(licenceController,numControl,context)
  );
}
Widget FilterField(LicenceProvider licenceController,context){
  return InkWell(
    onTap: (){
      licenceController.showFilterDialog(context);
    },
    child: Container(
      width: 17.w,
        height: 8.h,
        color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0,2)
            )
          ],
        ),
    
        // constraints: BoxConstraints(
        //   maxWidth: 8.w
        // ),
        width: 8.w,
        height: 8.h,
        child: Image.asset("assets/icons/filter.png",
        scale: 9,
        width: 12,
        ),
      ),
    ),
  );
  // return Container(
  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.circular(6),
  //     color: Colors.white,
  //      boxShadow: [
        
  //       BoxShadow(
  //         color: Colors.black26,
  //         blurRadius: 10,
  //         offset: Offset(0,2)
  //       )
  //     ],
  //   ),
  //   // width: 17.w,
    
  //   height: 8.h,
  //   child: Container(
  //     constraints: BoxConstraints(maxWidth: 8.w,
  //     maxHeight: 2.h
  //     ),
  //     width: 8.w,
  //     height: 2.h,
      
  //     child: Image.asset("assets/icons/filter.png",
  //     fit: BoxFit.cover,
  //     // width: 5.w,
  //     // height: 10,
  //     width: 10,
  //     ),
  //   ),
  // );
}

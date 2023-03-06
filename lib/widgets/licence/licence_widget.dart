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
        width: 80.w,
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
                              fullLicence.licence!.seasons!,
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

Widget RolePhotos(FullLicence fullLicence) {
  if (fullLicence.licence!.role == "Athlete") {
    return AthletePhotosWidget(fullLicence);
  } else if (fullLicence.licence!.role == "Arbitre") {
    return ArbitratorPhotosWidget(fullLicence);
  } else if (fullLicence.licence!.role == "Entraineur") {
    return CoachPhotosWidget(fullLicence);
  } else {
    return SizedBox();
  }
}

Widget ArbitratorPhotosWidget(FullLicence fullLicence) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      (fullLicence.arbitrator!.identityPhoto != null &&
              fullLicence.arbitrator!.identityPhoto != "")
          ? Image.network(
              fullLicence.arbitrator!.identityPhoto!,
              width: 40.w,
            )
          : Image.asset(
              'assets/icons/man.png',
              width: 40.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.arbitrator!.photo != null &&
              fullLicence.arbitrator!.photo != "")
          ? Image.network(
              fullLicence.arbitrator!.photo!,
              width: 40.w,
            )
          : Image.asset(
              'assets/icons/man.png',
              width: 40.w,
              fit: BoxFit.cover,
            ),
    ]),
  );
}

Widget CoachPhotosWidget(FullLicence fullLicence) {
  return Container(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      (fullLicence.coach!.identityPhoto != null &&
              fullLicence.coach!.identityPhoto != "")
          ? Image.network(
              fullLicence.coach!.identityPhoto!,
              width: 20.w,
            )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.coach!.photo != null && fullLicence.coach!.photo != "")
          ? Image.network(
              fullLicence.coach!.photo!,
              width: 20.w,
            )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.coach!.degreePhoto != null &&
              fullLicence.coach!.degreePhoto != "")
          ? Image.network(
              fullLicence.coach!.degreePhoto!,
              width: 20.w,
            )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
      (fullLicence.coach!.gradePhoto != null &&
              fullLicence.coach!.gradePhoto != "")
          ? Image.network(
              fullLicence.coach!.gradePhoto!,
              width: 20.w,
            )
          : Image.asset(
              'assets/icons/man.png',
              width: 20.w,
              fit: BoxFit.cover,
            ),
    ]),
  );
}

Widget AthletePhotosWidget(FullLicence fullLicence) {
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
                    ? Image.network(
                        fullLicence.athlete!.identityPhoto!,
                        fit: BoxFit.cover,
                        width: 30.w,
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
                    ? Image.network(
                        fullLicence.athlete!.photo!,
                        fit: BoxFit.cover,
                        width: 30.w,
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
                    ? Image.network(
                        fullLicence.athlete!.medicalPhoto!,
                        fit: BoxFit.cover,
                        width: 30.w,
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

Widget AthleteImageUploadWidget(txt, licenceController, context,
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
                return AthleteMediaModal(licenceController, context, toFillImage);
              });
        },
        label: Text("Select"),
      )
    ],
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

FilterDialog(LicenceProvider licenceController, numControl, context) {
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
                  ClubSelectInput('Club',licenceController.filteredClub,licenceController),
                   SelectInput('Sexe',licenceController.filteredSex,licenceController,['Male','Femelle']),
                   SelectInput('Etat',licenceController.filteredStatus,licenceController,['Activee','En Attante','Expiree']),
            ],
          ),

          // child: TextFormField(
          //   controller: numControl,
          // ),
        )),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              licenceController.filterLicences(context);
              
              // licenceController.findLicence(numControl.text, context);
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

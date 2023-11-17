// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/category.dart';
import 'package:fu_licences/models/club.dart';
import 'package:fu_licences/models/degree.dart';
import 'package:fu_licences/models/discipline.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/models/grade.dart';
import 'package:fu_licences/models/role.dart';
import 'package:fu_licences/models/weight.dart';
import 'package:fu_licences/widgets/global/buttons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../global/utils.dart';
import '../../router/routes.dart';
import '../global/inputs.dart';

Widget LicenceItem(
    FullLicence fullLicence, LicenceProvider licenceController, context) {
      // print(fullLicence);
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Center(
      child: Container(
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
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
            GoRouter.of(context).push(Routes.LicenceScreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                        margin: const EdgeInsets.fromLTRB(2, 2, 0, 0),
                        height: 8.h,
                        child: (fullLicence.profile!.profilePhoto != null &&
                                fullLicence.profile!.profilePhoto != "")
                            ? Image.network(fullLicence.profile!.profilePhoto!)
                            : Image.asset(
                                'assets/icons/man.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 1.h,),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 2, 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(27, 0, 0, 0),
                        child: Text(
                          'رقم : ${fullLicence.licence!.numLicences!}',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      Text(
                        fullLicence.licence!.state!,
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: (fullLicence.licence!.state.toString() ==
                                  "نشطة")
                              ? const Color(0xff02ce16)
                              : (fullLicence.licence!.state.toString() ==
                                      "في الانتظار")
                                  ? const Color(0xfff5700a)
                                  : const Color(0xfffc0303),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(110, 0, 0, 3),
                  height: 1.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 38.w,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "نوع الاجازة",
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                Text(
                                  fullLicence.licence!.role!,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff717171),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 38.w,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "النادي",
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                Text(
                                  fullLicence.licence!.club.toString(),
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff717171),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            width: 38.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "العمر",
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                Text(
                                  fullLicence.licence!.categorie.toString(),
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff717171),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            width: 38.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'الولاية',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                Text(
                                  fullLicence.profile!.state.toString(),
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff717171),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                            width: 38.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Text(
                                  'الموسم',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff000000),
                                  ),
                                ),
                                Text(
                                  fullLicence.licence!.seasons.toString(),
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff717171),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget LicenceRow(String key, dynamic value) {
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Container(
      margin: const EdgeInsets.fromLTRB(51, 0, 36, 24),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            key,
            style: SafeGoogleFont(
              'Inter',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              height: 1.2125,
              color: const Color(0xff717171),
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
              color: const Color(0xff717171),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget RolePhotos(FullLicence fullLicence,context,LicenceProvider licenceController) {
  if (fullLicence.licence!.role == "رياضي") {
    return AthletePhotosWidget(fullLicence,licenceController,context);
  } else if (fullLicence.licence!.role == "حكم") {
    return ArbitratorPhotosWidget(fullLicence,licenceController,context);
  } else if (fullLicence.licence!.role == "مدرب") {
    return CoachPhotosWidget(fullLicence,licenceController,context);
  } else {
    return const SizedBox();
  }
}

Widget ArbitratorPhotosWidget(FullLicence fullLicence,LicenceProvider licenceController,context) {
  return Directionality(
            textDirection: TextDirection.rtl,

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
  return Directionality(
            textDirection: TextDirection.rtl,

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
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Container(
      constraints: BoxConstraints(maxWidth: 100.w),
      width: 100.w,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
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
                  const Center(child: Text('صورة الهوية'))
                ],
              ),
            ),
            SizedBox(
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
                  const Center(child: Text('صورة التامين'))
                ],
              ),
            ),
            SizedBox(
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
                  const Center(child: Text('الصورة الطبية'))
                ],
              ),
            ),
          ]),
    ),
  );
}

Widget RoleCard(Role role, context,LicenceProvider licenceController) {
  //print('aaaa');
  if(licenceController.currentUser.club!.id==null){
    String img="assets/images/logo-ftwkf.png";
   if (role.roles == "رياضي") {
              img="assets/icons/running-white.png";
            }
            else if (role.roles == "مدرب") {
              img="assets/icons/coach-white.png";
            }else if (role.roles == "حكم") {
              img="assets/icons/referee-white.png";
            }else if (role.roles == "النادي") {
              img="assets/icons/club-white.png";
            }
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (() {
              licenceController.selectedRole=role;
              //print(role.roles);
              //print('aaaa');
              if (role.roles == "رياضي") {
                img="assets/icons/running.png";
                GoRouter.of(context).push(Routes.UploadAthleteImagesScreen);
              }
              else if (role.roles == "مدرب") {
                img="assets/icons/coach.png";
                GoRouter.of(context).push(Routes.UploadCoachImagesScreen);
              }
               else if (role.roles == "نادي") {
                img="assets/icons/club.png";
                GoRouter.of(context).push(Routes.AddProfileScreen);
              }
              else if (role.roles == "حكم") {
                img="assets/icons/referee.png";
                GoRouter.of(context).push(Routes.UploadArbitreImagesScreen);
              }
            }),
            child: Container(
                decoration: const BoxDecoration(
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
        Text(role.roles!,
           style: const TextStyle(
                  fontSize: 18
                ),)
      ],
    ),
  );}
   else{
    if(role.roles=="النادي"||role.roles=="manager"){
      return const SizedBox();
    }
    else{
       return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (() {
        licenceController.selectedRole=role;
        if (role.roles == "رياضي") {
          GoRouter.of(context).push(Routes.UploadAthleteImagesScreen);
        }
        else if (role.roles == "مدرب") {
          GoRouter.of(context).push(Routes.UploadCoachImagesScreen);
        }else if (role.roles == "حكم") {
          GoRouter.of(context).push(Routes.UploadArbitreImagesScreen);
        }
        else if (role.roles == "النادي") {
          GoRouter.of(context).push(Routes.AddProfileScreen);
        }
      }),
      child: Container(
          decoration: const BoxDecoration(
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
    String? toFillImage, String? placeHolderImage,int index) {
  return Consumer<LicenceProvider>(
    builder: (context,licenceController,child) {
      return Directionality(
                textDirection: TextDirection.rtl,

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onHover: (value) {
                  if(value){
                    licenceController.isHovered[index]=true;
                    licenceController.notify();
                  }
                  else{
                    licenceController.isHovered[index]=false;
                    licenceController.notify();
                  }
                },
                onTap: (() {
                  licenceController.pickAthleteImage(true,context,toFillImage);
                }),
                child: Container(
                    decoration: BoxDecoration(
                      image: (placeHolderImage != null)
                        ? DecorationImage(image: NetworkImage(placeHolderImage,
                        ),
                        opacity: (licenceController.isHovered[index])?0.3:1,
                        fit: BoxFit.cover
                        ):null,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26),
                        BoxShadow(
                          color: Color(0xffD9D9D9),
                          spreadRadius: -12,
                          blurRadius: 20,
                        )
                      ],
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                    width: 30.w,
                    height: 22.h,
                     child: (licenceController.isHovered[index])?
                     Center(
                      child: Icon(Icons.camera_alt,
                      size: 5.w,
                      ),
                     )
                     :const SizedBox(),
                        ),
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(txt,
            style: const TextStyle(
              fontSize: 20
            ),
            ),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      );
    }
  );
}

Widget CoachImageUploadWidget(txt, licenceController, context,
    String? toFillImage, String? placeHolderImage,int index) {
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
             onHover: (value) {
                  if(value){
                    licenceController.isHovered[index]=true;
                    licenceController.notify();
                  }
                  else{
                    licenceController.isHovered[index]=false;
                    licenceController.notify();
                  }
                },
                onTap: (() {
                  licenceController.pickCoachImage(true,context,toFillImage);
                }),
            child: Container(
                 decoration: BoxDecoration(
                      image: (placeHolderImage != null)
                        ? DecorationImage(image: NetworkImage(placeHolderImage,
                        ),
                        opacity: (licenceController.isHovered[index])?0.3:1,
                        fit: BoxFit.cover
                        ):null,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26),
                        BoxShadow(
                          color: Color(0xffD9D9D9),
                          spreadRadius: -12,
                          blurRadius: 20,
                        )
                      ],
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                    width: 30.w,
                    height: 22.h,
                     child: (licenceController.isHovered[index])?
                     Center(
                      child: Icon(Icons.camera_alt,
                      size: 5.w,
                      ),
                     )
                     :const SizedBox(),),
          ),
        ),
          SizedBox(
              height: 0.5.h,
            ),
            Text(txt,
            style: const TextStyle(
              fontSize: 20
            ),
            ),
        SizedBox(
          height: 1.h,
        ),
      ],
    ),
  );
}

Widget ArbitreImageUploadWidget(txt,LicenceProvider licenceController, context,
    String? toFillImage, String? placeHolderImage,int index) {
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Column(
      children: [
        InkWell(
          onTap: () async {
           await licenceController.pickArbitreImage(true, context, toFillImage);
          },
          onHover: (value) {
                  if(value){
                    licenceController.isHovered[index]=true;
                    licenceController.notify();
                  }
                  else{
                    licenceController.isHovered[index]=false;
                    licenceController.notify();
                  }
                },
          child: Container(
              decoration: BoxDecoration(
                      image: (placeHolderImage != null)
                        ? DecorationImage(image: NetworkImage(placeHolderImage,
                        ),
                        opacity: (licenceController.isHovered[index])?0.3:1,
                        fit: BoxFit.cover
                        ):null,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26),
                        BoxShadow(
                          color: Color(0xffD9D9D9),
                          spreadRadius: -12,
                          blurRadius: 20,
                        )
                      ],
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                    width: 30.w,
                    height: 22.h,
               child: (licenceController.isHovered[index])?
                     Center(
                      child: Icon(Icons.camera_alt,
                      size: 5.w,
                      ),
                     )
                     :const SizedBox(),),
        ),
       SizedBox(
              height: 0.5.h,
            ),
            Text(txt,
            style: const TextStyle(
              fontSize: 20
            ),
            ),
            SizedBox(
              height: 1.h,
            ),
      ],
    ),
  );
}

Widget AthleteImageEditWidget(
    txt, LicenceProvider licenceController, context, imageName, img,index) {
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
             onTap: () async {
           await licenceController.pickAthleteImage(true, context, imageName);
          },
          onHover: (value) {
                  if(value){
                    licenceController.isHovered[index]=true;
                    licenceController.notify();
                  }
                  else{
                    licenceController.isHovered[index]=false;
                    licenceController.notify();
                  }
                },
            child: Container(
                 decoration: BoxDecoration(
                      image: (img != null)
                        ? DecorationImage(image: NetworkImage(img,
                        ),
                        opacity: (licenceController.isHovered[index])?0.3:1,
                        fit: BoxFit.cover
                        ):null,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26),
                        BoxShadow(
                          color: Color(0xffD9D9D9),
                          spreadRadius: -12,
                          blurRadius: 20,
                        )
                      ],
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ),
                    width: 30.w,
                    height: 22.h,
                child: (licenceController.isHovered[index])?
                     Center(
                      child: Icon(Icons.camera_alt,
                      size: 5.w,
                      ),
                     )
                     :const SizedBox(),),
          ),
        ),
        SizedBox(
              height: 0.5.h,
            ),
            Text(txt,
            style: const TextStyle(
              fontSize: 20
            ),
            ),
            SizedBox(
              height: 1.h,
            ),
      ],
    ),
  );
}

SearchDialog(LicenceProvider licenceController, numControl, context) {
  return Directionality(
            textDirection: TextDirection.rtl,

    child: AlertDialog(
      title: const Text('البحث برقم الاجازة'),
      content: SizedBox(
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
              child: const Center(child: Text('تاكيد')),
            )
          ],
        )
      ],
    ),
  );
}

FilterDialog(LicenceProvider licenceController, context) {
  Category? filteredCategory = Category(categorieAge: "العمر", id: -1);

  Role? filteredRole = Role(roles: "نوع الرياضة", id: -1);
  Grade? filteredGrade = Grade(grade: "Grade", id: -1);
  Degree? filteredDegree = Degree(degree: "Degree", id: -1);
  Weight? filteredWeight = Weight(masseEnKillograme: 0, id: -1);
  Discipline? filteredDiscipline = Discipline(name: "الرياضة", id: -1);
  Club? filteredClub = Club(name: "النادي", id: -1);
  String filteredSex = "الجنس";
  String filteredStatus = "الحالة";

  return Directionality(
            textDirection: TextDirection.rtl,

    child: AlertDialog(
      contentPadding: const EdgeInsets.only(left: 4,right: 4,top: 24,bottom: 20),
      insetPadding: const EdgeInsets.symmetric(horizontal: 36,vertical: 24),
      scrollable: true,
      title: const Center(child: Text('تصفية')),
      content: SizedBox(
          width: 50.w,
          child: Center(
            child: Column(
              children: [
                SeasonSelectInput('الموسم',licenceController.selectedSeason,licenceController),
                     RoleSelectInput('نوع الاجازة',licenceController.filteredRole,licenceController),
                GategorySelectInput('العمر',licenceController.filteredCategory,licenceController),
                    GradeSelectInput('Grade',licenceController.filteredGrade,licenceController)	,
                    DegreeSelectInput('Degree',licenceController.filteredDegree,licenceController),
                    DisciplineSelectInput('الرياضة',licenceController.filteredDiscipline,licenceController)	,
                    WeightSelectInput('الوزن',licenceController.filteredWeight,licenceController),
                    if(licenceController.currentUser.club?.id==null)
                    ClubSelectInput('النادي',licenceController.filteredClub,licenceController),
                     SelectInput('الجنس',licenceController.filteredSex,licenceController,['ذكر','انثى']),
                     SelectInput('الحالة',licenceController.filteredStatus,licenceController,["نشطة","في الانتظار","منتهية"]),
              ],
            ),
          )),
          actionsPadding: const EdgeInsets.all(0),
      actions: [
        Container(
          color: const Color(0xff4C9AFF),
          width: 54.w,
          height: 4.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  licenceController.filterLicences(context,);
                  GoRouter.of(context).push(Routes.FilteredLicencesScreen);
                },
                child: const Center(child: Text('تاكيد',
                style: TextStyle(
                  color: Colors.white
                ),
                )),
              )
            ],
          ),
        )
      ],
    ),
  );
}


Widget LicenceListHeader(LicenceProvider licenceController,numControl,context,role){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Center(
      child: SizedBox(
        width: 183.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
          // SizedBox(height: 5.h,),
          
          SearchFilter(licenceController,numControl,context,role),
          // SizedBox(height: 3.h,),
          // ElevatedButton(onPressed: (){
          //   licenceController.exportToExcel();
          // }, child: Text("Export"))
          
          //  FirstRow(licenceController),
          //  SizedBox(height: 3.h,),
         ],
        ),
      ),
    ),
  );
}

Widget FirstRow(LicenceProvider licenceController){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text("المجموع: ${licenceController.fullLicences.length}",
       style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20
      ),),
      // Text("Details de filtre >>",
      // style: TextStyle(
      //   color: Color(0xff2DA9E0),
      //   fontSize: 20,
      //   // fontWeight: FontWeight.w600
      // ),
      // )
    ],),
  );
}

Widget SearchFilter(LicenceProvider licenceController,numControl,context,role){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Row(
      children: [
        SearchField(licenceController,numControl,context,role),
        SizedBox(width: 2.w,),
        
        FilterField(licenceController,context),
        SizedBox(width: 2.w,),
        SearchButton(licenceController,numControl,context,role),
        SizedBox(width: 2.w,),
       
      //   Text("Total: "+licenceController.fullLicences.length.toString(),
      //  style: TextStyle(
      //   fontWeight: FontWeight.w600,
      //   fontSize: 20
      // ),),
      ],
    ),
  );
}

Widget SearchField(LicenceProvider licenceController,numControl,context,role){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: Container(
      width: 100.w,
      height: 3.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          (licenceController.isShadow)?const BoxShadow(
            
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0,2)
          ):const BoxShadow()
        ],
        color: const Color(0xffedeef0)
      ),
      child: SearchInput(licenceController,numControl,context,role)
    ),
  );
}
Widget FilterField(LicenceProvider licenceController,context){
  return Directionality(
            textDirection: TextDirection.rtl,

    child: InkWell(
      onTap: (){
        licenceController.showFilterDialog(context);
      },
      child: Container(
        width: 7.w,
          height: 3.h,
          color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [
              
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

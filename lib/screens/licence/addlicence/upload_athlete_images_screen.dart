import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../router/routes.dart';

class UploadAthleteLicenceImages extends StatefulWidget {
  const UploadAthleteLicenceImages({super.key});

  @override
  State<UploadAthleteLicenceImages> createState() =>
      _UploadAthleteLicenceImagesState();
}

class _UploadAthleteLicenceImagesState
    extends State<UploadAthleteLicenceImages> {
  late LicenceProvider licenceController;
  CarouselController carouselController = CarouselController();
  bool isFirst = true;
  bool isLast = false;
  late List<Map<String, dynamic>> list;
  List<Widget> myItems = [];
  @override
  void initState() {
    licenceController = Provider.of<LicenceProvider>(context, listen: false);
    list = [
      {
        'txt': 'صورة الحساب',
        'tofill': 'profilePhoto',
        'holder': licenceController.createdFullLicence!.profile!.profilePhoto
      },
      {
        'txt': 'صورة الهوية',
        'tofill': 'idphoto',
        'holder': licenceController.createdFullLicence!.athlete!.identityPhoto
      },
      {
        'txt': 'صورة التامين',
        'tofill': 'photo',
        'holder': licenceController.createdFullLicence!.athlete!.photo
      },
      {
        'txt': 'الصورة الطبية',
        'tofill': 'medphoto',
        'holder': licenceController.createdFullLicence!.athlete!.medicalPhoto
      }
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // licenceController.myItems = [
    //   AthleteImageUploadWidget(
    //       'صورة الحساب',
    //       licenceController,
    //       context,
    //       'profilePhoto',
    //       licenceController.createdFullLicence!.profile!.profilePhoto),
    //   AthleteImageUploadWidget(
    //       'صورة الهوية',
    //       licenceController,
    //       context,
    //       'idphoto',
    //       licenceController.createdFullLicence!.athlete!.identityPhoto),
    //   AthleteImageUploadWidget('صورة التامين', licenceController, context,
    //       'photo', licenceController.createdFullLicence!.athlete!.photo),
    //   AthleteImageUploadWidget(
    //       'الصورة الطبية',
    //       licenceController,
    //       context,
    //       'medphoto',
    //       licenceController.createdFullLicence!.athlete!.medicalPhoto),
    // ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
        builder: (context, licenceController, child) {
      return Directionality(
                textDirection: TextDirection.rtl,

        child: Scaffold(
          // appBar: AppBar(),
          body: CustomScrollView(
            slivers: [
              MyAppBar("صور الرياضي", context, false, licenceController,
                  false, true),
                  SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
              SliverGrid(
      
                  delegate: SliverChildListDelegate([
                    AthleteImageUploadWidget(
                        'صورة الحساب',
                        licenceController,
                        context,
                        'profilePhoto',
                        licenceController
                            .createdFullLicence!.profile!.profilePhoto,
                            0
                            ),
                    AthleteImageUploadWidget(
                        'صورة الهوية',
                        licenceController,
                        context,
                        'idphoto',
                        licenceController
                            .createdFullLicence!.athlete!.identityPhoto,1),
                    AthleteImageUploadWidget(
                        'صورة التامين',
                        licenceController,
                        context,
                        'photo',
                        licenceController.createdFullLicence!.athlete!.photo,2),
                    AthleteImageUploadWidget(
                        'الصورة الطبية',
                        licenceController,
                        context,
                        'medphoto',
                        licenceController
                            .createdFullLicence!.athlete!.medicalPhoto,3),
                  ]),
                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.5 ,
                      // mainAxisExtent: ,
                      crossAxisSpacing: 0,
                      crossAxisCount: 4)),
             
            ],
          ),
          bottomNavigationBar: BottomAppBar(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 30.w,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        // licenceController.createProfile();
                        if ((licenceController.createdFullLicence!.profile!.profilePhoto == null) ||
                            (licenceController
                                    .createdFullLicence!.athlete!.identityPhoto ==
                                null) ||
                            (licenceController
                                    .createdFullLicence!.athlete!.photo ==
                                null) ||
                            (licenceController
                                    .createdFullLicence!.athlete!.medicalPhoto ==
                                null)) {
                          final snackBar = MySnackBar(
                              title: 'صور ناقصة',
                              msg: 'الرجاء تقديم جميع الصور الناقصة',
                              state: ContentType.warning);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          GoRouter.of(context).push(Routes.AddProfileScreen);
                        }
      
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProfileScreen()));
                      },
                      label: const Text("تاكيد"),
                    )),
              ],
            ),
          )),
        ),
      );
    });

  }
}

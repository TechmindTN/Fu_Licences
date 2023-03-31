import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../router/routes.dart';

class UploadAthleteLicenceImages extends StatefulWidget {
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
        'txt': 'photo de profile',
        'tofill': 'profilePhoto',
        'holder': licenceController.createdFullLicence!.profile!.profilePhoto
      },
      {
        'txt': 'photo d\'identite',
        'tofill': 'idphoto',
        'holder': licenceController.createdFullLicence!.athlete!.identityPhoto
      },
      {
        'txt': 'photo d\'assurance',
        'tofill': 'photo',
        'holder': licenceController.createdFullLicence!.athlete!.photo
      },
      {
        'txt': 'photo medical',
        'tofill': 'medphoto',
        'holder': licenceController.createdFullLicence!.athlete!.medicalPhoto
      }
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // licenceController.myItems = [
    //   AthleteImageUploadWidget(
    //       'photo de profile',
    //       licenceController,
    //       context,
    //       'profilePhoto',
    //       licenceController.createdFullLicence!.profile!.profilePhoto),
    //   AthleteImageUploadWidget(
    //       'photo d\'identite',
    //       licenceController,
    //       context,
    //       'idphoto',
    //       licenceController.createdFullLicence!.athlete!.identityPhoto),
    //   AthleteImageUploadWidget('photo d\'assurance', licenceController, context,
    //       'photo', licenceController.createdFullLicence!.athlete!.photo),
    //   AthleteImageUploadWidget(
    //       'photo medical',
    //       licenceController,
    //       context,
    //       'medphoto',
    //       licenceController.createdFullLicence!.athlete!.medicalPhoto),
    // ];
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
        builder: (context, licenceController, child) {
      return Scaffold(
        // appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            MyAppBar("Photos Athletes", context, false, licenceController,
                false, true),
                SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
            SliverGrid(

                delegate: SliverChildListDelegate([
                  AthleteImageUploadWidget(
                      'photo de profile',
                      licenceController,
                      context,
                      'profilePhoto',
                      licenceController
                          .createdFullLicence!.profile!.profilePhoto,
                          0
                          ),
                  AthleteImageUploadWidget(
                      'photo d\'identite',
                      licenceController,
                      context,
                      'idphoto',
                      licenceController
                          .createdFullLicence!.athlete!.identityPhoto,1),
                  AthleteImageUploadWidget(
                      'photo d\'assurance',
                      licenceController,
                      context,
                      'photo',
                      licenceController.createdFullLicence!.athlete!.photo,2),
                  AthleteImageUploadWidget(
                      'photo medical',
                      licenceController,
                      context,
                      'medphoto',
                      licenceController
                          .createdFullLicence!.athlete!.medicalPhoto,3),
                ]),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              Container(
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
                            title: "Photos Manquantes",
                            msg: "Merci de remplir tous les photos svp",
                            state: ContentType.warning);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        GoRouter.of(context).push(Routes.AddProfileScreen);
                      }

                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProfileScreen()));
                    },
                    label: Text("Confirmer"),
                  )),
            ],
          ),
        )),
      );
    });
    // TODO: implement build
    throw UnimplementedError();
  }
}

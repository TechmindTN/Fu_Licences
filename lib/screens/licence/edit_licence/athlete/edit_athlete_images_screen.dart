import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditAthleteLicenceImages extends StatefulWidget {
  @override
  State<EditAthleteLicenceImages> createState() => _EditAthleteLicenceImagesState();
}

class _EditAthleteLicenceImagesState extends State<EditAthleteLicenceImages> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController = Provider.of<LicenceProvider>(context, listen: false);
    // licenceController.initFields();
    licenceController.createdFullLicence =
        licenceController.selectedFullLicence;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
        builder: (context, licenceController, child) {
      return Directionality(
                textDirection: TextDirection.rtl,

        child: Scaffold(
          // appBar: AppBar(title: Text('تعديل الاجازة '+licenceController.selectedFullLicence!.licence!.numLicences!),),
          body: CustomScrollView(
            slivers:[
              MyAppBar('تعديل الاجازة '+licenceController.selectedFullLicence!.licence!.numLicences!, context, false, licenceController, false, true),
              
              
              SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
              SliverGrid(
      
                  delegate: SliverChildListDelegate([
                    AthleteImageEditWidget(
                      'صورة الحساب',
                      licenceController,
                      context,
                      'profilePhoto',
                      licenceController
                          .createdFullLicence!.profile!.profilePhoto,0),
                  AthleteImageEditWidget(
                    'صورة الهوية',
                    licenceController,
                    context,
                    'idphoto',
                    licenceController.createdFullLicence!.athlete!.identityPhoto,1
                  ),
                  AthleteImageEditWidget(
                      'صورة التامين',
                      licenceController,
                      context,
                      'photo',
                      licenceController.createdFullLicence!.athlete!.photo,2),
                  AthleteImageEditWidget(
                      'الصورة الطبية',
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
      
      
      
      
              
            //   SliverToBoxAdapter(
            //     child: Center(
            //   child: Column(
            //     children: [
            //       AthleteImageEditWidget(
            //           'photo',
            //           licenceController,
            //           context,
            //           'profilePhoto',
            //           licenceController
            //               .createdFullLicence!.profile!.profilePhoto),
            //       AthleteImageEditWidget(
            //         'Identite',
            //         licenceController,
            //         context,
            //         'idphoto',
            //         licenceController.createdFullLicence!.athlete!.identityPhoto,
            //       ),
            //       AthleteImageEditWidget(
            //           'Assurance',
            //           licenceController,
            //           context,
            //           'photo',
            //           licenceController.createdFullLicence!.athlete!.photo),
            //       AthleteImageEditWidget(
            //           'Medicale',
            //           licenceController,
            //           context,
            //           'medphoto',
            //           licenceController
            //               .createdFullLicence!.athlete!.medicalPhoto),
            //       SizedBox(
            //         height: 5.h,
            //       )
            //     ],
            //   ),
            // ),
            //   )
            ] 
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
                        licenceController.editAthleteProfile(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProfileScreen()));
                      },
                      label: Text('تاكيد'),
                    )),
              ],
            ),
          )),
        ),
      );
    });
    // TODO: implement build
    throw UnimplementedError();
  }
}

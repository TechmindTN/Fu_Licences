import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../router/routes.dart';

class UploadCoachLicenceImages extends StatefulWidget{
  @override
  State<UploadCoachLicenceImages> createState() => _UploadCoachLicenceImagesState();
}

class _UploadCoachLicenceImagesState extends State<UploadCoachLicenceImages> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Scaffold(
          appBar: AppBar(title: Text('Coach Images'),),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  CoachImageUploadWidget('photo',licenceController,context,'profilePhoto',licenceController.createdFullLicence!.profile!.profilePhoto),
                  CoachImageUploadWidget('photo',licenceController,context,'idphoto',licenceController.createdFullLicence!.coach!.identityPhoto),
                  CoachImageUploadWidget('photo',licenceController,context,'photo',licenceController.createdFullLicence!.coach!.photo),
                  CoachImageUploadWidget('photo',licenceController,context,'degreephoto',licenceController.createdFullLicence!.coach!.degreePhoto),
                  CoachImageUploadWidget('photo',licenceController,context,'gradephoto',licenceController.createdFullLicence!.coach!.gradePhoto),

                  SizedBox(height: 5.h,)
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  child: FloatingActionButton.extended(onPressed: (){
                    // licenceController.createProfile();
                    if((licenceController.createdFullLicence!.profile!.profilePhoto==null)||(licenceController.createdFullLicence!.coach!.identityPhoto==null)||(licenceController.createdFullLicence!.coach!.photo==null)||(licenceController.createdFullLicence!.coach!.degreePhoto==null)||(licenceController.createdFullLicence!.coach!.gradePhoto==null)){
                      final snackBar=MySnackBar(title: "Photos Manquantes",msg: "Merci de remplir tous les photos svp",state: ContentType.warning);
                      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                    }
                    else{
                      GoRouter.of(context).push(Routes.AddProfileScreen);
                    }
                    
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProfileScreen()));
                  },label: Text("Confirmer"),)),
              ],
            ),
          )),

        );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
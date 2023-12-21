import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../router/routes.dart';

class UploadDefaultCoachLicenceImages extends StatefulWidget{
  const UploadDefaultCoachLicenceImages({super.key});

  @override
  State<UploadDefaultCoachLicenceImages> createState() => _UploadDefaultCoachLicenceImagesState();
}

class _UploadDefaultCoachLicenceImagesState extends State<UploadDefaultCoachLicenceImages> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Directionality(
                  textDirection: TextDirection.rtl,

          child: Scaffold(
            // appBar: AppBar(title: Text('Coach Images'),),
            body: CustomScrollView(
              slivers:[ 
                MyAppBar("صور المدرب", context, false, licenceController, false, true),
                  SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
              SliverGrid(
        
                  delegate: SliverChildListDelegate([
                     CoachImageUploadWidget('صورة الحساب',licenceController,context,'profilePhoto',licenceController.createdFullLicence!.profile!.profilePhoto,0),
                    CoachImageUploadWidget('صورة الهوية',licenceController,context,'idphoto',licenceController.createdFullLicence!.coach!.identityPhoto,1),
                    CoachImageUploadWidget('photo',licenceController,context,'photo',licenceController.createdFullLicence!.coach!.photo,2),
                    CoachImageUploadWidget('photo de degree',licenceController,context,'degreephoto',licenceController.createdFullLicence!.coach!.degreePhoto,3),
                    CoachImageUploadWidget('photo de grade',licenceController,context,'gradephoto',licenceController.createdFullLicence!.coach!.gradePhoto,4),
        
                  ]),
                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.5 ,
                      // mainAxisExtent: ,
                      crossAxisSpacing: 0,
                      crossAxisCount: 5)),
              //   Center(
              //   child: Column(
              //     children: [
              //       CoachImageUploadWidget('صورة الحساب',licenceController,context,'profilePhoto',licenceController.createdFullLicence!.profile!.profilePhoto,0),
              //       CoachImageUploadWidget('photo d\'identite',licenceController,context,'idphoto',licenceController.createdFullLicence!.coach!.identityPhoto,1),
              //       CoachImageUploadWidget('photo',licenceController,context,'photo',licenceController.createdFullLicence!.coach!.photo,2),
              //       CoachImageUploadWidget('photo de degree',licenceController,context,'degreephoto',licenceController.createdFullLicence!.coach!.degreePhoto,3),
              //       CoachImageUploadWidget('photo de grade',licenceController,context,'gradephoto',licenceController.createdFullLicence!.coach!.gradePhoto,4),
        
              //       SizedBox(height: 5.h,)
              //     ],
              //   ),
              // ),
              ]
            ),
            bottomNavigationBar: BottomAppBar(child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.w,
                    child: FloatingActionButton.extended(onPressed: (){
                      // licenceController.createProfile();
                      if((licenceController.createdFullLicence!.profile!.profilePhoto==null)||(licenceController.createdFullLicence!.coach!.identityPhoto==null)||(licenceController.createdFullLicence!.coach!.photo==null)||(licenceController.createdFullLicence!.coach!.degreePhoto==null)||(licenceController.createdFullLicence!.coach!.gradePhoto==null)){
                        final snackBar=MySnackBar(title: 'صور ناقصة',msg: 'الرجاء تقديم جميع الصور الناقصة',state: ContentType.warning);
                        ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                      }
                      else{
                        GoRouter.of(context).push(Routes.AddDefaultCoachProfile);
                      }
                      
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProfileScreen()));
                    },label: const Text('تاكيد'),)),
                ],
              ),
            )),
        
          ),
        );
      }
    );

  }
}
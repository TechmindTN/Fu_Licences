import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditLicenceImages extends StatefulWidget {
  @override
  State<EditLicenceImages> createState() => _EditLicenceImagesState();
}

class _EditLicenceImagesState extends State<EditLicenceImages> {
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
      return Scaffold(
        appBar: AppBar(title: Text("Modifier licence "+licenceController.selectedFullLicence!.licence!.numLicences!),),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                AthleteImageEditWidget(
                    'photo',
                    licenceController,
                    context,
                    'profilePhoto',
                    licenceController
                        .createdFullLicence!.profile!.profilePhoto),
                AthleteImageEditWidget(
                  'Identite',
                  licenceController,
                  context,
                  'idphoto',
                  licenceController.createdFullLicence!.athlete!.identityPhoto,
                ),
                AthleteImageEditWidget(
                    'Assurance',
                    licenceController,
                    context,
                    'photo',
                    licenceController.createdFullLicence!.athlete!.photo),
                AthleteImageEditWidget(
                    'Medicale',
                    licenceController,
                    context,
                    'medphoto',
                    licenceController
                        .createdFullLicence!.athlete!.medicalPhoto),
                SizedBox(
                  height: 5.h,
                )
              ],
            ),
          ),
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

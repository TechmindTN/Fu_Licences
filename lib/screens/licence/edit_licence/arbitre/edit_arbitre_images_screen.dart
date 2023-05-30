import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../widgets/licence/arbitre/arbitr_licence_widgets.dart';

class EditArbitratorLicenceImages extends StatefulWidget {
  @override
  State<EditArbitratorLicenceImages> createState() => _EditArbitratorLicenceImagesState();
}

class _EditArbitratorLicenceImagesState extends State<EditArbitratorLicenceImages> {
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
        // appBar: AppBar(title: Text("Modifier licence "+licenceController.selectedFullLicence!.licence!.numLicences!),),
        body: CustomScrollView(
          slivers:[
            MyAppBar("Modifier licence "+licenceController.selectedFullLicence!.licence!.numLicences!, context, false, licenceController, false, true),
            
            
            SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
            SliverGrid(

                delegate: SliverChildListDelegate([
                  ArbitreImageEditWidget(
                    'Profile',
                    licenceController,
                    context,
                    'profilePhoto',
                    licenceController
                        .createdFullLicence!.profile!.profilePhoto,0),
                ArbitreImageEditWidget(
                  'Identite',
                  licenceController,
                  context,
                  'idphoto',
                  licenceController.createdFullLicence!.arbitrator!.identityPhoto,1
                ),
                ArbitreImageEditWidget(
                    'Photo',
                    licenceController,
                    context,
                    'photo',
                    licenceController.createdFullLicence!.arbitrator!.photo,2),
                
                ]),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.5 ,
                    // mainAxisExtent: ,
                    crossAxisSpacing: 0,
                    crossAxisCount: 3)),




            
          //   SliverToBoxAdapter(
          //     child: Center(
          //   child: Column(
          //     children: [
          //       ArbitreImageEditWidget(
          //           'photo',
          //           licenceController,
          //           context,
          //           'profilePhoto',
          //           licenceController
          //               .createdFullLicence!.profile!.profilePhoto),
          //       ArbitreImageEditWidget(
          //         'Identite',
          //         licenceController,
          //         context,
          //         'idphoto',
          //         licenceController.createdFullLicence!.arbitrator!.identityPhoto,
          //       ),
          //       ArbitreImageEditWidget(
          //           'Assurance',
          //           licenceController,
          //           context,
          //           'photo',
          //           licenceController.createdFullLicence!.arbitrator!.photo),
          //       ArbitreImageEditWidget(
          //           'Medicale',
          //           licenceController,
          //           context,
          //           'medphoto',
          //           licenceController
          //               .createdFullLicence!.arbitrator!.medicalPhoto),
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
                      licenceController.editArbitratorImages(context);
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

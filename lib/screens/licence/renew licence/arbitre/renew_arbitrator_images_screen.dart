import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
// import 'package:fu_licences/screens/licence/renew%20licence/arbitrator/renew_licence_screen.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../router/routes.dart';
import '../../../../widgets/licence/arbitre/arbitre_licence_widgets.dart';

class RenewArbitratorLicenceImages extends StatefulWidget {
  @override
  State<RenewArbitratorLicenceImages> createState() => _RenewArbitratorLicenceImagesState();
}

class _RenewArbitratorLicenceImagesState extends State<RenewArbitratorLicenceImages> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController = Provider.of<LicenceProvider>(context, listen: false);
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
        // appBar: AppBar(title: Text("Renouvellement Licence"+licenceController.selectedFullLicence!.licence!.numLicences!),),
        body: CustomScrollView(
          slivers:[
            MyAppBar("Renouvellement Licence"+licenceController.selectedFullLicence!.licence!.numLicences!, context, false, licenceController, false, true),
             
             
            SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
            SliverGrid(

                delegate: SliverChildListDelegate([
                  ArbitreImageEditWidget(
                    'Identite',
                    licenceController,
                    context,
                    'idphoto',
                    licenceController.createdFullLicence!.arbitrator!.identityPhoto,1
                  ),
                  ArbitreImageEditWidget(
                      'Assurance',
                      licenceController,
                      context,
                      'photo',
                      licenceController.createdFullLicence!.arbitrator!.photo,2),
                  // ArbitratorImageEditWidget(
                  //     'Medicale',
                  //     licenceController,
                  //     context,
                  //     'medphoto',
                  //     licenceController
                  //         .createdFullLicence!.arbitrator!.medicalPhoto,3),
                ]),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.5 ,
                    // mainAxisExtent: ,
                    crossAxisSpacing: 0,
                    crossAxisCount: 2)),


            //  SliverToBoxAdapter(
            //    child: Center(
            //              child: Column(
            //     children: [
                  
            //       ArbitratorImageEditWidget(
            //         'Identite',
            //         licenceController,
            //         context,
            //         'idphoto',
            //         licenceController.createdFullLicence!.arbitrator!.identityPhoto,1
            //       ),
            //       ArbitratorImageEditWidget(
            //           'Assurance',
            //           licenceController,
            //           context,
            //           'photo',
            //           licenceController.createdFullLicence!.arbitrator!.photo,2),
            //       ArbitratorImageEditWidget(
            //           'Medicale',
            //           licenceController,
            //           context,
            //           'medphoto',
            //           licenceController
            //               .createdFullLicence!.arbitrator!.medicalPhoto,3),
            //       SizedBox(
            //         height: 5.h,
            //       )
            //     ],
            //              ),
            //            ),
            //  ),
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
                      licenceController.editArbitratorProfile(context);
                      GoRouter.of(context).push(Routes.RenewArbitratorLicenceScreen);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>RenewLicenceScreen()));
                    },
                    label: Text("Confirmer"),
                  )),
            ],
          ),
        )),
      );
    });
    // TODO: implement build ghghg 
    throw UnimplementedError();
  }
}

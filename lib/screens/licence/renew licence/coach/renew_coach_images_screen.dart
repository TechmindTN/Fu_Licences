import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../router/routes.dart';
import '../../../../widgets/licence/coach/coach_licence_widgets.dart';

class RenewCoachLicenceImages extends StatefulWidget {
  @override
  State<RenewCoachLicenceImages> createState() => _RenewCoachLicenceImagesState();
}

class _RenewCoachLicenceImagesState extends State<RenewCoachLicenceImages> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController = Provider.of<LicenceProvider>(context, listen: false);
    licenceController.createdFullLicence =
        licenceController.selectedFullLicence;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
        builder: (context, licenceController, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers:[
            MyAppBar("Renouvellement Licence "+licenceController.selectedFullLicence!.licence!.numLicences!, context, false, licenceController, false, true), 
            SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
            SliverGrid(
                delegate: SliverChildListDelegate([
                  CoachImageEditWidget(
                    'Identite',
                    licenceController,
                    context,
                    'idphoto',
                    licenceController.createdFullLicence!.coach!.identityPhoto,1
                  ),
                  CoachImageEditWidget(
                      'Assurance',
                      licenceController,
                      context,
                      'photo',
                      licenceController.createdFullLicence!.coach!.photo,2),
                      CoachImageEditWidget(
                      'Photo de degree',
                      licenceController,
                      context,
                      'degreePhoto',
                      licenceController.createdFullLicence!.coach!.degreePhoto,3),
                      CoachImageEditWidget(
                      'Photo de grade',
                      licenceController,
                      context,
                      'gradePhoto',
                      licenceController.createdFullLicence!.coach!.gradePhoto,4),
                ]),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.5 ,
                    crossAxisSpacing: 0,
                    crossAxisCount: 4)),
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
                      licenceController.editCoachProfile(context);
                      GoRouter.of(context).push(Routes.RenewCoachLicenceScreen);
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

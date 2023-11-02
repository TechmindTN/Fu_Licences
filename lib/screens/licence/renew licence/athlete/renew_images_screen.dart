import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../router/routes.dart';

class RenewLicenceImages extends StatefulWidget {
  const RenewLicenceImages({super.key});

  @override
  State<RenewLicenceImages> createState() => _RenewLicenceImagesState();
}

class _RenewLicenceImagesState extends State<RenewLicenceImages> {
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
      return Directionality(
                textDirection: TextDirection.rtl,

        child: Scaffold(
          // appBar: AppBar(title: Text('تجديد الاجازة '+licenceController.selectedFullLicence!.licence!.numLicences!),),
          body: CustomScrollView(
            slivers:[
              MyAppBar('تجديد الاجازة ${licenceController.selectedFullLicence!.licence!.numLicences!}', context, false, licenceController, false, true),
               
               
              SliverToBoxAdapter(child: SizedBox(height: 6.h,)),
              SliverGrid(
      
                  delegate: SliverChildListDelegate([
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
                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.5 ,
                      // mainAxisExtent: ,
                      crossAxisSpacing: 0,
                      crossAxisCount: 3)),
      
      
              //  SliverToBoxAdapter(
              //    child: Center(
              //              child: Column(
              //     children: [
                    
              //       AthleteImageEditWidget(
              //         'Identite',
              //         licenceController,
              //         context,
              //         'idphoto',
              //         licenceController.createdFullLicence!.athlete!.identityPhoto,1
              //       ),
              //       AthleteImageEditWidget(
              //           'Assurance',
              //           licenceController,
              //           context,
              //           'photo',
              //           licenceController.createdFullLicence!.athlete!.photo,2),
              //       AthleteImageEditWidget(
              //           'Medicale',
              //           licenceController,
              //           context,
              //           'medphoto',
              //           licenceController
              //               .createdFullLicence!.athlete!.medicalPhoto,3),
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
                SizedBox(
                    width: 30.w,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        // licenceController.createProfile();
                        licenceController.editAthleteProfile(context);
                        GoRouter.of(context).push(Routes.RenewAthleteLicenceScreen);
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>RenewLicenceScreen()));
                      },
                      label: const Text('تاكيد'),
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

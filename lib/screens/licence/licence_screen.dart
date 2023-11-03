import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:provider/provider.dart';

import '../../global/utils.dart';

class LicenceScreen extends StatefulWidget{
  const LicenceScreen({super.key});

  @override
  State<LicenceScreen> createState() => _LicenceScreenState();
}

class _LicenceScreenState extends State<LicenceScreen> {
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
            // floatingActionButton: FloatingActionButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectRoleScreen()));
            // }),
            // appBar: AppBar(title: Text("Licence "+licenceController.selectedFullLicence!.licence!.numLicences.toString()),
            // actions: [
            //   PopupMenuButton(itemBuilder: (context){
            //           //  if(licenceController.currentUser.club!.id!=null)
            //            return [
            //                   PopupMenuItem<int>(
            //                       value: 0,
            //                       child: Text("Modifier"),
            //                   ),
        
            //                   PopupMenuItem<int>(
            //                       value: 1,
            //                       child: Text("Modifier les images"),
            //                   ),
        
            //                   PopupMenuItem<int>(
            //                       value: 2,
            //                       child: Text("Renouvellement"),
            //                   ),
                              
            //               ];
            //               // else{
            //               //   return [
            //               //     PopupMenuItem<int>(
            //               //         value: 0,
            //               //         child: Text("Modifier"),
            //               //     ),
        
            //               //     PopupMenuItem<int>(
            //               //         value: 1,
            //               //         child: Text("Modifier les images"),
            //               //     ),
        
            //               //     PopupMenuItem<int>(
            //               //         value: 2,
            //               //         child: Text("Renouvellement"),
            //               //     ),
            //               //     PopupMenuItem<int>(
            //               //         value: 3,
            //               //         child: Text("Activer"),
            //               //     ),
            //               //     PopupMenuItem<int>(
            //               //         value: 4,
            //               //         child: Text("Refuser"),
            //               //     ),
                              
            //               // ];
            //               // }
            //          },
            //          onSelected:(value){
            //           if(licenceController.selectedFullLicence!.licence!.role=="رياضي")
            //             if(value == 0){
            //               GoRouter.of(context).push(Routes.EditAthleteLicenceScreen);
            //               // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceScreen())));
            //               //  //print("My account menu is selected.");
            //             }else if(value == 1){
            //               GoRouter.of(context).push(Routes.EditAthleteImagesScreen);
            //               // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
            //               //  //print("Settings menu is selected.");
            //             }else if(value == 2){
            //               GoRouter.of(context).push(Routes.RenewAthleteImages);
            //               // Navigator.push(context, MaterialPageRoute(builder: ((context) => RenewLicenceImages())));
            //                //print("Logout menu is selected.");
            //             }
            //          }
            //          )
            // ],
            // ),
        
        
            body: CustomScrollView(
              slivers: [
                MyAppBar("الاجازة ${licenceController.selectedFullLicence!.licence!.numLicences!}", context, false,licenceController,true,true),
                SliverToBoxAdapter(
                  child: Column(
                          
                  children: [
                    Container(
                    // man2Fct (1:93)
                    margin: const EdgeInsets.fromLTRB(0, 20, 1, 19),
                    width: 121,
                    height: 121,
                    child: (licenceController.selectedFullLicence!.profile!.profilePhoto!=null && licenceController.selectedFullLicence!.profile!.profilePhoto!="")?
                    InkWell(
                      onTap: () {
                          licenceController.showImage(context,licenceController.selectedFullLicence!.profile!.profilePhoto);
                        },
                      child: Image.network(licenceController.selectedFullLicence!.profile!.profilePhoto!))
                    :Image.asset(
                      'assets/icons/man.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    // mohsenbenmohsenbAx (1:94)
                    margin: const EdgeInsets.fromLTRB(9, 0, 0, 22),
                    child: Text(
                      '${licenceController.selectedFullLicence!.profile!.lastName} ${licenceController.selectedFullLicence!.profile!.firstName}',
                      style: SafeGoogleFont (
                        'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        height: 1.2125,
                        color: const Color(0xff000000),
                      ),
                    ),
                  ),
                    LicenceRow('اللقب',licenceController.selectedFullLicence!.profile!.lastName),
                    LicenceRow('الاسم',licenceController.selectedFullLicence!.profile!.firstName),
                    LicenceRow('الجنس',licenceController.selectedFullLicence!.profile!.sexe),
                          
                    LicenceRow('رقم الهاتف',licenceController.selectedFullLicence!.profile!.phone),
                    LicenceRow('عنوان السكن',licenceController.selectedFullLicence!.profile!.address),
                    LicenceRow('نوع الاجازة',licenceController.selectedFullLicence!.licence!.role),
                    LicenceRow('العمر',licenceController.selectedFullLicence!.licence!.categorie),
                    LicenceRow('رقم الهوية',licenceController.selectedFullLicence!.profile!.cin),
                    LicenceRow('تاريخ الولادة',licenceController.selectedFullLicence!.profile!.birthday.toString()),
                    LicenceRow('النادي',licenceController.selectedFullLicence!.licence!.club),
                    // LicenceRow('الولاية',licenceController.selectedFullLicence!.licence!.),
                    LicenceRow('الرياضة',licenceController.selectedFullLicence!.licence!.discipline),
                    // LicenceRow('Nationalite',licenceController.selectedFullLicence!.profile!.),
                    LicenceRow('Degree',licenceController.selectedFullLicence!.licence!.degree),
                    LicenceRow('Grade',licenceController.selectedFullLicence!.licence!.grade),
                    LicenceRow('الموسم',licenceController.selectedFullLicence!.licence!.seasons),
                    
                    LicenceRow('الحالة',licenceController.selectedFullLicence!.licence!.state),
                    RolePhotos(licenceController.selectedFullLicence!,context,licenceController)
                  ],
                            ),
                ),
              ],
               
            ),
            bottomNavigationBar: (licenceController.selectedFullLicence!.licence!.state=="في الانتظار"&&licenceController.currentUser.club!.id==null)?BottomAppBar(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: (){
                    licenceController.validateLicence(context);
                  },
                  style: ButtonStyle(
        
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ), child: const Text("قبول"),
                  ),
                   ElevatedButton(onPressed: (){},
                   style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ), child: const Text("رفض"),
                   )
                ],
              ),
            )):const BottomAppBar(),
           
          ),
        );
      }
    );

  }
}
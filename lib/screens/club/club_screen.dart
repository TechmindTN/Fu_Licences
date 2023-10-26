import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/licence/edit_licence/athlete/edit_athlete_images_screen.dart';
import 'package:fu_licences/screens/licence/edit_licence/athlete/edit_licence_screen.dart';
import 'package:fu_licences/screens/licence/renew%20licence/athlete/renew_images_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/club_appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controllers/club_controller.dart';
import '../../global/utils.dart';

class ClubScreen extends StatefulWidget{
  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  late LicenceProvider licenceController;
  late ClubProvider clubController;

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    clubController=Provider.of<ClubProvider>(context,listen: false);
    ////print(clubController.selectedClub.name);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ClubProvider>(
      builder: (context,clubController,child) {
        clubController.notify();
        return Directionality(
                  textDirection: TextDirection.rtl,

                    child: Scaffold(
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
            //               //  ////print("My account menu is selected.");
            //             }else if(value == 1){
            //               GoRouter.of(context).push(Routes.EditAthleteImagesScreen);
            //               // Navigator.push(context, MaterialPageRoute(builder: ((context) => EditLicenceImages())));
            //               //  ////print("Settings menu is selected.");
            //             }else if(value == 2){
            //               GoRouter.of(context).push(Routes.RenewAthleteImages);
            //               // Navigator.push(context, MaterialPageRoute(builder: ((context) => RenewLicenceImages())));
            //                ////print("Logout menu is selected.");
            //             }
            //          }
            //          )
            // ],
            // ),
        
        
            body: CustomScrollView(
              slivers: [
                // MyAppBar("Club "+licenceController.selectedClub!.name!, context, false,licenceController,true,true),
                MyClubAppBar("تفاصيل النادي", context, false,licenceController,true,true),
                SliverToBoxAdapter(
                  child: Column(
                          
                  children: [
                    Container(
                    // man2Fct (1:93)
                    margin: EdgeInsets.fromLTRB(0, 20, 1, 19),
                    width: 121,
                    height: 121,
                    child: (licenceController.selectedClub!.logo!=null && licenceController.selectedClub!.logo!="")?
                    InkWell(
                      onTap: () {
                          licenceController.showImage(context,licenceController.selectedClub!.logo);
                        },
                      child: Image.network(licenceController.selectedClub!.logo!))
                    :Image.asset(
                      'assets/icons/man.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    // mohsenbenmohsenbAx (1:94)
                    margin: EdgeInsets.fromLTRB(9, 0, 0, 22),
                    // child: Text(
                    //   licenceController.selectedClub!.name!.toString(),
                    //   style: SafeGoogleFont (
                    //     'Inter',
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w400,
                    //     height: 1.2125,
                    //     color: Color(0xff000000),
                    //   ),
                    // ),
                  ),
                    LicenceRow('الاسم',clubController.selectedClub.name!),
                    // LicenceRow('الاسم',licenceController.selectedFullLicence!.profile!.firstName),
                    // LicenceRow('الجنس',licenceController.selectedFullLicence!.profile!.sexe),
                          
                    // LicenceRow('رقم الهاتف',licenceController.selectedFullLicence!.profile!.phone),
                    // LicenceRow('عنوان السكن',licenceController.selectedFullLicence!.profile!.address),
                    // LicenceRow('Role',licenceController.selectedFullLicence!.licence!.role),
                    // LicenceRow('Age',licenceController.selectedFullLicence!.licence!.categorie),
                    // LicenceRow('رقم الهوية',licenceController.selectedFullLicence!.profile!.cin),
                    // LicenceRow('Naissance',licenceController.selectedFullLicence!.profile!.birthday.toString()),
                    // LicenceRow('النادي',licenceController.selectedFullLicence!.licence!.club),
                    // LicenceRow('الولاية',licenceController.selectedClub!.ligue!),
                    // LicenceRow('الرياضة',licenceController.selectedFullLicence!.licence!.discipline),
                    // LicenceRow('Nationalite',licenceController.selectedFullLicence!.profile!.),
                    // LicenceRow('Degree',licenceController.selectedFullLicence!.licence!.degree),
                    // LicenceRow('Grade',licenceController.selectedFullLicence!.licence!.grade),
                    // LicenceRow('الموسم',licenceController.selectedFullLicence!.licence!.seasons),
                    
                    // LicenceRow('Etat',licenceController.selectedFullLicence!.licence!.state),
                    // RolePhotos(licenceController.selectedFullLicence!,context,licenceController)
                  ],
                            ),
                ),
              ],
               
            ),
          //         bottomNavigationBar: (licenceController.selectedFullLicence!.licence!.state=="في الانتظار"&&licenceController.currentUser.club!.id==null)?BottomAppBar(child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               ElevatedButton(onPressed: (){
          //                 licenceController.validateLicence(context);
          //               }, child: Text("Valider"),
          //               style: ButtonStyle(
        
          //   backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          // ),
          //               ),
          //                ElevatedButton(onPressed: (){}, child: Text("Refuser"),
          //                style: ButtonStyle(
          //   backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          // ),
          //                )
          //             ],
          //           ),
          //         )):BottomAppBar(),
           
          ),
        );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
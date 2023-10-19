import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/club_controller.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/club_appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../global/utils.dart';
import '../../../../widgets/global/inputs.dart';

// import '../../global/utils.dart';

class EditClubScreen extends StatefulWidget{
  @override
  State<EditClubScreen> createState() => _EditClubScreenState();
}

class _EditClubScreenState extends State<EditClubScreen> {
  late LicenceProvider licenceController;
    late ClubProvider clubController;
 late TextEditingController nameController;

//     late TextEditingController prenomController;
//    late TextEditingController phoneController;
//  late TextEditingController nomController;
//  late TextEditingController sexeController;
// late  TextEditingController addresseController;
//  late TextEditingController stateController;
//  late TextEditingController birthController;
//  late TextEditingController cinController;
  @override
  void initState() {
    
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    clubController=Provider.of<ClubProvider>(context,listen: false);
    // licenceController.initFields();
    // clubController.getLigue();
//     prenomController=TextEditingController(text: licenceController.selectedFullLicence!.profile!.lastName,);
//     phoneController=TextEditingController(text: licenceController.selectedFullLicence!.profile!.phone.toString(),);
print('getting name');
  nameController=TextEditingController(text: clubController.selectedClub.name!);
  print('got name');
//  sexeController=TextEditingController(text: licenceController.selectedFullLicence!.profile!.sexe,);
//  addresseController=TextEditingController(text: licenceController.selectedFullLicence!.profile!.address,);
//  stateController=TextEditingController(text: licenceController.selectedFullLicence!.profile!.state,);
//   birthController=TextEditingController(text: licenceController.selectedFullLicence!.profile!.birthday,);
//  cinController=TextEditingController(text: licenceController.selectedFullLicence!.profile!.cin,);
 

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Scaffold(
          // appBar: AppBar(title: Text('تعديل الاجازة '+licenceController.selectedFullLicence!.licence!.numLicences.toString()),
         
          // ),
          body: CustomScrollView(
            slivers:[ 
              MyClubAppBar("تعديل النادي"+licenceController.selectedClub!.name.toString(), context, false, licenceController, false, true),
              SliverToBoxAdapter(
                child: Column(

            children: [
              
//               Container(
//               // man2Fct (1:93)
//               margin: EdgeInsets.fromLTRB(0, 20, 1, 19),
//               width: 121,
//               height: 121,
//               child: (licenceController.selectedFullLicence!.profile!.profilePhoto!=null && licenceController.selectedFullLicence!.profile!.profilePhoto!="")?
//               InkWell(
//                 onTap: (){
//                   showDialog(context: context,builder: (context) {
//                   return Dialog(
//                     child: Image.network(licenceController.selectedFullLicence!.profile!.profilePhoto!)
//                   );
//                 },);
//                 },
//                 child: Image.network(licenceController.selectedFullLicence!.profile!.profilePhoto!))
//               :Image.asset(
//                 'assets/icons/man.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Container(
//               // mohsenbenmohsenbAx (1:94)
//               margin: EdgeInsets.fromLTRB(9, 0, 0, 22),
//               child: Text(
//                                 licenceController.selectedFullLicence!.profile!.lastName.toString()+' '+licenceController.selectedFullLicence!.profile!.firstName.toString(),

//                 style: SafeGoogleFont (
//                   'Inter',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400,
//                   height: 1.2125,
//                   color: Color(0xff000000),
//                 ),
//               ),
//             ),
            
//              TextInput('الاسم',prenomController),
//                   TextInput('اللقب',nomController),
//                   TextInput('رقم الهاتف',phoneController),
                  
//                   TextInput('رقم الهوية',cinController),
//                   SelectInput('الجنس',licenceController.selectedSex,licenceController,['ذكر','انثى']),
//                   SelectInput('الولاية',licenceController.selectedState,licenceController,['Ariana'	,
// 'Béja'	,
// 'Ben Arous' ,
// 'Bizerte'	,
// 'Gabès'	,
// 'Gafsa'	,
// 'Jendouba'	,
// 'Kairouan'	,
// 'Kasserine'	,
// 'Kébili'	,
// 'Kef'	,
// 'Mahdia'	,
// 'Manouba'	,
// 'Médenine'	,
// 'Monastir'	,
// 'Nabeul'	,
// 'Sfax'	,
// 'Sidi Bouzid'	,
// 'Siliana'	,
// 'Sousse'	,
// 'Tataouine'	,
// 'Tozeur'	,
// 'Tunis'	,
// 'Zaghouan']),



//                   TextInput('عنوان السكن',addresseController),
//                                 SizedBox(height: 3.h,),

// FloatingActionButton.extended(onPressed: (){
//   licenceController.editProfile(context,address: addresseController.text,phone: phoneController.text,firstName: nomController.text,lastName: prenomController.text,cin: cinController.text);
// }, label: Text('تاكيد')),
//               SizedBox(height: 5.h,),

// Divider(color: Colors.black38,
// thickness: 2,
// ),
//               SizedBox(height: 5.h,),

// Text('Information de club'),
TextInput('الاسم',nameController),
// Text(licenceController.selectedFullLicence!.licence!.numLicences.toString()),
//               SizedBox(height: 3.h,),
//                   Dateinput('تاريخ الولادة',birthController,context,licenceController.selectedBirth,licenceController),
                  // LigueSelectInput('الولاية',clubController.selectedClub,licenceController),
//                   GradeSelectInput('Grade',licenceController.selectedGrade,licenceController)	,
//                   DegreeSelectInput('Degree',licenceController.selectedDegree,licenceController),
//                   DisciplineSelectInput('الرياضة',licenceController.selectedDiscipline,licenceController)	,
                
//                   WeightSelectInput('الوزن',licenceController.selectedWeight,licenceController),
                 
//                   if(licenceController.currentUser.club!.id==null)
//                   ClubSelectInput('النادي',licenceController.selectedClub,licenceController),
                                SizedBox(height: 3.h,),

                  FloatingActionButton.extended(onPressed: (){

                    clubController.editClub(nameController.text,context);
                  }, label: Text('تاكيد')),
              SizedBox(height: 3.h,),

            ],
          ),
              )
              
          ]
          ),
          
         
        );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
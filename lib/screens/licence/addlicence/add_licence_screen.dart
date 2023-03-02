// import 'package:flutter/material.dart';
// import 'package:fu_licences/controllers/licence_controller.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import '../../../widgets/global/inputs.dart';

// class AddLicenceScreen extends StatefulWidget{
//   @override
//   State<AddLicenceScreen> createState() => _AddLicenceScreenState();
// }

// class _AddLicenceScreenState extends State<AddLicenceScreen> {
//   // String? categoryId;
//   // dynamic? gradeId;
//   // dynamic? idDegree;
//   // int? discipline;
//   // int? profile;
//   // dynamic? weights;
//   // String? club;
//   late LicenceProvider licenceController;

//   TextEditingController categoryController=TextEditingController();
//   TextEditingController gradeController=TextEditingController();
//   TextEditingController degreeController=TextEditingController();
//   TextEditingController disciplineController=TextEditingController();
//   TextEditingController weightController=TextEditingController();
//   TextEditingController clubController=TextEditingController();

//   @override
//   void initState() {
//     licenceController=Provider.of<LicenceProvider>(context,listen: false);
//     licenceController.initSelected();
//     // TODO: implement initState
//     super.initState();
//   }
  
  
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LicenceProvider>(
//       builder: (context,licenceController,child) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text("Ajouter les informations du profile"),
            
//           ),
//           body: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 children: [
 

//                   GategorySelectInput('Categorie',licenceController.selectedCategory,licenceController),
//                   GradeSelectInput('Grade',licenceController.selectedGrade,licenceController)	,
//                   DegreeSelectInput('Degree',licenceController.selectedDegree,licenceController),
//                   DisciplineSelectInput('Discipline',licenceController.selectedDiscipline,licenceController)	,
                
//                   WeightSelectInput('Poids',licenceController.selectedWeight,licenceController),
//                   ClubSelectInput('Club',licenceController.selectedClub,licenceController),
//                   // TextInput('Addresse',prenomController),
//                   // Dateinput('Date de naissance',birthController,context,licenceController.selectedBirth,licenceController)

//                 ],
//               ),
          
//             ),
//           ),
//           bottomNavigationBar: BottomAppBar(child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 30.w,
//                   child: FloatingActionButton.extended(onPressed: (){
//                     // licenceController.createAthleteProfile(address: addresseController.text,cin: cinController.text,firstName: prenomController.text,lastName: nomController.text,phone: phoneController.text,state: stateController.text );
//                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAthleteScreen()));
//                   },label: Text("Confirmer"),)),
//               ],
//             ),
//           )),
//         );
//       }
//     );
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }


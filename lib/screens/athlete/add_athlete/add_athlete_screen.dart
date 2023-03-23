import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/licence/licence_list_screen.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/global/inputs.dart';
import '../../licence/addlicence/add_licence_screen.dart';

class AddAthleteScreen extends StatefulWidget {
  @override
  State<AddAthleteScreen> createState() => _AddAthleteScreenState();
}

class _AddAthleteScreenState extends State<AddAthleteScreen> {
  // String? categoryId;
  // dynamic? gradeId;
  // dynamic? idDegree;
  // int? discipline;
  // int? profile;
  // dynamic? weights;
  // String? club;
  late LicenceProvider licenceController;

  TextEditingController categoryController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController disciplineController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController clubController = TextEditingController();

  @override
  void initState() {
    licenceController = Provider.of<LicenceProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
        builder: (context, licenceController, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter licence d'athlete"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // String? categoryId;
                // dynamic? gradeId;
                // dynamic? idDegree;

                // int? discipline;

                // dynamic? weights;
                // String? club;
                // TextInput('Prenom',categoryController),
                // TextInput('Nom',gradeController),
                // TextInput('Telephone',degreeController),

                // TextInput('CIN',disciplineController),
                GategorySelectInput('Categorie',
                    licenceController.selectedCategory, licenceController),
                GradeSelectInput('Grade', licenceController.selectedGrade,
                    licenceController),
                DegreeSelectInput('Degree', licenceController.selectedDegree,
                    licenceController),
                DisciplineSelectInput('Discipline',
                    licenceController.selectedDiscipline, licenceController),

                WeightSelectInput('Poids', licenceController.selectedWeight,
                    licenceController),
                
                if(licenceController.currentUser.club!.id==null)
                ClubSelectInput(
                    'Club', licenceController.selectedClub, licenceController),
                // TextInput('Addresse',prenomController),
                // Dateinput('Date de naissance',birthController,context,licenceController.selectedBirth,licenceController)
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
                      print(licenceController.selectedCategory!.id);
                      print(licenceController.selectedGrade!.id);
                      print(licenceController.selectedDegree!.id);
                      print(licenceController.selectedDiscipline!.id);
                      print(licenceController.selectedGrade!.id);
                      print(licenceController.selectedWeight!.id);
                      if ((licenceController.selectedCategory == null) ||
                          (licenceController.selectedCategory!.id == -1) ||
                          (licenceController.currentUser.club!.id == null)&&((licenceController.selectedClub == null) ||
                          (licenceController.selectedClub!.id == -1)) ||
                          (licenceController.selectedDegree == null) ||
                          (licenceController.selectedDegree!.id == -1) ||
                          (licenceController.selectedDiscipline == null) ||
                          (licenceController.selectedDiscipline!.id == -1) ||
                          (licenceController.selectedGrade == null) ||
                          (licenceController.selectedGrade!.id == -1) ||
                          (licenceController.selectedWeight == null) ||
                          (licenceController.selectedWeight!.id == -1)) {
                        final snackBar = MySnackBar(
                            title: "Champs Obligatoires",
                            msg: "Merci de remplir tous les champs svp",
                            state: ContentType.warning);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        licenceController.createAthlete(context);
                        // GoRouter.of(context).dispose();
                        GoRouter.of(context).go(Routes.Home);
                      }

// Navigator.of(context, rootNavigator:
// true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
// LicenceListScreen()), (route) => false);                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLicenceScreen()));
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

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../router/routes.dart';
import '../../../widgets/global/inputs.dart';
import '../../athlete/add_athlete/add_athlete_screen.dart';

class AddProfileScreen extends StatefulWidget {
  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  late LicenceProvider licenceController;
  TextEditingController prenomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  TextEditingController addresseController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  TextEditingController cinController = TextEditingController();

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
          title: Text("Ajouter les informations du profile"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextInput('Prenom', prenomController),
                TextInput('Nom', nomController),
                TextInput('Telephone', phoneController),

                TextInput('CIN', cinController),
                SelectInput('Sexe', licenceController.selectedSex,
                    licenceController, ['Male', 'Femelle']),
                SelectInput('Governorat', licenceController.selectedState,
                    licenceController, [
                  'Ariana',
                  'Béja',
                  'Ben Arous',
                  'Bizerte',
                  'Gabès',
                  'Gafsa',
                  'Jendouba',
                  'Kairouan',
                  'Kasserine',
                  'Kébili',
                  'Kef',
                  'Mahdia',
                  'Manouba',
                  'Médenine',
                  'Monastir',
                  'Nabeul',
                  'Sfax',
                  'Sidi Bouzid',
                  'Siliana',
                  'Sousse',
                  'Tataouine',
                  'Tozeur',
                  'Tunis',
                  'Zaghouan'
                ]),
                TextInput('Addresse', addresseController),
                Dateinput('Date de naissance', birthController, context,
                    licenceController.selectedBirth, licenceController)

                // String? birthday;
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
                      if ((addresseController.text == null) ||
                          (addresseController.text == "") ||
                          (cinController.text == null) ||
                          (cinController.text == "") ||
                          (nomController.text == null) ||
                          (nomController.text == "") ||
                          (prenomController.text == null) ||
                          (prenomController.text == "") ||
                          (phoneController.text == null) ||
                          (phoneController.text == "") ||
                          (licenceController.selectedState == null) ||
                          (licenceController.selectedState == "") ||
                          (licenceController.selectedState == "Governorat") ||
                          (licenceController.selectedSex == "") ||
                          (licenceController.selectedSex == null) ||
                          (licenceController.selectedSex == "Sexe")
                           ||
                           (birthController.text == null) ||
                          (birthController.text == "")
                          // (licenceController.selectedBirth == null) ||
                          // (licenceController.selectedBirth == "")
                          ) {
                        print('i am here');

                        final snackBar = MySnackBar(
                            title: "Champs Obligatoires",
                            msg: "Merci de remplir tous les champs svp",
                            state: ContentType.warning);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        licenceController.createAthleteProfile(
                            address: addresseController.text,
                            cin: cinController.text,
                            firstName: prenomController.text,
                            lastName: nomController.text,
                            phone: phoneController.text,
                            state: stateController.text);
                        GoRouter.of(context)
                            .push(Routes.AddAthleteLicenceScreen);
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAthleteScreen()));
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

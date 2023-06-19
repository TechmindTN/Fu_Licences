import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/licence/licence_list_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/global/inputs.dart';
import '../../licence/addlicence/add_licence_screen.dart';

class AddGradeScreen extends StatefulWidget {
  @override
  State<AddGradeScreen> createState() => _AddGradeScreenState();
}

class _AddGradeScreenState extends State<AddGradeScreen> {
  
  late LicenceProvider licenceController;
  late ParameterProvider paramController;

  TextEditingController gradeController = TextEditingController();
  
  @override
  void initState() {
    licenceController = Provider.of<LicenceProvider>(context, listen: false);
    paramController = Provider.of<ParameterProvider>(context, listen: false);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParameterProvider>(
        builder: (context, paramController, child) {
      return Scaffold(
      
        body: CustomScrollView(

          slivers:[
            MyAppBar("Ajouter une grade", context, false, licenceController, false, true),
            SliverToBoxAdapter(child: SizedBox(height: 3.h),),
            SliverToBoxAdapter(
              child: Center(
            child: Container(
              width: 40.w,
              child: Column(
                children: [
                  TextInput("Grade", gradeController)          
                ],
              ),
            ),
          ),
            )
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
                     
                      if ((gradeController.text == null)||(gradeController.text == "")) {
                        final snackBar = MySnackBar(
                            title: "Champs Obligatoires",
                            msg: "Merci de remplir tous les champs svp",
                            state: ContentType.warning);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                        paramController.addGrade(gradeController.text);
                        GoRouter.of(context).pop();
                        // licenceController.createAthlete(context);
                        // GoRouter.of(context).go(Routes.GradeListScreen);
                      }
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

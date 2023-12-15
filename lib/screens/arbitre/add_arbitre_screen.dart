import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/global/inputs.dart';

class AddArbitreScreen extends StatefulWidget {
  const AddArbitreScreen({super.key});

  @override
  State<AddArbitreScreen> createState() => _AddArbitreScreenState();
}

class _AddArbitreScreenState extends State<AddArbitreScreen> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
        builder: (context, licenceController, child) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('اضافة اجازة حكم'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // String? categoryId;
                // dynamic? gradeId;
                // dynamic? idDegree;
      
                // int? discipline;
      
                // dynamic? weights;
                // String? club;
                // TextInput('الاسم',categoryController),
                // TextInput('اللقب',gradeController),
                // TextInput('رقم الهاتف',degreeController),
      
                // TextInput('رقم الهوية',disciplineController),
                // GategorySelectInput('العمر',
                //     licenceController.selectedCategory, licenceController),
                GradeSelectInput('Grade', licenceController.selectedGrade,
                    licenceController),
                // DegreeSelectInput('Degree', licenceController.selectedDegree,
                //     licenceController),
                // DisciplineSelectInput('الرياضة',
                //     licenceController.selectedDiscipline, licenceController),
      
                // WeightSelectInput('الوزن', licenceController.selectedWeight,
                //     licenceController),
                // ClubSelectInput(
                //     'النادي', licenceController.selectedClub, licenceController),
                // TextInput('عنوان السكن',prenomController),
                // Dateinput('تاريخ الولادة',birthController,context,licenceController.selectedBirth,licenceController)
              ],
            ),
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
                        if (
                            (licenceController.selectedGrade == null) ||
                            (licenceController.selectedGrade!.id == -1) 
                            ) {
                          final snackBar = MySnackBar(
                              title: 'خانات اجبارية',
                              msg: 'الرجاء ملئ جميع الخانات الاجبارية',
                              state: ContentType.warning);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          licenceController.createArbitre(context);
                          GoRouter.of(context).go(Routes.LicenceListScreen);
                        }
                      },
                      label: const Text('تاكيد'),
                    )),
              ],
            ),
          )),
        ),
      );
    });
  }
}

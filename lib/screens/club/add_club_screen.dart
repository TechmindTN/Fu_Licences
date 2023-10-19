import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/global/inputs.dart';
import '../../controllers/club_controller.dart';

class AddClubScreen extends StatefulWidget {
  const AddClubScreen({super.key});

  @override
  State<AddClubScreen> createState() => _AddClubScreenState();
}

class _AddClubScreenState extends State<AddClubScreen> {
  late ClubProvider clubController;
  late LicenceProvider licenceController;
  TextEditingController nameController = TextEditingController();
  TextEditingController ligueController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController disciplineController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    clubController = Provider.of<ClubProvider>(context, listen: false);
        licenceController = Provider.of<LicenceProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClubProvider>(
        builder: (context, clubController, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("اضفة نادي"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              LigueSelectInput('الولاية',
                  licenceController.selectedLigue, licenceController),
              TextInput('الاسم', nameController,)
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
                      if ((licenceController.selectedLigue == null) ||
                          (licenceController.selectedLigue!.id == -1) 
                          ) {
                        final snackBar = MySnackBar(
                            title: 'خانات اجبارية',
                            msg: 'الرجاء ملئ جميع الخانات الاجبارية',
                            state: ContentType.warning);
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else {
                         clubController.createClub(context,licenceController,nameController.text);
                        GoRouter.of(context).go(Routes.Home);
                      }
                    },
                    label: const Text('تاكيد'),
                  )),
            ],
          ),
        )),
      );
    });
  }
}

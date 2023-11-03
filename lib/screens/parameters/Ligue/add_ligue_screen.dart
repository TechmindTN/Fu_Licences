// ignore_for_file: unnecessary_null_comparison

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/global/inputs.dart';

class AddLigueScreen extends StatefulWidget {
  const AddLigueScreen({super.key});

  @override
  State<AddLigueScreen> createState() => _AddLigueScreenState();
}

class _AddLigueScreenState extends State<AddLigueScreen> {
  
  late LicenceProvider licenceController;
  late ParameterProvider paramController;

  TextEditingController ligueController = TextEditingController();
  
  @override
  void initState() {
    licenceController = Provider.of<LicenceProvider>(context, listen: false);
    paramController = Provider.of<ParameterProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParameterProvider>(
        builder: (context, paramController, child) {
      return Directionality(
                textDirection: TextDirection.rtl,

        child: Scaffold(
        
          body: CustomScrollView(
      
            slivers:[
              MyAppBar("اضافة ولاية", context, false, licenceController, false, true),
              SliverToBoxAdapter(child: SizedBox(height: 3.h),),
              SliverToBoxAdapter(
                child: Center(
              child: SizedBox(
                width: 40.w,
                child: Column(
                  children: [
                    TextInput('الولاية', ligueController)          
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
                SizedBox(
                    width: 30.w,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                       
                        if ((ligueController.text == null)||(ligueController.text == "")) {
                          final snackBar = MySnackBar(
                              title: 'خانات اجبارية',
                              msg: 'الرجاء ملئ جميع الخانات الاجبارية',
                              state: ContentType.warning);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          paramController.addLigue(ligueController.text);
                          GoRouter.of(context).pop();
                          // licenceController.createAthlete(context);
                          // GoRouter.of(context).go(Routes.LigueListScreen);
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

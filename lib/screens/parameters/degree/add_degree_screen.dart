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

class AddDegreeScreen extends StatefulWidget {
  const AddDegreeScreen({super.key});

  @override
  State<AddDegreeScreen> createState() => _AddDegreeScreenState();
}

class _AddDegreeScreenState extends State<AddDegreeScreen> {
  
  late LicenceProvider licenceController;
  late ParameterProvider paramController;

  TextEditingController degreeController = TextEditingController();
  
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
      return Directionality(
                textDirection: TextDirection.rtl,

        child: Scaffold(
        
          body: CustomScrollView(
      
            slivers:[
              MyAppBar("Ajouter une degree", context, false, licenceController, false, true),
              SliverToBoxAdapter(child: SizedBox(height: 3.h),),
              SliverToBoxAdapter(
                child: Center(
              child: SizedBox(
                width: 40.w,
                child: Column(
                  children: [
                    TextInput("Degree", degreeController)          
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
                       
                        if ((degreeController.text == null)||(degreeController.text == "")) {
                          final snackBar = MySnackBar(
                              title: 'خانات اجبارية',
                              msg: 'الرجاء ملئ جميع الخانات الاجبارية',
                              state: ContentType.warning);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);
                        } else {
                          paramController.addDegree(degreeController.text);
                          GoRouter.of(context).pop();
                          // licenceController.createAthlete(context);
                          // GoRouter.of(context).go(Routes.DegreeListScreen);
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
    // TODO: implement build
    throw UnimplementedError();
  }
}

import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/licence/licence_widget.dart';

class SelectRoleScreen extends StatefulWidget{
  const SelectRoleScreen({super.key});


  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    licenceController.getParameters();
    licenceController.initSelected();
    licenceController.initCreate();
    // licenceController.initSelected();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Directionality(
                textDirection: TextDirection.rtl,

          child: Scaffold(
            // appBar: AppBar(title: Text("Selectioner le role"),),
            body: CustomScrollView(
              slivers: [
                MyAppBar("اختيار نوع الاجازة", context, false, licenceController, false),
                SliverToBoxAdapter(
                  child: SizedBox(height: 2.h),
                ),
                SliverGrid.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            
              ), itemCount: licenceController.parameters!.roles!.length,
               itemBuilder: (context, index) {
                return ((licenceController.parameters!.roles![index].roles!="مسير")&&(licenceController.parameters!.roles![index].roles!="محب"))?RoleCard(licenceController.parameters!.roles![index], context, licenceController):const SizedBox();
              },)
                
              ],
               
            ),
          ),
        );
      }
    );

  }
}
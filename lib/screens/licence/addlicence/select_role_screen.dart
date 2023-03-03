import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:provider/provider.dart';

import '../../../models/role.dart';
import '../../../widgets/licence/licence_widget.dart';

class SelectRoleScreen extends StatefulWidget{
  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  late LicenceProvider licenceController;
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    licenceController.getParameters();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Container(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for(Role role in licenceController.parameters!.roles! )
                RoleCard(role,context,licenceController)
              ],)
            ),
          ),
        );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
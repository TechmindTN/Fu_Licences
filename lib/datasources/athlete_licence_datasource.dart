import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/licence_controller.dart';
import '../router/routes.dart';

class AthleteLicenceDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final BuildContext context;
   Color color=Colors.red;
  AthleteLicenceDataSource(this.licenceController, this.context);

  @override
  DataRow? getRow(int index) {
     return DataRow(cells: [
      DataCell(Consumer<LicenceProvider>(
        builder: (context,licenceController,child) {
          return Checkbox(onChanged: (bool? value) { 
            licenceController.licenceChecks[index]=!licenceController.licenceChecks[index];
            licenceController.notify();
           }, value: licenceController.licenceChecks[index],);
        }
      )),
      DataCell(Image.network(licenceController.fullAthleteLicences[index].profile!.profilePhoto!, width: 100),
      ),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].licence!.numLicences.toString())),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].profile!.cin.toString())),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].profile!.birthday.toString())),
      DataCell(SelectableText('${licenceController.fullAthleteLicences[index].profile!.firstName} ${licenceController.fullAthleteLicences[index].profile!.lastName}')),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].profile!.sexe.toString())),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].profile!.phone.toString())),
      DataCell(SelectableText(
        (licenceController.fullAthleteLicences[index].profile!.role==4)?"مدرب":(licenceController.fullAthleteLicences[index].profile!.role==1)?"حكم":(licenceController.fullAthleteLicences[index].profile!.role==2)?"رياضي":"")),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].licence!.discipline.toString())),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].licence!.club.toString())),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].profile!.state.toString())),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].licence!.seasons.toString())),
      DataCell(SelectableText(licenceController.fullAthleteLicences[index].licence!.state.toString(),
      style: TextStyle(
        color: (licenceController.fullAthleteLicences[index].licence!.state=="نشطة")?Colors.green:((licenceController.fullAthleteLicences[index].licence!.state=="في الانتظار")?Colors.orange[800]:Colors.red)
      ),
      )),
      DataCell(Row(
        children: [
          FloatingActionButton.small(onPressed: (){
            licenceController.selectedFullLicence=licenceController.fullAthleteLicences[index];
            GoRouter.of(context).push(Routes.LicenceScreen);
          },child: const Icon(Icons.remove_red_eye),),
          SizedBox(width:1.w),
          FloatingActionButton.small(onPressed: (){
            licenceController.deleteLicence(licenceController.fullAthleteLicences[index].licence!.numLicences, context,role:2);
          },
          backgroundColor: Colors.red,child: const Icon(Icons.delete),
          ),
        ],
      )),    
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => licenceController.fullAthleteLicences.length;

  @override
  int get selectedRowCount => 0;

}
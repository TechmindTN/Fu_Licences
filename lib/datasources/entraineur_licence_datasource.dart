import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/licence_controller.dart';
import '../router/routes.dart';

class EntraineurLicenceDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final BuildContext context;
   Color color=Colors.red;
  EntraineurLicenceDataSource(this.licenceController, this.context);

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
      DataCell(Image.network(licenceController.fullCoachLicences[index].profile!.profilePhoto!, width: 100),
      ),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].licence!.numLicences.toString())),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].profile!.cin.toString())),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].profile!.birthday.toString())),
      DataCell(SelectableText('${licenceController.fullCoachLicences[index].profile!.firstName} ${licenceController.fullCoachLicences[index].profile!.lastName}')),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].profile!.sexe.toString())),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].profile!.phone.toString())),
      DataCell(SelectableText(
        (licenceController.fullCoachLicences[index].profile!.role==4)?"مدرب":(licenceController.fullCoachLicences[index].profile!.role==1)?"حكم":(licenceController.fullCoachLicences[index].profile!.role==2)?"رياضي":"")),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].licence!.discipline.toString())),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].licence!.club.toString())),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].profile!.state.toString())),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].licence!.seasons.toString())),
      DataCell(SelectableText(licenceController.fullCoachLicences[index].licence!.state.toString(),
      style: TextStyle(
        color: (licenceController.fullCoachLicences[index].licence!.state=="نشطة")?Colors.green:((licenceController.fullCoachLicences[index].licence!.state=="في الانتظار")?Colors.orange[800]:Colors.red)
      ),
      )),
      DataCell(Row(
        children: [
          FloatingActionButton.small(onPressed: (){
            licenceController.selectedFullLicence=licenceController.fullCoachLicences[index];
            GoRouter.of(context).push(Routes.LicenceScreen);
          },child: const Icon(Icons.remove_red_eye),),
          SizedBox(width:1.w),
          FloatingActionButton.small(onPressed: (){
            licenceController.deleteLicence(licenceController.fullCoachLicences[index].licence!.numLicences, context,112,role:4);
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
  int get rowCount => licenceController.fullCoachLicences.length;

  @override
  int get selectedRowCount => 0;

}
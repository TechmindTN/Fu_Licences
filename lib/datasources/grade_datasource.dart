
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:provider/provider.dart';
import '../controllers/licence_controller.dart';

class GradeDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;

  final BuildContext context;
  GradeDataSource(this.licenceController, this.context, this.paramController);
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<ParameterProvider>(
        builder: (context,paramController,child) {
          return Checkbox(onChanged: (bool? value) { 
            paramController.gradeChecks[index]=!paramController.gradeChecks[index];
            paramController.notify();
           }, value: paramController.gradeChecks[index],);
        }
      )),
      DataCell(SelectableText(licenceController.parameters!.grades![index].grade.toString())),
      DataCell(Row(
        children: [
          // FloatingActionButton.small(onPressed: (){
          // // clubController.selectedClub = licenceController.parameters!.clubs![index];     
          // // GoRouter.of(context).push(Routes.ClubScreen);
          // },child: Icon(Icons.remove_red_eye),),
          // SizedBox(width:1.w),
          FloatingActionButton.small(onPressed: (){
             paramController.removeGrade(licenceController.parameters!.grades![index].id!,context);
            licenceController.parameters!.grades!.remove(licenceController.parameters!.grades![index]);
            licenceController.notify();
          },child: Icon(Icons.delete),
          backgroundColor: Colors.red,
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => licenceController.parameters!.grades!.length;

  @override
  int get selectedRowCount => 0;

}
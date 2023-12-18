
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/licence_controller.dart';

class DegreeDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;
  final BuildContext context;
  DegreeDataSource(this.licenceController, this.context, this.paramController);

  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<ParameterProvider>(
        builder: (context,paramController,child) {
          return Checkbox(onChanged: (bool? value) { 
            paramController.degreeChecks[index]=!paramController.degreeChecks[index];
            paramController.notify();
           }, value: paramController.degreeChecks[index],);
        }
      )),
      DataCell(SelectableText(licenceController.parameters!.degrees![index].degree.toString())),
      DataCell(Row(
        children: [
          // FloatingActionButton.small(onPressed: (){
          //    paramController.removeDegree(licenceController.parameters!.degrees![index].id!,context);
          //   licenceController.parameters!.degrees!.remove(licenceController.parameters!.degrees![index]);
          //   licenceController.notify();
          // },
          // backgroundColor: Colors.orange,child: const Icon(Icons.edit),
          // ),
          // SizedBox(width: 1.w),
          FloatingActionButton.small(onPressed: (){
             paramController.removeDegree(licenceController.parameters!.degrees![index].id!,context);
            licenceController.parameters!.degrees!.remove(licenceController.parameters!.degrees![index]);
            licenceController.notify();
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
  int get rowCount => licenceController.parameters!.degrees!.length;

  @override
  int get selectedRowCount => 0;
}
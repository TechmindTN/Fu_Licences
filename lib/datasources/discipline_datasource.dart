
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:provider/provider.dart';
import '../controllers/licence_controller.dart';

class DisciplineDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;
  final BuildContext context;
  DisciplineDataSource(this.licenceController, this.context, this.paramController);
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<ParameterProvider>(
        builder: (context,paramController,child) {
          return Checkbox(onChanged: (bool? value) { 
            paramController.disciplineChecks[index]=!paramController.disciplineChecks[index];
            paramController.notify();
           }, value: paramController.disciplineChecks[index],);
        }
      )),
      DataCell(SelectableText(licenceController.parameters!.disciplines![index].name.toString())),
      DataCell(SelectableText(licenceController.parameters!.disciplines![index].description.toString())),
      DataCell(Row(
        children: [
          FloatingActionButton.small(onPressed: (){
             paramController.removeDiscipline(licenceController.parameters!.disciplines![index].id!,context);
            licenceController.parameters!.disciplines!.remove(licenceController.parameters!.disciplines![index]);
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
  int get rowCount => licenceController.parameters!.disciplines!.length;

  @override
  int get selectedRowCount => 0;

}
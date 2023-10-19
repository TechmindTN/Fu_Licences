import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:provider/provider.dart';
import '../controllers/licence_controller.dart';

class LigueDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;

  final BuildContext context;
  LigueDataSource(this.licenceController, this.context, this.paramController);
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<ParameterProvider>(
        builder: (context,paramController,child) {
          return Checkbox(onChanged: (bool? value) { 
            paramController.ligueChecks[index]=!paramController.ligueChecks[index];
            paramController.notify();
           }, value: paramController.ligueChecks[index],);
        }
      )),
      DataCell(SelectableText(licenceController.parameters!.ligues![index].name.toString())),
      DataCell(Row(
        children: [
          // FloatingActionButton.small(onPressed: (){
          // // clubController.selectedClub = licenceController.parameters!.clubs![index];     
          // // GoRouter.of(context).push(Routes.ClubScreen);
          // },child: Icon(Icons.remove_red_eye),),
          // SizedBox(width:1.w),
          
          FloatingActionButton.small(onPressed: (){
            paramController.removeLigue(licenceController.parameters!.ligues![index].id!,context);
            licenceController.parameters!.ligues!.remove(licenceController.parameters!.ligues![index]);
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
  int get rowCount => licenceController.parameters!.ligues!.length;

  @override
  int get selectedRowCount => 0;

}
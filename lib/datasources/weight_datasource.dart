import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:provider/provider.dart';
import '../controllers/licence_controller.dart';

class WeightDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;
  final BuildContext context;
  WeightDataSource(this.licenceController, this.context, this.paramController);
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<ParameterProvider>(
        builder: (context,paramController,child) {
          return Checkbox(onChanged: (bool? value) { 
            paramController.weightChecks[index]=!paramController.weightChecks[index];
            paramController.notify();
           }, value: paramController.weightChecks[index],);
        }
      )), 
      DataCell(SelectableText(licenceController.parameters!.weights![index].masseEnKillograme.toString())),
      DataCell(SelectableText(licenceController.parameters!.weights![index].min.toString())),
      DataCell(SelectableText(licenceController.parameters!.weights![index].max.toString())),
      DataCell(Row(
        children: [
          // FloatingActionButton.small(onPressed: (){
          // // clubController.selectedClub = licenceController.parameters!.clubs![index];     
          // // GoRouter.of(context).push(Routes.ClubScreen);
          // },child: Icon(Icons.remove_red_eye),),
          // SizedBox(width:1.w),
          FloatingActionButton.small(onPressed: (){
             paramController.removeWeight(licenceController.parameters!.weights![index].id!,context);
            licenceController.parameters!.weights!.remove(licenceController.parameters!.weights![index]);
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
  int get rowCount => licenceController.parameters!.weights!.length;

  @override
  int get selectedRowCount => 0;

}
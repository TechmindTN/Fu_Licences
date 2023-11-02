
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:provider/provider.dart';

import '../controllers/licence_controller.dart';

class CategoryDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;

  final BuildContext context;
  CategoryDataSource(this.licenceController, this.context, this.paramController);
  
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<ParameterProvider>(
        builder: (context,licenceController,child) {
          return Checkbox(onChanged: (bool? value) { 
            paramController.categoryChecks[index]=!paramController.categoryChecks[index];
            paramController.notify();
            //print(value);
            //print(index);
           }, value: paramController.categoryChecks[index],);
        }
      )),
     
      
      DataCell(SelectableText(licenceController.parameters!.categories![index].categorieAge.toString())),
      DataCell(SelectableText(licenceController.parameters!.categories![index].min.toString())),
      DataCell(SelectableText(licenceController.parameters!.categories![index].max.toString())),
      
      DataCell(Row(
        children: [
          // FloatingActionButton.small(onPressed: (){
          // // clubController.selectedClub = licenceController.parameters!.clubs![index];     
          // // GoRouter.of(context).push(Routes.ClubScreen);
          // },child: Icon(Icons.remove_red_eye),),
          // SizedBox(width:1.w),
          
          FloatingActionButton.small(onPressed: (){
             paramController.removeCategory(licenceController.parameters!.categories![index].id!,context);
            licenceController.parameters!.categories!.remove(licenceController.parameters!.categories![index]);
            licenceController.notify();
          },
          backgroundColor: Colors.red,child: const Icon(Icons.delete),
          ),
          
        ],
      )),
      

      
    ]);
    // TODO: implement getRow
    throw UnimplementedError();
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => licenceController.parameters!.categories!.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}
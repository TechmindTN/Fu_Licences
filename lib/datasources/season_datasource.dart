
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../controllers/licence_controller.dart';

class SeasonDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;
  final BuildContext context;
  SeasonDataSource(this.licenceController, this.context, this.paramController);
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<ParameterProvider>(
        builder: (context,paramController,child) {
          return Checkbox(onChanged: (bool? value) { 
            paramController.seasonChecks[index]=!paramController.seasonChecks[index];
            paramController.notify();
           }, value: paramController.seasonChecks[index],);
        }
      )),
      DataCell(SelectableText(licenceController.parameters!.seasons![index].seasons.toString())),
      DataCell(SelectableText(licenceController.parameters!.seasons![index].activated.toString())),
      
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // FloatingActionButton.small(onPressed: (){
          // // clubController.selectedClub = licenceController.parameters!.clubs![index];     
          // // GoRouter.of(context).push(Routes.ClubScreen);
          // },child: Icon(Icons.remove_red_eye),),
          // SizedBox(width:1.w),
           if(licenceController.parameters!.seasons![index].activated==false)ElevatedButton(
                          onPressed: (){

                          }, child: Text("Activer")),
                          if(licenceController.parameters!.seasons![index].activated==true) SizedBox(width: 9.2.w,),
                          SizedBox(width: 10,),
          FloatingActionButton.small(onPressed: (){},child: Icon(Icons.delete),
          backgroundColor: Colors.red,
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => licenceController.parameters!.seasons!.length;

  @override
  int get selectedRowCount => 0;

}
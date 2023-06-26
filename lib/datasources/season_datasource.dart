import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/parameters_controller.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../controllers/club_controller.dart';
import '../controllers/licence_controller.dart';
import '../router/routes.dart';
import '../models/licence.dart';

class SeasonDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ParameterProvider paramController;

  final BuildContext context;
  SeasonDataSource(this.licenceController, this.context, this.paramController);
  
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Checkbox(onChanged: (bool? value) { 
        print(value);
        print(index);
       }, value: paramController.seasonChecks[index],)),
     
      
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
                          onPressed: (){}, child: Text("Activer")),
                          if(licenceController.parameters!.seasons![index].activated==true) SizedBox(width: 9.2.w,),
                          SizedBox(width: 10,),
          FloatingActionButton.small(onPressed: (){},child: Icon(Icons.delete),
          backgroundColor: Colors.red,
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
  int get rowCount => licenceController.parameters!.seasons!.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}
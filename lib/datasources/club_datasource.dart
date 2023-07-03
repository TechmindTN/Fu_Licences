import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/club_controller.dart';
import '../controllers/licence_controller.dart';
import '../router/routes.dart';
import '../models/licence.dart';

class ClubDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final ClubProvider clubController;

  final BuildContext context;
  ClubDataSource(this.licenceController, this.context, this.clubController);
  
  
  @override
  DataRow? getRow(int index) { 
     return DataRow(cells: [
      DataCell(Consumer<LicenceProvider>(
        builder: (context,licenceController,child) {
          return Checkbox(onChanged: (bool? value) { 
            licenceController.clubChecks[index]=!licenceController.clubChecks[index];
            licenceController.notify();
            print(value);
            print(index);
           }, value: licenceController.clubChecks[index],);
        }
      )),
     
      
      DataCell(SelectableText(licenceController.parameters!.clubs![index].name.toString())),
      DataCell(SelectableText(licenceController.parameters!.clubs![index].ligue.toString())),
      
      DataCell(Row(
        children: [
          FloatingActionButton.small(onPressed: (){
          clubController.selectedClub = licenceController.parameters!.clubs![index];     
          GoRouter.of(context).push(Routes.ClubScreen);
          },child: Icon(Icons.remove_red_eye),),
          SizedBox(width:1.w),
          
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
  int get rowCount => licenceController.parameters!.clubs!.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}
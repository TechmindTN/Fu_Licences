import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../controllers/licence_controller.dart';
import '../router/routes.dart';
import '../models/licence.dart';

class LicenceDataSource extends DataTableSource{
  final LicenceProvider licenceController;
  final BuildContext context;
   Color color=Colors.red;
  LicenceDataSource(this.licenceController, this.context);
  // final List<bool> licenceChecks;

  // LicenceDataSource(this.licences, this.licenceChecks);
  // final List<Map<String,dynamic>> data=List.generate(200, (index) => {
  //     'id':index,
  //     'name':'my name is'+index.toString(),
  //     'age':Random().nextInt(80)
  //   });
  
  @override
  DataRow? getRow(int index) {
     return DataRow(cells: [
      DataCell(Consumer<LicenceProvider>(
        builder: (context,licenceController,child) {
          return Checkbox(onChanged: (bool? value) { 
            licenceController.licenceChecks[index]=!licenceController.licenceChecks[index];
            licenceController.notify();
            print(value);
            print(index);
           }, value: licenceController.licenceChecks[index],);
        }
      )),
      // DataCell(Consumer<LicenceProvider>(
      //   builder: (context,licenceController,child) {
      //     return InkWell(
      //       onTap: () {
      //         print(index);
      //         licenceController.licenceChecks[index]=!licenceController.licenceChecks[index];
      //         licenceController.notify();
      //       },
      //       child: Container(
      //         width: 2.w,
      //         height: 1.h,
      //         color: (licenceController.licenceChecks[index]==true)?Colors.red:Colors.green,
              
      //       ),
      //     );
      //   }
      // )),
      DataCell(Image.network(licenceController.fullLicences[index].profile!.profilePhoto!, width: 100),
      
      ),
      DataCell(SelectableText(licenceController.fullLicences[index].licence!.numLicences.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].profile!.cin.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].profile!.birthday.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].profile!.firstName.toString()+' '+licenceController.fullLicences[index].profile!.lastName.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].profile!.sexe.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].profile!.phone.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].profile!.role.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].licence!.discipline.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].licence!.club.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].profile!.state.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].licence!.seasons.toString())),
      DataCell(SelectableText(licenceController.fullLicences[index].licence!.state.toString(),
      
      style: TextStyle(
        color: (licenceController.fullLicences[index].licence!.state=='Activee')?Colors.green:((licenceController.fullLicences[index].licence!.state=='En Attente')?Colors.orange[800]:Colors.red)
      ),
      )),
      DataCell(Row(
        children: [
          FloatingActionButton.small(onPressed: (){
            licenceController.selectedFullLicence=licenceController.fullLicences[index];
            GoRouter.of(context).push(Routes.LicenceScreen);
          },child: Icon(Icons.remove_red_eye),),
          SizedBox(width:1.w),
          // FloatingActionButton.small(onPressed: (){},child: Icon(Icons.edit),backgroundColor: Colors.amber[800],),
          // SizedBox(width:1.w),
          FloatingActionButton.small(onPressed: (){},child: Icon(Icons.delete),
          backgroundColor: Colors.red,
          ),
          
        ],
      )),
      // DataCell(Text(licences[index].numLicences.toString())),
      // DataCell(Text(licences[index].numLicences.toString())),
      // DataCell(Text(licences[index].numLicences.toString())),
      // DataCell(Text(licences[index].numLicences.toString())),

      
    ]);
    // TODO: implement getRow
    throw UnimplementedError();
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => licenceController.fullLicences.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}
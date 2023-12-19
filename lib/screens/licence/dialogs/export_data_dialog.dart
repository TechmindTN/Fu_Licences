import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/category.dart';
import 'package:fu_licences/models/club.dart';
import 'package:fu_licences/models/role.dart';
import 'package:fu_licences/models/season.dart';
import 'package:fu_licences/widgets/global/inputs.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ExportDataDialog extends StatefulWidget{
  @override
  State<ExportDataDialog> createState() => _ExportDataDialogState();
}

class _ExportDataDialogState extends State<ExportDataDialog> {
  late LicenceProvider licenceController;
  TextEditingController startDate=TextEditingController();
  TextEditingController endDate=TextEditingController();
  TextEditingController fileName=TextEditingController();
  
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    licenceController.selectedRole=Role(roles: "نوع الاجازة", id: -1);
    licenceController.selectedSeason=Season(seasons: "الموسم", id: -1);
    licenceController.selectedClub=Club(name: "النادي", id: -1);
    licenceController.selectedCategory=Category(categorieAge: "العمر", id: -1);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("استخراج الاجازات"),
      content: Container(
        child: Consumer<LicenceProvider>(
          builder: (context,licenceController,child) {
            return (licenceController.isLoading==false)?Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: 70.w,
                // height: 36.h,
                constraints: BoxConstraints(
                  minHeight: 27.h,
                  maxHeight: 36.h,
                  minWidth: 70.w

                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RoleSelectInput("نوع الاجازة", licenceController.selectedRole, licenceController),
                          
                    SeasonSelectInput("الموسم", licenceController.selectedSeason, licenceController),
                                    if(licenceController.selectedRole.id==2)
                    ClubSelectInput("النادي", licenceController.selectedClub, licenceController),
                    if(licenceController.selectedRole.id==2)
                    GategorySelectInput("العمر", licenceController.selectedCategory, licenceController),
                    Dateinput("من تاريخ", startDate, context, licenceController.selectedBirth, licenceController),
                    SelectInput("الحالة", licenceController.selectedStatus,   licenceController,["نشطة","في الانتظار","منتهية",]),
                    // Dateinput("الى تاريخ", endDate, context, licenceController.selectedBirth, licenceController),
                    // Dateinput("Ending Date", control, context, selected, licenceController),
                    TextInput("اسم الملف", fileName)
                  ],
                ),
              ),
            ):Container(
              // width: 70.w,
                // height: 36.h,
                constraints: BoxConstraints(
                  minHeight: 27.h,
                  maxHeight: 36.h,
                  minWidth: 70.w

                ),
              child: Center(child: CircularProgressIndicator(),));
          }
        ),
      ),
      actions: [Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("الغاء")),
          ElevatedButton(onPressed: (){
            licenceController.exportAthletesToExcel( fileName.text, 0,context,startDate.text);
          }, child: Text("تاكيد")),
        ],
      )],
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
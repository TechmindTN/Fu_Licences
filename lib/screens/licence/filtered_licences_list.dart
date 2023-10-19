import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FilteredLicencesScreen extends StatefulWidget{
  @override
  State<FilteredLicencesScreen> createState() => _FilteredLicencesScreenState();
}

class _FilteredLicencesScreenState extends State<FilteredLicencesScreen> {
  late LicenceProvider licenceController;
  TextEditingController numControl=TextEditingController();
  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    // licenceController.getLicences();
    // licenceController.getParameters();
    // licenceController.initSelected();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text('Licences Filtree'),
          //   actions: [
          //     //  IconButton(onPressed: (){
          //     //   licenceController.showFilterDialog(context,numControl);
          //     //   // licenceController.showSearchDialog(context,numControl);
          //     // }, icon: Icon(Icons.filter_alt_sharp)),
          //     // IconButton(onPressed: (){
          //     //   licenceController.showSearchDialog(context,numControl);
          //     // }, icon: Icon(Icons.search)),

          //   ],
          // ),
          backgroundColor: Color(0xfffafafa),
          body: CustomScrollView(
            slivers: [
              MyAppBar("الاجازات المصفاة", context, false, licenceController, false,true),
             (licenceController.filteredFullLicences.length>0)?
                SliverGrid.builder(
              
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
            crossAxisSpacing: 0.w
            ),

            itemCount: licenceController.filteredFullLicences.length,
             itemBuilder: (context,index){
              return LicenceItem(licenceController.filteredFullLicences[index], licenceController, context);
            }): SliverToBoxAdapter(
                child:  Container(
              height: 40.h,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('قائمة الاجازات المصفاة فارغة الرجاء تعديل اعدادات التصفية'),),
                ],
              ),
            ),
            //     Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     SizedBox(height: 2.h),
            //     for(FullLicence fullLicence in licenceController.filteredFullLicences)
            //     Center(child: LicenceItem(fullLicence,licenceController,context)),
            //   ],
            // )
            
              )
              
            ],
            
            
          ),
          //  floatingActionButton: FloatingActionButton(onPressed: () {
          //   Navigator.push(context, MaterialPageRoute(builder: ((context) => SelectRoleScreen())));
          // },
          // child: Icon(Icons.add),
          // ),
          );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
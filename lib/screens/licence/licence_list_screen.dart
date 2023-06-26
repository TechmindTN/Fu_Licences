import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/datasources/licence_datasource.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LicenceListScreen extends StatefulWidget{
  @override
  State<LicenceListScreen> createState() => _LicenceListScreenState();
}

class _LicenceListScreenState extends State<LicenceListScreen> {
  late LicenceProvider licenceController;
  TextEditingController numControl=TextEditingController();
// late final List<Map<String,dynamic>> data;
late DataTableSource dataSource;
  @override
  void didChangeDependencies() {
   
    
    // print('licences length '+licenceController.fullLicences.length.toString());
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    // licenceController.getLicences();
    // licenceController.getParameters();
    licenceController.initSelected();
    licenceController.initCreate();
    
    WidgetsBinding.instance.addPostFrameCallback((_) 
      //  Future.delayed(Duration(seconds: 3), () => 
       {
        if(licenceController.added){
      final snackBar=MySnackBar(title: "Ajout de licence succees",msg: "La licence a ete ajoutee avec succees",state: ContentType.success);
      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
      licenceController.added=false;
    }
       
      //  );
    });
    
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        
    dataSource=LicenceDataSource(licenceController,context);
    //  if(licenceController.added){
    //   final snackBar=MySnackBar(title: "Ajout de licence succees",msg: "La licence a ete ajoutee avec succees",state: ContentType.success);
    //   ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
    //   licenceController.added=false;
    // }
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Scaffold(
          drawer: MyDrawer(licenceController, context),
          
          
          backgroundColor: Color(0xfffafafa),
          body: CustomScrollView(
            slivers: [
              MyAppBar("Licences", context, true,licenceController,false,false),
              
            //   SliverToBoxAdapter(child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     SizedBox(height: 2.h),
            //     LicenceListHeader(licenceController,numControl,context),
                
                
            //     (licenceController.isLoading)?Container(
            //       height: 20.h,
            //       child: Center(child: CircularProgressIndicator(),)):Column(
            //       children: [
                    
            //         // for(FullLicence fullLicence in licenceController.fullLicences)
            //         // Center(child: LicenceItem(fullLicence,licenceController,context)),
            //       ],
            //     ),
            //   ],
            // ),),

            //Desktop View
            FutureBuilder(
              future: licenceController.getLicences(),
              builder: (context,snapshot) {

                 if(snapshot.connectionState==ConnectionState.done){
                                  licenceController.licenceChecks=List.generate(licenceController.fullLicences.length,(index)=>false);

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black)
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,

                        )]
                      ),
                      child: PaginatedDataTable(
                        sortColumnIndex: licenceController.currentSortColumn,
                        sortAscending: licenceController.isAscending,
                        columnSpacing: 0,
                        rowsPerPage: 10,
                        header:  LicenceListHeader(licenceController,numControl,context),
                        columns: [ 
                          DataColumn(label: Text(''),),
                          DataColumn(label: Text('photo de profile'),),
                          DataColumn(label: Text('licence'),
                          // onSort: licenceController.sortColumn(0)
                          ),
                          DataColumn(label: Text('cin')),
                          DataColumn(label: Text('Naissance')),
                          DataColumn(label: Text('nom')),
                          DataColumn(label: Text('sexe')),
                          DataColumn(label: Text('telephone')),
                          DataColumn(label: Text('role')),
                          DataColumn(label: Text('discipline')),
                          DataColumn(label: Text('club')),
                          DataColumn(label: Text('ligue')),
                          DataColumn(label: Text('saison')),
                          DataColumn(label: Text('status')),
                          DataColumn(label: Text('Actions')),
                          ],
                        // actions: [
                        //   IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye))
                        // ],
                        
                        arrowHeadColor: Colors.blue,
                        availableRowsPerPage: [10,20,50,100],
                  
                        showCheckboxColumn: true,
                        showFirstLastButtons: true,
                         source: dataSource)
                      ),
                  ),
                );}
                else {return SliverToBoxAdapter(child: Container(
              height: 40.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            ));}
              }
            )
            //Mobile View
            // SliverGrid.builder(
              
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
            // crossAxisSpacing: 0.w
            // ),

            // itemCount: licenceController.fullLicences.length,
            //  itemBuilder: (context,index){
            //   return LicenceItem(licenceController.fullLicences[index], licenceController, context);
            // }),
              ]
            
          ),
           floatingActionButton: FloatingActionButton(onPressed: () {
            GoRouter.of(context).push(Routes.SelectRoleScreen);
            // Navigator.push(context, MaterialPageRoute(builder: ((context) => SelectRoleScreen())));
          },
          child: Icon(Icons.add),
          ),
          );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
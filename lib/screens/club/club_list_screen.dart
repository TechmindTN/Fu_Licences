import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/club_controller.dart';
import '../../datasources/club_datasource.dart';
import '../../widgets/clubs/club_widgets.dart';

class ClubListScreen extends StatefulWidget{
  @override
  State<ClubListScreen> createState() => _ClubListScreenState();
}

class _ClubListScreenState extends State<ClubListScreen> {
  late LicenceProvider licenceController;
    late ClubProvider clubController;
late DataTableSource dataSource;

  TextEditingController numControl=TextEditingController();

  @override
  Future<void> didChangeDependencies() async {
    // await licenceController.getParameters();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    clubController=Provider.of<ClubProvider>(context,listen: false);
         //clubController.chargeClub(licenceController);

    // licenceController.getLicences();
    
    // licenceController.initSelected();
    // licenceController.initCreate();
    // WidgetsBinding.instance.addPostFrameCallback((_) 
    //   //  Future.delayed(Duration(seconds: 3), () => 
    //    {
    //     if(licenceController.added){
    //   final snackBar=MySnackBar(title: "Ajout de licence succees",msg: "La licence a ete ajoutee avec succees",state: ContentType.success);
    //   ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
    //   licenceController.added=false;
    // }
       
      //  );
    // });
    
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    dataSource=ClubDataSource(licenceController,context,clubController);
    //  if(licenceController.added){
    //   final snackBar=MySnackBar(title: "Ajout de licence succees",msg: "La licence a ete ajoutee avec succees",state: ContentType.success);
    //   ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
    //   licenceController.added=false;
    // }
    return Consumer<ClubProvider>(
      builder: (context,clubController,child) {
        return Scaffold(
          drawer: MyDrawer(licenceController, context),
          
          
          backgroundColor: Color(0xfffafafa),
          body: CustomScrollView(
            slivers: [
              MyAppBar("Clubs", context, true,licenceController,false,false),
              SliverToBoxAdapter(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2.h),
                ClubListHeader(licenceController,clubController,numControl,context),
              ]
                
              )),
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
           FutureBuilder(
            future: licenceController.getParameters(),
             builder: (context,snaphot) {
              if(snaphot.connectionState==ConnectionState.done){
                    licenceController.clubChecks=List.generate(licenceController.parameters!.clubs!.length,(index)=>false);

                print('club length is '+licenceController.parameters!.clubs!.length.toString());
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
                    // header:  LicenceListHeader(licenceController,numControl,context),
                    columns: [ 
                      DataColumn(label: Text(''),),
                      // DataColumn(label: Text('logo'),),                     
                      DataColumn(label: Text('nom')),                     
                      DataColumn(label: Text('ligue')),                     
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
            );
              //  return SliverGrid.builder(
                  
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,
              //   crossAxisSpacing: 0.w
              //   ),

              //   itemCount: licenceController.parameters!.clubs!.length,
              //    itemBuilder: (context,index){
                  // return ClubItem(licenceController.parameters!.clubs![index], licenceController,clubController, context);
              //   });
             }
             else{
           return SliverToBoxAdapter(child: Container(
              height: 40.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              ),
            ));
            
            }
             }
             
             )
              ]
            
          ),
           floatingActionButton: FloatingActionButton(onPressed: () {
            licenceController.selectedRole=licenceController.parameters!.roles!.firstWhere((element) => element.id==7);
            GoRouter.of(context).push(Routes.AddProfileScreen);
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
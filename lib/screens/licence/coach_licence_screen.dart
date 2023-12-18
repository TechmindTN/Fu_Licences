import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/datasources/entraineur_licence_datasource.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/club_controller.dart';

class CoachLicenceListScreenCopy extends StatefulWidget{
  const CoachLicenceListScreenCopy({super.key});

  @override
  State<CoachLicenceListScreenCopy> createState() => _CoachLicenceListScreenCopyState();
}

class _CoachLicenceListScreenCopyState extends State<CoachLicenceListScreenCopy> {
  late LicenceProvider licenceController;
    // late ClubProvider clubController;
late DataTableSource dataSource;

  TextEditingController numControl=TextEditingController();
  late Future future;
  @override
  Future<void> didChangeDependencies() async {
    // await licenceController.getParameters();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
        licenceController.getParameters();
    licenceController.currentPage=0;
    licenceController.initSelected();
    licenceController.initCreate();
    future=licenceController.getPaginatedLicences(licenceController.activeSeason.id,role: 4);
    WidgetsBinding.instance.addPostFrameCallback((_) 
      //  Future.delayed(Duration(seconds: 3), () => 
       {
        if(licenceController.added){
      final snackBar=MySnackBar(title: 'تمت الاضافة بنجاح',msg: 'تمت اضافة الاجازة بنجاح',state: ContentType.success);
      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
      licenceController.added=false;
    }
       
      //  );
    });
    // licenceController.getLicences();
    //clubController.chargeClub(licenceController);

    // licenceController.getLicences();
    
    // licenceController.initSelected();
    // licenceController.initCreate();
    // WidgetsBinding.instance.addPostFrameCallback((_) 
    //   //  Future.delayed(Duration(seconds: 3), () => 
    //    {
    //     if(licenceController.added){
    //   final snackBar=MySnackBar(title: 'تمت الاضافة بنجاح',msg: 'تمت اضافة الاجازة بنجاح',state: ContentType.success);
    //   ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
    //   licenceController.added=false;
    // }
       
      //  );
    // });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dataSource=EntraineurLicenceDataSource(licenceController,context);
    //  if(licenceController.added){
    //   final snackBar=MySnackBar(title: 'تمت الاضافة بنجاح',msg: 'تمت اضافة الاجازة بنجاح',state: ContentType.success);
    //   ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
    //   licenceController.added=false;
    // }
    return Consumer<ClubProvider>(
      builder: (context,clubController,child) {
        return Directionality(
                  textDirection: TextDirection.rtl,

          child: Scaffold(
            drawer: MyDrawer(licenceController, context),
            
            
            backgroundColor: const Color(0xfffafafa),
            body: CustomScrollView(
              slivers: [
                MyAppBar('اجازات المدربين', context, true,licenceController,false,false),
                SliverToBoxAdapter(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 2.h),
                  LicenceListHeader(licenceController,numControl,context,6),
                ]
                  
                )),
              //     (licenceController.isLoading)?Container(
              //       height: 20.h,
              //       child: Center(child: CircularProgressIndicator(),)):Column(
              //       children: [
                      
              //         // for(FullLicence fullLicence in licenceController.fullAthleteLicences)
              //         // Center(child: LicenceItem(fullLicence,licenceController,context)),
              //       ],
              //     ),
              //   ],
              // ),),
             Consumer<LicenceProvider>(
               builder: (context,licenceController,child) {
                 return FutureBuilder(
                  future: future,
                   builder: (context,snaphot) {
                    if(snaphot.connectionState==ConnectionState.done){
                          
                      licenceController.licenceChecks=List.generate(licenceController.fullCoachLicences.length,(index)=>false);
                      // //print('club length is '+licenceController.parameters!.clubs!.length.toString());
                       return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black)
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
        
                          )]
                        ),
                        child: PaginatedDataTable(
                          header: SizedBox(
                            width: 80.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("المجموع: ${licenceController.stats.coachesLicences!.total}")
                                
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              children: [
                                 IconButton(onPressed: (){
                                  if(licenceController.currentPage>1){
                                  licenceController.currentPage--;
                                  setState(() {
                                    
                                  });
                                  }
                                }, icon:const Icon(Icons.keyboard_arrow_right_outlined)),
                                Text(licenceController.currentPage.toString()),
                                IconButton(onPressed: (){
                                  
                                  licenceController.currentPage++;
                                  setState(() {
                                    
                                  });
                                }, icon:const Icon(Icons.keyboard_arrow_left_outlined)),
                               
                                
                                // IconButton(onPressed: (){
                                //   licenceController.currentPage--;
                                //   print(licenceController.currentPage);
                                // }, icon:const Icon(Icons.arrow_forward_ios)),
                              ],
                            )
                          ],
                          sortColumnIndex: licenceController.currentSortColumn,
                          sortAscending: licenceController.isAscending,
                          columnSpacing: 0,
                          rowsPerPage: 10,
                          // header:  LicenceListHeader(licenceController,numControl,context),
                          columns: const [ 
                            DataColumn(label: Text(''),),
                            DataColumn(label: Text('صورة الحساب'),),
                            DataColumn(label: Text('الاجازة'),
                            // onSort: licenceController.sortColumn(0)
                            ),
                            DataColumn(label: Text('رقم الهوية')),
                            DataColumn(label: Text('تاريخ الولادة')),
                            DataColumn(label: Text('اللقب')),
                            DataColumn(label: Text('الجنس')),
                            DataColumn(label: Text('رقم الهاتف')),
                            DataColumn(label: Text('نوع الاجازة')),
                            DataColumn(label: Text('الرياضة')),
                            DataColumn(label: Text('النادي')),
                            DataColumn(label: Text('الولاية')),
                            DataColumn(label: Text('الموسم')),
                            DataColumn(label: Text('الحالة')),
                            DataColumn(label: Text('الاجراءات')),
                            ],
                          // actions: [
                          //   IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye))
                          // ],
                          
                          arrowHeadColor: Colors.blue,
                          availableRowsPerPage: const [10,20,50,100],
                    
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
                 return SliverToBoxAdapter(child: SizedBox(
                    height: 40.h,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ));
                  
                  }
                   }
                   
                   );
               }
             )
                ]
              
            ),
            //  floatingActionButton: FloatingActionButton(onPressed: () {
            //               GoRouter.of(context).push(Routes.SelectRoleScreen);
        
            //   // licenceController.selectedRole=licenceController.parameters!.roles!.firstWhere((element) => element.id==7);
            //   // GoRouter.of(context).push(Routes.AddProfileScreen);
            //   // Navigator.push(context, MaterialPageRoute(builder: ((context) => SelectRoleScreen())));
            // },
            // child: const Icon(Icons.add),
            // ),
            ),
        );
      }
    );

  }
}
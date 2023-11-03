import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/datasources/weight_datasource.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/parameters_controller.dart';



class WeightListScreen extends StatefulWidget{
  const WeightListScreen({super.key});

  @override
  State<WeightListScreen> createState() => _WeightListScreenState();
}

class _WeightListScreenState extends State<WeightListScreen> {
  late LicenceProvider licenceController;
    late ParameterProvider paramController;
  late WeightDataSource dataSource;

  @override
  Future<void> didChangeDependencies() async {
    // await licenceController.getParameters();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    paramController=Provider.of<ParameterProvider>(context,listen: false);
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    paramController.weightChecks=List.generate(licenceController.parameters!.weights!.length,(index)=>false);
    dataSource=WeightDataSource(licenceController,context,paramController); 
   //ligue.
    return Consumer<ParameterProvider>(
      builder: (context,clubController,child) {
        return Directionality(
                  textDirection: TextDirection.rtl,

          child: Scaffold(
            drawer: MyDrawer(licenceController, context),
            
            
            backgroundColor: const Color(0xfffafafa),
            body: CustomScrollView(
              slivers: [
                MyAppBar('الوزن', context, false,licenceController,false,true),
                // SliverToBoxAdapter(child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // children: [
                //   SizedBox(height: 2.h),
                //   ClubListHeader(licenceController,numControl,context),
                // ]
                  
                // )),
            //  SliverToBoxAdapter(
            //   child: Container(
            //     height: 4.h,
            //     color: Colors.white,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 256,
                
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Id"),
            //             Text("Masse"),
            //             Text("Min"),
            //             Text("Max"),
            //             Text('اضيف يوم'),
            //             Text('الاجراءات')
            //         ],
            //       ),
            //     ),
            //   ),
            //  ),
             FutureBuilder(
              future: licenceController.getParameters(),
               builder: (context,snaphot) {
                if(snaphot.connectionState==ConnectionState.done){
                  //Desktop View
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
                      sortColumnIndex: licenceController.currentSortColumn,
                      sortAscending: licenceController.isAscending,
                      columnSpacing: 0,
                      rowsPerPage: 10,
                      // header:  LicenceListHeader(licenceController,numControl,context),
                      columns: const [ 
                        DataColumn(label: Text(''),),
                        // DataColumn(label: Text('logo'),),                     
                        DataColumn(label: Text('اللقب')),   
                        DataColumn(label: Text('العمر الادنى')),                   
                        DataColumn(label: Text('العمر الاقصى')),                     
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
        
        //Mobile View
                // return  SliverList(
        
                  
                //   delegate: SliverChildBuilderDelegate(
                    
                //    childCount:  licenceController.parameters!.weights!.length,
                //     (context, index) {
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(horizontal:256,
                //     vertical: 10
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                //       children: [
                //         Text(licenceController.parameters!.weights![index].id.toString()),
                //       Text(licenceController.parameters!.weights![index].masseEnKillograme.toString()),
                //       Text(licenceController.parameters!.weights![index].min.toString()),
                //       Text(licenceController.parameters!.weights![index].max.toString()),
                //       Text(licenceController.parameters!.weights![index].created.toString()),
                //       FloatingActionButton(
                //         mini: true,
                //         onPressed: (){}, child: Icon(Icons.delete))
                //       ],
                //     ),
                //   );
                //  }),);
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
              ));}
               })
                ]
              
            ),
             floatingActionButton: FloatingActionButton(onPressed: () {
              GoRouter.of(context).push(Routes.AddWeightScreen);
              // Navigator.push(context, MaterialPageRoute(builder: ((context) => SelectRoleScreen())));
            },
            child: const Icon(Icons.add),
            ),
            ),
        );
      }
    );

  }
}
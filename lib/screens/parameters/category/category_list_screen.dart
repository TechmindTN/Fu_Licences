import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:fu_licences/datasources/category_datasource.dart';

import '../../../controllers/parameters_controller.dart';
// import '../../../datasources/category_datasource.dart';
import '../../../models/category.dart';



class CategoryListScreen extends StatefulWidget{
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  late LicenceProvider licenceController;
    late ParameterProvider paramController;
  late DataTableSource dataSource;


  @override
  Future<void> didChangeDependencies() async {
    // await licenceController.getParameters();
    // TODO: implement didChangeDependencies
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
    paramController.categoryChecks=List.generate(licenceController.parameters!.categories!.length,(index)=>false);
    dataSource=CategoryDataSource(licenceController,context,paramController);
  
   Category category=Category();
   //category.
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
                MyAppBar("العمر", context, false,licenceController,false,true),
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
            //             Text('العمر'),
            //             Text('العمر الادنى'),
            //             Text('العمر الاقصى'),
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
                // SliverList(
        
                  
                //   delegate: SliverChildBuilderDelegate(
                    
                //    childCount:  licenceController.parameters!.categories!.length,
                //     (context, index) {
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(horizontal:256,
                //     vertical: 10
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                //       children: [
                //         Text(licenceController.parameters!.categories![index].id.toString()),
                //       Text(licenceController.parameters!.categories![index].categorieAge.toString()),
                //       Text(licenceController.parameters!.categories![index].min.toString()),
                //       Text(licenceController.parameters!.categories![index].max.toString()),
        
                //       Text(licenceController.parameters!.categories![index].created.toString()),
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
              GoRouter.of(context).push(Routes.AddCategoryScreen);
              // Navigator.push(context, MaterialPageRoute(builder: ((context) => SelectRoleScreen())));
            },
            child: const Icon(Icons.add),
            ),
            ),
        );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:fu_licences/widgets/parameter/parameter_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/parameters_controller.dart';
import '../../../datasources/category_datasource.dart';
import '../../../models/category.dart';
import '../../../models/ligue.dart';



class CategoryListScreen extends StatefulWidget{
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
        return Scaffold(
          drawer: MyDrawer(licenceController, context),
          
          
          backgroundColor: Color(0xfffafafa),
          body: CustomScrollView(
            slivers: [
              MyAppBar("Categorie d'age", context, false,licenceController,false,true),
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
          //             Text("Categorie"),
          //             Text("Age Minimale"),
          //             Text("Age Maximale"),
          //             Text("Cree le"),
          //             Text("Actions")
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
                      DataColumn(label: Text('Age Minimale')),                   
                      DataColumn(label: Text('Age Maximale')),                     
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
           return SliverToBoxAdapter(child: Container(
              height: 40.h,
              child: Column(
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
          child: Icon(Icons.add),
          ),
          );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
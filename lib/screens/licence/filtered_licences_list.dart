import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/datasources/licence_datasource.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FilteredLicencesScreen extends StatefulWidget{
  const FilteredLicencesScreen({super.key});

  @override
  State<FilteredLicencesScreen> createState() => _FilteredLicencesScreenState();
}

class _FilteredLicencesScreenState extends State<FilteredLicencesScreen> {
  late LicenceProvider licenceController;
  TextEditingController numControl=TextEditingController();
  late LicenceDataSource licenceDataSource;

  

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    licenceDataSource=LicenceDataSource(licenceController, context);
    // licenceController.getLicences();
    // licenceController.getParameters();
    // licenceController.initSelected();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<LicenceProvider>(
      builder: (context,licenceController,child) {
        return Directionality(
                  textDirection: TextDirection.rtl,

          child: Scaffold(
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
            backgroundColor: const Color(0xfffafafa),
            body: CustomScrollView(
              slivers: [
                MyAppBar("الاجازات المصفاة", context, false, licenceController, false,true),
               (licenceController.filteredFullLicences.isNotEmpty)?
              
              
              
              
              SliverToBoxAdapter(
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text("المجموع: ${licenceController.stats.totalLicences!}")
                          ],
                        ),
                      ),
                      actions: [
                        Row(
                          children: [
                             IconButton(onPressed: (){
                              if(licenceController.currentPage>1){
                              licenceController.currentPage--;
                              licenceController.filterLicences(context);
                              licenceController.notify();
                              // setState(() {
                              // });
                              }
                            }, icon:const Icon(Icons.keyboard_arrow_right_outlined)),
                            Text(licenceController.currentPage.toString()),
                            IconButton(onPressed: (){
                              
                              licenceController.currentPage++;
                              licenceController.filterLicences(context);
                              licenceController.notify();
                              // setState(() {
                                
                              // });
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
                      
                      // arrowHeadColor: Colors.blue,
                      availableRowsPerPage: const [10,20,50,100],
                
                      showCheckboxColumn: true,
                      // showFirstLastButtons: true,
                       source: licenceDataSource)
                    ),
                ),
              )
              
              
              
              
              
              
              
              
              
              
              
              
              //     SliverGrid.builder(
                
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
              // crossAxisSpacing: 0.w
              // ),
        
              // itemCount: licenceController.filteredFullLicences.length,
              //  itemBuilder: (context,index){
              //   return LicenceItem(licenceController.filteredFullLicences[index], licenceController, context);
              // })
              
              : SliverToBoxAdapter(
                  child:  SizedBox(
                height: 40.h,
                child: const Column(mainAxisAlignment: MainAxisAlignment.center,
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
            ),
        );
      }
    );

  }
 @override
  void dispose() {
    licenceController.currentPage=0;
    // TODO: implement dispose
    super.dispose();
  }
}
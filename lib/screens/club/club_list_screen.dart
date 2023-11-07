import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/club_controller.dart';
import '../../datasources/club_datasource.dart';
import '../../widgets/clubs/club_widgets.dart';

class ClubListScreen extends StatefulWidget{
  const ClubListScreen({super.key});
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
    super.didChangeDependencies();
  }

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    clubController=Provider.of<ClubProvider>(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    dataSource=ClubDataSource(licenceController,context,clubController);
    return Consumer<ClubProvider>(
      builder: (context,clubController,child) {
        return Directionality(
                  textDirection: TextDirection.rtl,

          child: Scaffold(
            drawer: MyDrawer(licenceController, context),
            backgroundColor: const Color(0xfffafafa),
            body: CustomScrollView(
              slivers: [
                MyAppBar("النوادي", context, true,licenceController,false,false),
                SliverToBoxAdapter(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 2.h),
                  ClubListHeader(licenceController,clubController,numControl,context,""),
                ]
                )),
             FutureBuilder(
              future: licenceController.getParameters(),
               builder: (context,snaphot) {
                if(snaphot.connectionState==ConnectionState.done){
                      licenceController.clubChecks=List.generate(licenceController.parameters!.clubs!.length,(index)=>false);
                   return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
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
                      columns: const [ 
                        DataColumn(label: Text(''),),
                        DataColumn(label: Text('الاسم')),                     
                        DataColumn(label: Text('الولاية')),                     
                        DataColumn(label: Text('اجراءات')),
                        ],
                      arrowHeadColor: Colors.blue,
                      availableRowsPerPage: const [10,20,50,100],
                      showCheckboxColumn: true,
                      showFirstLastButtons: true,
                       source: dataSource)
                    ),
                ),
              );
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
               )
                ]
            ),
             floatingActionButton: FloatingActionButton(onPressed: () {
              licenceController.selectedRole=licenceController.parameters!.roles!.firstWhere((element) => element.id==7);
              GoRouter.of(context).push(Routes.AddProfileScreen);
            },
            child: const Icon(Icons.add),
            ),
            ),
        );
      }
    );
  }
}
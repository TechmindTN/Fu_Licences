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
import '../../../models/grade.dart';
import '../../../models/ligue.dart';



class GradeListScreen extends StatefulWidget{
  @override
  State<GradeListScreen> createState() => _GradeListScreenState();
}

class _GradeListScreenState extends State<GradeListScreen> {
  late LicenceProvider licenceController;
    late ParameterProvider paramController;


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
   Grade grade=Grade();
  //  grade.
   //ligue.
    return Consumer<ParameterProvider>(
      builder: (context,clubController,child) {
        return Scaffold(
          drawer: MyDrawer(licenceController, context),
          
          
          backgroundColor: Color(0xfffafafa),
          body: CustomScrollView(
            slivers: [
              MyAppBar("Grade", context, false,licenceController,false,true),
              // SliverToBoxAdapter(child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // children: [
              //   SizedBox(height: 2.h),
              //   ClubListHeader(licenceController,numControl,context),
              // ]
                
              // )),
           SliverToBoxAdapter(
            child: Container(
              height: 4.h,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 256,
              
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Id"),
                      Text("Grade"),
                      Text("Cree le"),
                      Text("Actions")
                  ],
                ),
              ),
            ),
           ),
           FutureBuilder(
            future: licenceController.getParameters(),
             builder: (context,snaphot) {
              if(snaphot.connectionState==ConnectionState.done){
              return  SliverList(

                
                delegate: SliverChildBuilderDelegate(
                  
                 childCount:  licenceController.parameters!.grades!.length,
                  (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:256,
                  vertical: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      Text(licenceController.parameters!.grades![index].id.toString()),
                    Text(licenceController.parameters!.grades![index].grade.toString()),
                    Text(licenceController.parameters!.grades![index].created.toString()),
                    FloatingActionButton(
                      mini: true,
                      onPressed: (){}, child: Icon(Icons.delete))
                    ],
                  ),
                );
               }),);
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
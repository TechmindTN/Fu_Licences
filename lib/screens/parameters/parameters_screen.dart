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

import '../../controllers/club_controller.dart';
import '../../controllers/parameters_controller.dart';
import '../../widgets/clubs/club_widgets.dart';

class ParametersScreen extends StatefulWidget{
  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  late LicenceProvider licenceController;
    late ParameterProvider paramController;

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
    paramController=Provider.of<ParameterProvider>(context,listen: false);
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
              MyAppBar("Parameters", context, true,licenceController,false,false),
              // SliverToBoxAdapter(child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // children: [
              //   SizedBox(height: 2.h),
              //   ClubListHeader(licenceController,numControl,context),
              // ]
                
              // )),
           
           FutureBuilder(
            future: licenceController.getParameters(),
             builder: (context,snaphot) {
              if(snaphot.connectionState==ConnectionState.done){
               return SliverGrid(
                  
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                crossAxisSpacing: 0.w
                ),

                // itemCount: licenceController.parameters!.clubs!.length-1,
                //  itemBuilder: (context,index){
                  
                //   return ClubItem(licenceController.parameters!.clubs![index], licenceController,clubController, context);
                // }, 
                delegate: SliverChildListDelegate(
                  [
                    ParamCard("Ligue", context, licenceController),
                    ParamCard("Categorie", context, licenceController),
                    ParamCard("Grade", context, licenceController),
                    ParamCard("Degree", context, licenceController),
                    ParamCard("Discipline", context, licenceController),
                    ParamCard("Poids", context, licenceController),
                    ParamCard("Saison", context, licenceController),
                    // ParamCard("Ligue", context, licenceController),
                    // ParamCard("Ligue", context, licenceController),
                  ]
               ),);
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
            // GoRouter.of(context).push(Routes.SelectRoleScreen);
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
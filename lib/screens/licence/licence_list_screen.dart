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

class LicenceListScreen extends StatefulWidget{
  @override
  State<LicenceListScreen> createState() => _LicenceListScreenState();
}

class _LicenceListScreenState extends State<LicenceListScreen> {
  late LicenceProvider licenceController;
  TextEditingController numControl=TextEditingController();

  @override
  void didChangeDependencies() {
   
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    licenceController.getLicences();
    licenceController.getParameters();
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
              
              SliverToBoxAdapter(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 2.h),
                LicenceListHeader(licenceController,numControl,context),
                
                
                (licenceController.isLoading)?Center(child: CircularProgressIndicator(),):Column(
                  children: [
                    
                    // for(FullLicence fullLicence in licenceController.fullLicences)
                    // Center(child: LicenceItem(fullLicence,licenceController,context)),
                  ],
                ),
              ],
            ),),
            SliverGrid.builder(
              
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
            crossAxisSpacing: 0.w
            ),

            itemCount: licenceController.fullLicences.length,
             itemBuilder: (context,index){
              return LicenceItem(licenceController.fullLicences[index], licenceController, context);
            }),
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
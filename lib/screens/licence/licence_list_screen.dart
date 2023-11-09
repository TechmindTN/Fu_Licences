import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/global/snackbars.dart';
import 'package:fu_licences/widgets/licence/licence_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LicenceListScreen extends StatefulWidget{
  const LicenceListScreen({super.key});

  @override
  State<LicenceListScreen> createState() => _LicenceListScreenState();
}

class _LicenceListScreenState extends State<LicenceListScreen> {
  late LicenceProvider licenceController;
  TextEditingController numControl=TextEditingController();

  @override
  void didChangeDependencies() {
   
    
    super.didChangeDependencies();
  }

  @override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen: false);
    licenceController.currentPage=0;
    licenceController.getLicences();
    licenceController.getParameters();
    licenceController.initSelected();
    licenceController.initCreate();
    WidgetsBinding.instance.addPostFrameCallback((_) 
      //  Future.delayed(Duration(seconds: 3), () => 
       {
        if(licenceController.added){
      final snackBar=MySnackBar(title: "تمت الاضافة بنجاح",msg: "تمت اضافة الاجازة بنجاح",state: ContentType.success);
      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
      licenceController.added=false;
    }
       
      //  );
    });
    
    
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
        return Directionality(
                textDirection: TextDirection.rtl,

          child: Scaffold(
            drawer: MyDrawer(licenceController, context),
            
            
            backgroundColor: const Color(0xfffafafa),
            body: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              // controller: ScrollController(),
              // primary: false,
              slivers: [
                MyAppBar("الاجازات", context, true,licenceController,false),
                SliverToBoxAdapter(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  SizedBox(height: 2.h),
                  LicenceListHeader(licenceController,numControl,context),
                  
                  
                  
                  ],
                            ),
                ),
        SliverToBoxAdapter(
          child: (licenceController.isLoading)?const Center(child: CircularProgressIndicator(),):NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo){
                      print(scrollInfo.metrics.pixels);
                      if (scrollInfo.metrics.pixels ==
        scrollInfo.metrics.maxScrollExtent) {
          print('end of scroll');
    }
    return true;
                    },
                    child: ListView(
                      // primary: true,
                      shrinkWrap: true,
                      controller: ScrollController(
                        
                      ),
                      // primary: ,
                      children: [
                        for(FullLicence fullLicence in licenceController.fullLicences)
                        Center(child: LicenceItem(fullLicence,licenceController,context)),
                      ],
                    ),
                  ),
          
        ),
              SliverToBoxAdapter(
                child: SizedBox(height: 3.h),
              )
                ]
              
            ),
             floatingActionButton: FloatingActionButton(onPressed: () {
              GoRouter.of(context).push(Routes.SelectRoleScreen);
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
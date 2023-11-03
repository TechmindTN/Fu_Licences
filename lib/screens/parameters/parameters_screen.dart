import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/widgets/global/appbar.dart';
import 'package:fu_licences/widgets/parameter/parameter_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/club_controller.dart';
import '../../controllers/parameters_controller.dart';

class ParametersScreen extends StatefulWidget{
  const ParametersScreen({super.key});

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
                MyAppBar('الاعدادات', context, true,licenceController,false,false),
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
                      ParamCard('الولاية', context, licenceController),
                      ParamCard('العمر', context, licenceController),
                      ParamCard("Grade", context, licenceController),
                      ParamCard("Degree", context, licenceController),
                      ParamCard('الرياضة', context, licenceController),
                      ParamCard('الوزن', context, licenceController),
                      ParamCard('الموسم', context, licenceController),
                      // ParamCard('الولاية', context, licenceController),
                      // ParamCard('الولاية', context, licenceController),
                    ]
                 ),);
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
              // GoRouter.of(context).push(Routes.SelectRoleScreen);
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
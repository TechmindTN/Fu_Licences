// ignore_for_file: file_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/global/inputs.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameControl=TextEditingController();
    TextEditingController psdControl=TextEditingController();
    late LicenceProvider licenceController;
  final _formKey = GlobalKey<FormState>();
@override
  void initState() {
    licenceController=Provider.of<LicenceProvider>(context,listen:false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
              textDirection: TextDirection.rtl,

      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration
          (
            image: DecorationImage(
              image:AssetImage("assets/images/kungfuimage.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.4
              )
          ),
           child:  BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration:  BoxDecoration(color: Colors.white.withOpacity(0.0)),
           child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 10,
                  spreadRadius: 1
                  )],
                  color: Color(0xffd9d9d9),
                  borderRadius:  BorderRadius.all(Radius.circular(2)),
                ),
                child: Center(child: 
                Consumer<LicenceProvider>(
                  builder: (context,licenceController,child) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/images/logo-ftwkf.png"),
                          Text("تسجيل الدخول",
                          style: Theme.of(context).textTheme.displayMedium,
                          ),
                          AuthInput("رقم الهاتف", usernameControl,false),
                          AuthInput("كلمة المرور", psdControl,true),
                          FloatingActionButton.extended(onPressed: (){
                            licenceController.login(context,usernameControl.text,psdControl.text);
                          },
                           label: const Text("تسجيل الدخول",
                           style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                          extendedPadding: const EdgeInsets.symmetric(horizontal: 40),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("ليس لديك حساب؟؟",
                              style: TextStyle(
                                                          fontSize: 16,
                              ),
                              ),
                              InkWell(
                                onTap: () {
                                },
                                child:Text("انشاء حساب",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700
                                ),)
                              ),
                            ],
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("نسيت كلمة المرور؟؟",
                              style: TextStyle(                          fontSize: 16,
                    ),
                              ),
                              InkWell(
                                child:Text("استرجاع كلمة المرور",
                                style: TextStyle(
                                                            fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700
                                ),)
                              ),
                            ],
                          ),   
                        ],
                      ),
                    );
                  }
                )
                ),
              ),
            ),
           ),
            ),
          ),
        ),
      ),
    );
  }
}
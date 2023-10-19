// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/licence_controller.dart';
import '../../router/routes.dart';

Widget ParamCard( param, context,LicenceProvider licenceController) {
    String img="assets/images/logo-ftwkf.png";
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {
            if (param == 'الولاية') {
              GoRouter.of(context).push(Routes.LigueListScreen);
            }
            else if (param== 'العمر') {
              GoRouter.of(context).push(Routes.CategoryListScreen);
            }
             else if (param == "Grade") {
              GoRouter.of(context).push(Routes.GradeListScreen);
            }
            else if (param == "Degree") {
              GoRouter.of(context).push(Routes.DegreeListScreen);
            }
            else if (param == 'الرياضة') {
              GoRouter.of(context).push(Routes.DisciplineListScreen);
            }
            else if (param == 'الوزن') {
              GoRouter.of(context).push(Routes.WeightListScreen);
            }
            else if (param == 'الموسم') {
              GoRouter.of(context).push(Routes.SeasonListScreen);
            }
          }),
          child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xff92DDFF,
        )  ),
              width: 20.w,
              height: 12.h,
              child: Center(child: 
              Image.asset(img,
              width: 12.w,
              )
              )),
        ),
      ),
      Text(param,
         style: const TextStyle(
                fontSize: 18
              ),)
    ],
  );
}
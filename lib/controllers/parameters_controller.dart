import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/models/ligue.dart';
import 'package:fu_licences/network/club_network.dart';

import '../models/category.dart';
import '../models/club.dart';
import '../models/degree.dart';
import '../models/discipline.dart';
import '../models/grade.dart';
import '../models/parameters.dart';
import '../models/season.dart';
import '../models/user.dart';
import '../models/weight.dart';
import '../network/parameter_network.dart';
import '../widgets/global/snackbars.dart';
import 'licence_controller.dart';

class ParameterProvider extends ChangeNotifier{
  bool isLoading=false;
  ParameterNetwork paramNetwork = ParameterNetwork();

  addLigue(String name){
    Ligue ligue=Ligue(name: name);
    paramNetwork.addLigue(ligue.toJson());
  }
  addCategory(String name,int min,int max){
    Category category=Category(categorieAge: name,min: min,max:max );
    paramNetwork.addCategory(category.toJson());
  }
  addDegree(String name){
    Degree degree=Degree(degree: name);
    paramNetwork.addDegree(degree.toJson());
  }
  addGrade(String name){
    Grade grade=Grade(grade: name);
    paramNetwork.addGrade(grade.toJson());
  }
  addWeight(int masse,int min,int max){
    Weight weight=Weight(masseEnKillograme:masse,min: min,max: max );
    paramNetwork.addWeight(weight.toJson());
  }
  addDiscipline(String name,String description){
    Discipline disipline=Discipline(name: name,description: description,);
    paramNetwork.addDiscipline(disipline.toJson());
  }
  addSeason(String name){
    Season season=Season(seasons: name,activated: false);
    paramNetwork.addSeason(season.toJson());
  }
 
}
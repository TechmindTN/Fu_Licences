import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/models/ligue.dart';
import '../models/category.dart';
import '../models/degree.dart';
import '../models/discipline.dart';
import '../models/grade.dart';
import '../models/season.dart';
import '../models/weight.dart';
import '../network/parameter_network.dart';
import '../widgets/global/snackbars.dart';

class ParameterProvider extends ChangeNotifier{
  bool isLoading=false;
  ParameterNetwork paramNetwork = ParameterNetwork();
  List<bool> ligueChecks=[];
  List<bool> categoryChecks=[];
  List<bool> gradeChecks=[];
  List<bool> degreeChecks=[];
  List<bool> disciplineChecks=[];
  List<bool> weightChecks=[];
  List<bool> seasonChecks=[];

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
  
  removeLigue(int id,context) async {
    // Ligue ligue=Ligue(name: name);
    Response res= await paramNetwork.deleteLigue(id);
    if(res.statusCode==204){
       final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La ligue a ete supprimee avec succees',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'La ligue n\'est pas supprimee ',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }
  removeCategory(int id,context) async {
    // Ligue ligue=Ligue(name: name);
    Response res= await paramNetwork.deleteCategory(id);
    if(res.statusCode==204){
       final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La ligue a ete supprimee avec succees',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'La ligue n\'est pas supprimee ',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }
  removeGrade(int id,context) async {
    // Ligue ligue=Ligue(name: name);
    Response res= await paramNetwork.deleteGrade(id);
    if(res.statusCode==204){
       final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La ligue a ete supprimee avec succees',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'La ligue n\'est pas supprimee ',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }
  removeDegree(int id,context) async {
    // Ligue ligue=Ligue(name: name);
    Response res= await paramNetwork.deleteDegree(id);
    if(res.statusCode==204){
       final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La ligue a ete supprimee avec succees',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'La ligue n\'est pas supprimee ',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }
  removeDiscipline(int id,context) async {
    // Ligue ligue=Ligue(name: name);
    Response res= await paramNetwork.deleteDiscipline(id);
    if(res.statusCode==204){
       final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La ligue a ete supprimee avec succees',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'La ligue n\'est pas supprimee ',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }
  removeSeason(int id,context) async {
    // Ligue ligue=Ligue(name: name);
    Response res= await paramNetwork.deleteSeason(id);
    if(res.statusCode==204){
       final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La ligue a ete supprimee avec succees',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'La ligue n\'est pas supprimee ',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }
  removeWeight(int id,context) async {
    // Ligue ligue=Ligue(name: name);
    Response res= await paramNetwork.deleteWeight(id);
    if(res.statusCode==204){
       final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La ligue a ete supprimee avec succees',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'La ligue n\'est pas supprimee ',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
  }

  notify(){
    notifyListeners();
  }
 
}
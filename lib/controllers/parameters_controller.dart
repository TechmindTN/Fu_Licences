import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/models/ligue.dart';
import 'package:fu_licences/network/club_network.dart';

import '../models/club.dart';
import '../models/parameters.dart';
import '../models/user.dart';
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
 // ParameterNetwork clubNetwork=ClubNetwork();
  //late Parameters selectedClub;
  //List<Club>? clubs=[];
 
}
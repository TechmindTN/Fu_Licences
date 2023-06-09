import 'package:dio/dio.dart';

class Apis {



  final Dio dio=Dio(
    
  );
  
  // /pro/
  final String baseUrl="http://192.168.1.131:8000/api/";
  static late String tempToken;
  //  String tempToken="TOKEN 306bf71e724147547708bd7c7c2b0b22c68c94e1e9dc35b14890279113762c4a";
  final String login="login/";
  final String validateLicence="validateLicence/";
  final String licenceListInfo="licencelist_info/";
  final String getParameters="parameters/";
  final String uploadImage="upload_photo/";
  final String addFullLicence="add_full_licence/";
  final String editProfile="profile/";
  final String editAthlete="athlete/";
  final String editLicence="licences/";
  final String editAthleteLicence="edit_athlete_licence/";
  final String editAthleteProfile="edit_athlete_profile/";
  final String editArbitratorProfile="edit_arbitrator_profile/";
  final String editArbitratorLicence="edit_arbitrator_licence/";
  final String editCoachLicence="edit_coach_licence/";
  final String editCoachProfile="edit_coach_profile/";

  final String renewArbitratorLicence="renew_arbitrator_licence/";

  final String renewLicence="renew_licence/";
  final String addClub="add_club/";


  // final String register ="api/register/";
  // final String login="api/login/";
  //   final String roles="api/role/";
  //       final String profile="api/profile/";
  //               final String club="api/club/";
  //               final String athlete="api/athlete/";
  //               final String arbitrator="api/arbitrator/";
  //               final String coach="api/coach/";
  //               final String supporter="api/supporter/";
  //               final String licence="api/licences/";
  //               final String userLicence="api/user_licences/";
  //               final String grade="api/grade/";
  //               final String category="api/categorie/";
  //               final String seasons="api/seasons/";
  //               final String weights="api/weights/";
  //               final String parameters="api/parameters/";

  //               final String userProfile="api/pro/";
                // final String profileDetails="api/profile/";

                // final String athlete="api/athlete/";
                // final String athlete="api/athlete/";
                // final String athlete="api/athlete/";
                // final String athlete="api/athlete/";



  
}


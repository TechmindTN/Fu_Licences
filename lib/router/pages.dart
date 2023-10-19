import 'package:flutter/material.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/athlete/add_athlete/add_athlete_screen.dart';
import 'package:fu_licences/screens/auth/login_Screen.dart';
import 'package:fu_licences/screens/club/club_screen.dart';
import 'package:fu_licences/screens/club/edit_club_screen.dart';
import 'package:fu_licences/screens/home/home_screen.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/screens/licence/addlicence/upload_athlete_images_screen.dart';
import 'package:fu_licences/screens/licence/arbitrator_licence_screen.dart';
import 'package:fu_licences/screens/licence/athlete_licence_screen.dart';
import 'package:fu_licences/screens/licence/coach_licence_screen.dart';
import 'package:fu_licences/screens/licence/edit_licence/athlete/edit_athlete_images_screen.dart';
import 'package:fu_licences/screens/licence/edit_licence/athlete/edit_licence_screen.dart';
import 'package:fu_licences/screens/licence/filtered_licences_list.dart';
import 'package:fu_licences/screens/licence/licence_list_screen%20copy.dart';
import 'package:fu_licences/screens/licence/renew%20licence/arbitre/renew_arbitrator_licence_screen.dart';
import 'package:fu_licences/screens/licence/renew%20licence/athlete/renew_images_screen.dart';
import 'package:fu_licences/screens/licence/renew%20licence/athlete/renew_licence_screen.dart';
import 'package:fu_licences/screens/parameters/ligue/add_ligue_screen.dart';
import 'package:fu_licences/screens/parameters/parameters_screen.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:fu_licences/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import '../screens/arbitre/add_arbitre_screen.dart';
import '../screens/club/add_club_screen.dart';
import '../screens/club/club_list_screen.dart';
import '../screens/coach/add_coach/add_coach_screen.dart';
import '../screens/licence/addlicence/upload_arbitre_images_screen.dart';
import '../screens/licence/addlicence/upload_coach_images_screen.dart';
import '../screens/licence/edit_licence/arbitre/edit_arbitrator_licence_screen.dart';
import '../screens/licence/edit_licence/arbitre/edit_arbitre_images_screen.dart';
import '../screens/licence/edit_licence/coach/edit_coach_images_screen.dart';
import '../screens/licence/edit_licence/coach/edit_coach_licence_screen.dart';
import '../screens/licence/licence_screen.dart';
import '../screens/licence/renew licence/arbitre/renew_arbitrator_images_screen.dart';
import '../screens/licence/renew licence/coach/renew_coach_images_screen.dart';
import '../screens/licence/renew licence/coach/renew_coach_licence_screen.dart';
import '../screens/parameters/category/add_category_screen.dart';
import '../screens/parameters/degree/add_degree_screen.dart';
import '../screens/parameters/discipline/add_discipline_screen.dart';
import '../screens/parameters/grade/add_grade_screen.dart';
import '../screens/parameters/ligue/ligue_list_screen.dart';
import '../screens/parameters/category/category_list_screen.dart';
import '../screens/parameters/degree/degree_list_screen.dart';
import '../screens/parameters/discipline/discipline_list_screen.dart';
import '../screens/parameters/grade/grade_list_screen.dart';
import '../screens/parameters/season/add_season_screen.dart';
import '../screens/parameters/season/season_list_screen.dart';
import '../screens/parameters/weights/add_weight_screen.dart';
import '../screens/parameters/weights/weight_list_screen.dart';

class Pages{
  static late String root;
  final Routes routes=Routes();
  RouterConfig<Object> router=GoRouter(
    initialLocation: Routes.Splash,
    routes: [
      GoRoute(path: Routes.Home,
      builder: (context, state) => HomeScreen(),
      ),
      GoRoute(path: Routes.Splash,
      builder: (context, state) => MySplashScreen(),
      ),
      GoRoute(path: Routes.AddClubScreen,
      builder: (context, state) => AddClubScreen(),
      ),
      GoRoute(path: Routes.ClubListScreen,
      builder: (context, state) => ClubListScreen(),
      ),
            GoRoute(path: Routes.EditClubScreen,
      builder: (context, state) => EditClubScreen(),
      ),
      GoRoute(path: Routes.LicenceListScreen,
      builder: (context, state) => LicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.AthleteLicenceListScreen,
      builder: (context, state) => AthleteLicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.ArbitratorLicenceListScreen,
      builder: (context, state) => ArbitratorLicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.CoachLicenceListScreen,
      builder: (context, state) => CoachLicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.AddAthleteLicenceScreen,
      builder: (context, state) => AddAthleteScreen(),
      ),
      GoRoute(path: Routes.AddProfileScreen,
      builder: (context, state) => AddProfileScreen(),
      ),
      GoRoute(path: Routes.EditAthleteImagesScreen,
      builder: (context, state) => EditAthleteLicenceImages(),
      ),
      GoRoute(path: Routes.EditAthleteLicenceScreen,
      builder: (context, state) => EditAthleteLicenceScreen(),
      ),
       GoRoute(path: Routes.EditArbitratorImagesScreen,
      builder: (context, state) => EditArbitratorLicenceImages(),
      ),
      GoRoute(path: Routes.EditArbitratorLicenceScreen,
      builder: (context, state) => EditArbitratorLicenceScreen(),
      ),
      GoRoute(path: Routes.EditCoachImagesScreen,
      builder: (context, state) => EditCoachLicenceImages(),
      ),
      GoRoute(path: Routes.EditCoachLicenceScreen,
      builder: (context, state) => EditCoachLicenceScreen(),
      ),
      GoRoute(path: Routes.RenewAthleteImages,
      builder: (context, state) => RenewLicenceImages(),
      ),
      GoRoute(path: Routes.RenewAthleteLicenceScreen,
      builder: (context, state) => RenewLicenceScreen(),
      ),
      GoRoute(path: Routes.SelectRoleScreen,
      builder: (context, state) => SelectRoleScreen(),
      ),
      GoRoute(path: Routes.UploadAthleteImagesScreen,
      builder: (context, state) => UploadAthleteLicenceImages(),
      ),
      GoRoute(path: Routes.UploadCoachImagesScreen,
      builder: (context, state) => UploadCoachLicenceImages(),
      ),
      GoRoute(path: Routes.UploadArbitreImagesScreen,
      builder: (context, state) => UploadArbitreLicenceImages(),
      ),
      GoRoute(path: Routes.LicenceScreen,
      builder: (context, state) => LicenceScreen(),
      ),
      GoRoute(path: Routes.FilteredLicencesScreen,
      builder: (context, state) => FilteredLicencesScreen(),
      ),
      GoRoute(path: Routes.AddCoachLicenceScreen,
      builder: (context, state) => AddCoachScreen(),
      ),
      GoRoute(path: Routes.AddArbitreLicenceScreen,
      builder: (context, state) => AddArbitreScreen(),
      ),
      GoRoute(path: Routes.Login,
      builder: (context, state) => LoginScreen(),
      ),
      GoRoute(path: Routes.SelectParameterScreen,
      builder: (context, state) => ParametersScreen(),
      ),
      GoRoute(path: Routes.LigueListScreen,
      builder: (context, state) =>LigueListScreen(),
      ),
      GoRoute(path: Routes.CategoryListScreen,
      builder: (context, state) =>CategoryListScreen(),
      ),
      GoRoute(path: Routes.GradeListScreen,
      builder: (context, state) =>GradeListScreen(),
      ),
      GoRoute(path: Routes.DegreeListScreen,
      builder: (context, state) =>DegreeListScreen(),
      ),
      GoRoute(path: Routes.DisciplineListScreen,
      builder: (context, state) =>DisciplineListScreen(),
      ),
      GoRoute(path: Routes.WeightListScreen,
      builder: (context, state) =>WeightListScreen(),
      ),
      GoRoute(path: Routes.SeasonListScreen,
      builder: (context, state) =>SeasonListScreen(),
      ),
      GoRoute(path: Routes.RenewArbitratorLicenceScreen,
      builder: (context, state) =>RenewArbitratorLicenceScreen(),
      ),
      GoRoute(path: Routes.RenewArbitratorImagesScreen,
      builder: (context, state) =>RenewArbitratorLicenceImages(),
      ),
      GoRoute(path: Routes.RenewCoachImagesScreen,
      builder: (context, state) =>RenewCoachLicenceImages(),
      ),
      GoRoute(path: Routes.RenewCoachLicenceScreen,
      builder: (context, state) =>RenewCoachLicenceScreen(),
      ),
      GoRoute(path: Routes.AddLigueScreen,
      builder: (context, state) =>AddLigueScreen(),
      ),
      GoRoute(path: Routes.AddDegreeScreen,
      builder: (context, state) =>AddDegreeScreen(),
      ),
      GoRoute(path: Routes.AddSeasonScreen,
      builder: (context, state) =>AddSeasonScreen(),
      ),
      GoRoute(path: Routes.AddGradeScreen,
      builder: (context, state) =>AddGradeScreen(),
      ),
      GoRoute(path: Routes.AddCategoryScreen,
      builder: (context, state) =>AddCategoryScreen(),
      ),
      GoRoute(path: Routes.AddDisciplineScreen,
      builder: (context, state) =>AddDisciplineScreen(),
      ),
      GoRoute(path: Routes.AddWeightScreen,
      builder: (context, state) =>AddWeightScreen(),
      ),
      GoRoute(path: Routes.ClubScreen,
      builder: (context, state) =>ClubScreen(),
      ),
  ]);
}
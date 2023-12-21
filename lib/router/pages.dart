import 'package:flutter/material.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/athlete/add_athlete/add_athlete_screen.dart';
import 'package:fu_licences/screens/auth/login_Screen.dart';
import 'package:fu_licences/screens/club/club_screen.dart';
import 'package:fu_licences/screens/club/edit_club_password_screen.dart';
import 'package:fu_licences/screens/club/edit_club_screen.dart';
import 'package:fu_licences/screens/club/edit_password_screen.dart';
import 'package:fu_licences/screens/coach/add_club_coach_licence.dart';
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
      builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(path: Routes.Splash,
      builder: (context, state) => const MySplashScreen(),
      ),
      GoRoute(path: Routes.AddClubScreen,
      builder: (context, state) => const AddClubScreen(),
      ),
      GoRoute(path: Routes.ClubListScreen,
      builder: (context, state) => const ClubListScreen(),
      ),
            GoRoute(path: Routes.EditClubScreen,
      builder: (context, state) => const EditClubScreen(),
      ),
      GoRoute(path: Routes.LicenceListScreen,
      builder: (context, state) => const LicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.AthleteLicenceListScreen,
      builder: (context, state) => const AthleteLicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.ArbitratorLicenceListScreen,
      builder: (context, state) => const ArbitratorLicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.CoachLicenceListScreen,
      builder: (context, state) => const CoachLicenceListScreenCopy(),
      ),
      GoRoute(path: Routes.AddAthleteLicenceScreen,
      builder: (context, state) => const AddAthleteScreen(),
      ),
      GoRoute(path: Routes.AddProfileScreen,
      builder: (context, state) => const AddProfileScreen(),
      ),
      GoRoute(path: Routes.EditAthleteImagesScreen,
      builder: (context, state) => const EditAthleteLicenceImages(),
      ),
      GoRoute(path: Routes.EditAthleteLicenceScreen,
      builder: (context, state) => const EditAthleteLicenceScreen(),
      ),
       GoRoute(path: Routes.EditArbitratorImagesScreen,
      builder: (context, state) => const EditArbitratorLicenceImages(),
      ),
      GoRoute(path: Routes.EditArbitratorLicenceScreen,
      builder: (context, state) => const EditArbitratorLicenceScreen(),
      ),
      GoRoute(path: Routes.EditCoachImagesScreen,
      builder: (context, state) => const EditCoachLicenceImages(),
      ),
      GoRoute(path: Routes.EditCoachLicenceScreen,
      builder: (context, state) => const EditCoachLicenceScreen(),
      ),
      GoRoute(path: Routes.RenewAthleteImages,
      builder: (context, state) => const RenewLicenceImages(),
      ),
      GoRoute(path: Routes.RenewAthleteLicenceScreen,
      builder: (context, state) => const RenewLicenceScreen(),
      ),
      GoRoute(path: Routes.SelectRoleScreen,
      builder: (context, state) => const SelectRoleScreen(),
      ),
      GoRoute(path: Routes.UploadAthleteImagesScreen,
      builder: (context, state) => const UploadAthleteLicenceImages(),
      ),
      GoRoute(path: Routes.UploadCoachImagesScreen,
      builder: (context, state) => const UploadCoachLicenceImages(),
      ),
      GoRoute(path: Routes.UploadArbitreImagesScreen,
      builder: (context, state) => const UploadArbitreLicenceImages(),
      ),
      GoRoute(path: Routes.LicenceScreen,
      builder: (context, state) => const LicenceScreen(),
      ),
      GoRoute(path: Routes.FilteredLicencesScreen,
      builder: (context, state) => const FilteredLicencesScreen(),
      ),
      GoRoute(path: Routes.AddCoachLicenceScreen,
      builder: (context, state) => const AddCoachScreen(),
      ),
      GoRoute(path: Routes.AddClubCoachLicence,
      builder: (context, state) => AddClubCoachLicenceScreen(),
      ),
      GoRoute(path: Routes.AddArbitreLicenceScreen,
      builder: (context, state) => const AddArbitreScreen(),
      ),
      GoRoute(path: Routes.Login,
      builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(path: Routes.SelectParameterScreen,
      builder: (context, state) => const ParametersScreen(),
      ),
      GoRoute(path: Routes.LigueListScreen,
      builder: (context, state) =>const LigueListScreen(),
      ),
      GoRoute(path: Routes.CategoryListScreen,
      builder: (context, state) =>const CategoryListScreen(),
      ),
      GoRoute(path: Routes.GradeListScreen,
      builder: (context, state) =>const GradeListScreen(),
      ),
      GoRoute(path: Routes.DegreeListScreen,
      builder: (context, state) =>const DegreeListScreen(),
      ),
      GoRoute(path: Routes.DisciplineListScreen,
      builder: (context, state) =>const DisciplineListScreen(),
      ),
      GoRoute(path: Routes.WeightListScreen,
      builder: (context, state) =>const WeightListScreen(),
      ),
      GoRoute(path: Routes.SeasonListScreen,
      builder: (context, state) =>const SeasonListScreen(),
      ),
      GoRoute(path: Routes.RenewArbitratorLicenceScreen,
      builder: (context, state) =>const RenewArbitratorLicenceScreen(),
      ),
      GoRoute(path: Routes.RenewArbitratorImagesScreen,
      builder: (context, state) =>const RenewArbitratorLicenceImages(),
      ),
      GoRoute(path: Routes.RenewCoachImagesScreen,
      builder: (context, state) =>const RenewCoachLicenceImages(),
      ),
      GoRoute(path: Routes.RenewCoachLicenceScreen,
      builder: (context, state) =>const RenewCoachLicenceScreen(),
      ),
      GoRoute(path: Routes.AddLigueScreen,
      builder: (context, state) =>const AddLigueScreen(),
      ),
      GoRoute(path: Routes.AddDegreeScreen,
      builder: (context, state) =>const AddDegreeScreen(),
      ),
      GoRoute(path: Routes.AddSeasonScreen,
      builder: (context, state) =>const AddSeasonScreen(),
      ),
      GoRoute(path: Routes.AddGradeScreen,
      builder: (context, state) =>const AddGradeScreen(),
      ),
      GoRoute(path: Routes.AddCategoryScreen,
      builder: (context, state) =>const AddCategoryScreen(),
      ),
      GoRoute(path: Routes.AddDisciplineScreen,
      builder: (context, state) =>const AddDisciplineScreen(),
      ),
      GoRoute(path: Routes.AddWeightScreen,
      builder: (context, state) =>const AddWeightScreen(),
      ),
      GoRoute(path: Routes.ClubScreen,
      builder: (context, state) =>const ClubScreen(),
      ),
      GoRoute(path: Routes.ChangeClubPassword,
      builder: (context, state) =>const EditClubPasswordScreen(),
      ),
      GoRoute(path: Routes.ChangePassword,
      builder: (context, state) =>const EditPasswordScreen(),
      ),
  ]);
}
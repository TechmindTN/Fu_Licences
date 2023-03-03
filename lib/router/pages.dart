import 'package:flutter/material.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/athlete/add_athlete/add_athlete_screen.dart';
import 'package:fu_licences/screens/home/bottom_bar.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/screens/licence/addlicence/upload_athlete_images_screen.dart';
import 'package:fu_licences/screens/licence/edit%20licence/edit_images_screen.dart';
import 'package:fu_licences/screens/licence/edit%20licence/edit_licence_screen.dart';
import 'package:fu_licences/screens/licence/filtered_licences_list.dart';
import 'package:fu_licences/screens/licence/licence_list_screen.dart';
import 'package:fu_licences/screens/licence/renew%20licence/renew_images_screen.dart';
import 'package:fu_licences/screens/licence/renew%20licence/renew_licence_screen.dart';
import 'package:fu_licences/screens/profile/add_profile/add_profile_screen.dart';
import 'package:go_router/go_router.dart';

import '../screens/coach/add_coach/add_coach_screen.dart';
import '../screens/licence/addlicence/upload_coach_images_screen.dart';
import '../screens/licence/licence_screen.dart';

class Pages{
  final Routes routes=Routes();
  RouterConfig<Object> router=GoRouter(
    initialLocation: Routes.Home,
    routes: [
      GoRoute(path: Routes.Home,
      builder: (context, state) => BottomBarScreen(),
      ),
      GoRoute(path: Routes.LicenceListScreen,
      builder: (context, state) => LicenceListScreen(),
      ),
      GoRoute(path: Routes.LicenceListScreen,
      builder: (context, state) => LicenceListScreen(),
      ),
      GoRoute(path: Routes.AddAthleteLicenceScreen,
      builder: (context, state) => AddAthleteScreen(),
      ),
      GoRoute(path: Routes.AddProfileScreen,
      builder: (context, state) => AddProfileScreen(),
      ),
      GoRoute(path: Routes.EditAthleteImagesScreen,
      builder: (context, state) => EditLicenceImages(),
      ),
      GoRoute(path: Routes.EditAthleteLicenceScreen,
      builder: (context, state) => EditLicenceScreen(),
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
      GoRoute(path: Routes.LicenceScreen,
      builder: (context, state) => LicenceScreen(),
      ),
      GoRoute(path: Routes.FilteredLicencesScreen,
      builder: (context, state) => FilteredLicencesScreen(),
      ),
      GoRoute(path: Routes.AddCoachLicenceScreen,
      builder: (context, state) => AddCoachScreen(),
      ),
      // GoRoute(path: Routes.LicenceScreen,
      // builder: (context, state) => LicenceScreen(),
      // ),
  ]);
}
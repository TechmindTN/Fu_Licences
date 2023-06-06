import 'package:flutter/material.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/home/home_screen.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/screens/licence/licence_list_screen.dart';
import 'package:fu_licences/screens/parameters/parameters_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomBarScreen extends StatefulWidget{
  final int currentIndex;

  const BottomBarScreen({super.key, required this.currentIndex});
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState(currentIndex);
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final int currentIndex;
  late PersistentTabController _controller;

  _BottomBarScreenState(this.currentIndex);
  
List<Widget> _buildScreens() => [
        ParametersScreen(),
        
        HomeScreen(
         
        ),
        LicenceListScreen(
        
        ),
       
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: "Parametres",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(

            // initialRoute: "/",
            // routes: {
            //   "/first": (final context) =>  LicenceListScreen(),
            //   "/second": (final context) =>  SelectRoleScreen(),
            // },
          ),
        ),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: "Acceuil",
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt),
          title: "Licences",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
         
          ),
        ),
      
      ];


@override
  void initState() {
    _controller = PersistentTabController(initialIndex: currentIndex);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
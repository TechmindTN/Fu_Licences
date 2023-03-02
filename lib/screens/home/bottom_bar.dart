import 'package:flutter/material.dart';
import 'package:fu_licences/router/routes.dart';
import 'package:fu_licences/screens/home/home_screen.dart';
import 'package:fu_licences/screens/licence/addlicence/select_role_screen.dart';
import 'package:fu_licences/screens/licence/licence_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomBarScreen extends StatefulWidget{
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late PersistentTabController _controller;
  
List<Widget> _buildScreens() => [
        LicenceListScreen(
          // menuScreenContext: widget.menuScreenContext,
          // hideStatus: _hideNavBar,
          // onScreenHideButtonPressed: () {
          //   setState(() {
          //     _hideNavBar = !_hideNavBar;
          //   });
          // },
        ),
        HomeScreen(
          // menuScreenContext: widget.menuScreenContext,
          // hideStatus: _hideNavBar,
          // onScreenHideButtonPressed: () {
          //   setState(() {
          //     _hideNavBar = !_hideNavBar;
          //   });
          // },
        ),
        LicenceListScreen(
          // menuScreenContext: widget.menuScreenContext,
          // hideStatus: _hideNavBar,
          // onScreenHideButtonPressed: () {
          //   setState(() {
          //     _hideNavBar = !_hideNavBar;
          //   });
          // },
        ),
        // LicenceListScreen(
        //   // menuScreenContext: widget.menuScreenContext,
        //   // hideStatus: _hideNavBar,
        //   // onScreenHideButtonPressed: () {
        //   //   setState(() {
        //   //     _hideNavBar = !_hideNavBar;
        //   //   });
        //   // },
        // ),
        // LicenceListScreen(
        //   // menuScreenContext: widget.menuScreenContext,
        //   // hideStatus: _hideNavBar,
        //   // onScreenHideButtonPressed: () {
        //   //   setState(() {
        //   //     _hideNavBar = !_hideNavBar;
        //   //   });
        //   // },
        // ),
        // MainScreen(
        //   menuScreenContext: widget.menuScreenContext,
        //   hideStatus: _hideNavBar,
        //   onScreenHideButtonPressed: () {
        //     setState(() {
        //       _hideNavBar = !_hideNavBar;
        //     });
        //   },
        // ),
        // MainScreen(
        //   menuScreenContext: widget.menuScreenContext,
        //   hideStatus: _hideNavBar,
        //   onScreenHideButtonPressed: () {
        //     setState(() {
        //       _hideNavBar = !_hideNavBar;
        //     });
        //   },
        // ),
        // MainScreen(
        //   menuScreenContext: widget.menuScreenContext,
        //   hideStatus: _hideNavBar,
        //   onScreenHideButtonPressed: () {
        //     setState(() {
        //       _hideNavBar = !_hideNavBar;
        //     });
        //   },
        // ),
        // MainScreen(
        //   menuScreenContext: widget.menuScreenContext,
        //   hideStatus: _hideNavBar,
        //   onScreenHideButtonPressed: () {
        //     setState(() {
        //       _hideNavBar = !_hideNavBar;
        //     });
        //   },
        // ),
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
            // initialRoute: "/",
            // routes: {
            //  "/first": (final context) =>  LicenceListScreen(),
            //   "/second": (final context) =>  SelectRoleScreen(),
            // },
          ),
        ),
        // PersistentBottomNavBarItem(
        //   icon: const Icon(Icons.message),
        //   title: "Messages",
        //   activeColorPrimary: Colors.deepOrange,
        //   inactiveColorPrimary: Colors.grey,
        //   routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //     initialRoute: "/",
        //     routes: {
        //     "/first": (final context) =>  LicenceListScreen(),
        //       "/second": (final context) =>  SelectRoleScreen(),
        //     },
        //   ),
        // ),
        // PersistentBottomNavBarItem(
        //   icon: const Icon(Icons.settings),
        //   title: "Settings",
        //   activeColorPrimary: Colors.indigo,
        //   inactiveColorPrimary: Colors.grey,
        //   routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //     initialRoute: "/",
        //     routes: {
        //      "/first": (final context) =>  LicenceListScreen(),
        //       "/second": (final context) =>  SelectRoleScreen(),
        //     },
        //   ),
        // ),
      ];


@override
  void initState() {
    _controller = PersistentTabController(initialIndex: 1);
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
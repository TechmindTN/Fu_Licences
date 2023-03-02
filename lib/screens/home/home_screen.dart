import 'package:flutter/material.dart';
import 'package:fu_licences/widgets/global/appbar.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
      ),
      body: CustomScrollView(
        slivers: [
          MyAppBar("Fu Licences",context),
          // HomeCorps
          SliverToBoxAdapter()

        ],
        // child: Container(child: Center(
        //   child: Text("Home Screen"),
        // )),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
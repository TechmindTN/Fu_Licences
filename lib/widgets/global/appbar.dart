import 'package:flutter/material.dart';

Widget MyAppBar(title,context){
  return SliverAppBar(
    
    leading: IconButton(icon:Icon(Icons.short_text_rounded),
    onPressed: ( ){
      Scaffold.of(context).openDrawer();
    },
    color: Colors.black,
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    title: Text(title,
    style: TextStyle(color: Colors.black),
    ),
  );
}
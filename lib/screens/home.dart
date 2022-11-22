import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:persistences_types/components/list_home_item.dart';
import 'package:persistences_types/utils/customWidgets.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  final title = const Text("Flutter - Persistência");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: ListView(children: [
          const ListHomeItem(
            path: "images/sqlite-icon.svg", 
            title: "SQLite", 
            subtitle: "Lista de pessoas", 
            route: "/person"),
          divisorList(),
          const ListHomeItem(
            path: "images/db.svg", 
            title: "Floor", 
            subtitle: "Lista de livros", 
            route: "/books"),
          divisorList(),
          const ListHomeItem(
            path: "images/firebase.svg", 
            title: "Firebase", 
            subtitle: "Lista de carros", 
            route: "/cars"),
          divisorList(),
      ]),
    );
  }
}
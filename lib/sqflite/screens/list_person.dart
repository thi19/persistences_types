import 'package:flutter/material.dart';
import 'package:persistences_types/sqflite/daos/person_dao.dart';
import 'package:persistences_types/sqflite/models/person.dart';
import 'package:persistences_types/sqflite/screens/add_person.dart';
import 'package:persistences_types/utils/customStyles.dart';
import 'package:persistences_types/utils/customWidgets.dart';

class ListPersonWidget extends StatefulWidget {
  const ListPersonWidget({super.key});

  @override
  State<ListPersonWidget> createState() => _ListPersonWidgetState();
}

class _ListPersonWidgetState extends State<ListPersonWidget> {
  final title = const Text("Pessoas");
  final addRoute = const AddPersonWidget();

  List<Person> persons = [];

  @override
  void initState(){
    super.initState();
    getAllPersons();
  }

  getAllPersons() async{
    List<Person> result = await PersonDAO().readAll();
    setState(() {
      persons = result;
    });
  }

  deletePersonById(int id) async{
    await PersonDAO().deletePerson(id);
    getAllPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title, actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addRoute))
                  .then((person) => getAllPersons());
            },
            icon: addIcon)
      ]),
      body: ListView.separated(
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => divisorList(),
          itemCount: persons.length),
    );
  }

  Widget _buildItem(int index) {
    Person person = persons[index];
    return Padding(
      padding: cardPadding,
      child: Container(
          decoration: cardBoxStyle(),
          child: ListTile(
            leading: Text(person.id.toString()),
            title: Text(person.firstName),
            subtitle: Text(person.lastName),
            onLongPress: () {
              deletePersonById(person.id!);
            },
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:persistences_types/components/input_form.dart';
import 'package:persistences_types/sqflite/daos/person_dao.dart';
import 'package:persistences_types/sqflite/models/person.dart';
import 'package:persistences_types/utils/customStyles.dart';
import 'package:persistences_types/utils/customWidgets.dart';

class AddPersonWidget extends StatefulWidget {
  const AddPersonWidget({super.key});

  @override
  State<AddPersonWidget> createState() => _AddPersonWidgetState();
}

class _AddPersonWidgetState extends State<AddPersonWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();

  insertPerson(Person person) async{
    int id = await PersonDAO().insertPerson(person);
    setState(() {
      person.id = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Nova Pessoa")),
        body: Padding(
            padding: cardPadding,
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputForm(
                          hint: "Nome",
                          label: "Nome",
                          validationMsg: "Insira o nome da pessoa",
                          controller: _nameController),
                      InputForm(
                          hint: "Sobrenome",
                          label: "Sobrenome",
                          validationMsg: "Insira o sobrenome da pessoa",
                          controller: _lastNameController),
                      Padding(
                          padding: cardPadding,
                          child: ElevatedButton(
                              onPressed: ((){
                                if (_formKey.currentState!.validate()) {
                                  Person person = Person(
                                    _nameController.text, 
                                    _lastNameController.text);
                                  insertPerson(person);
                                  Navigator.pop(context);
                                }
                              }),
                              child: salvarText))
                    ]))));
  }
}

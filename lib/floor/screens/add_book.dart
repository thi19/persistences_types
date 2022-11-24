import 'package:flutter/material.dart';
import 'package:persistences_types/components/input_form.dart';
import 'package:persistences_types/floor/database/appDatabase.dart';
import 'package:persistences_types/floor/models/book.dart';
import 'package:persistences_types/utils/customStyles.dart';
import 'package:persistences_types/utils/customWidgets.dart';

class AddBookWidget extends StatefulWidget {
  const AddBookWidget({super.key});

  @override
  State<AddBookWidget> createState() => _AddBookWidgetState();
}

class _AddBookWidgetState extends State<AddBookWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  insertBook(Book book) async {
    final database = await $FloorAppDatabase
        .databaseBuilder("book_floor_database.db")
        .build();

    await database.bookDAO.insertBook(book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Novo livro")),
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
                          validationMsg: "Insira o nome do livro",
                          controller: _nameController),
                      InputForm(
                          hint: "Descrição",
                          label: "Descrição",
                          validationMsg: "Insira a descrição do livro",
                          controller: _descriptionController),
                      Padding(
                          padding: cardPadding,
                          child: ElevatedButton(
                              onPressed: (() {
                                if (_formKey.currentState!.validate()) {
                                  final book = Book(_nameController.text,
                                      _descriptionController.text);
                                  insertBook(book);
                                  Navigator.pop(context);
                                }
                              }),
                              child: salvarText))
                    ]))));
  }
}

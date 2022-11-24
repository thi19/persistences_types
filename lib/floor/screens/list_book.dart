import 'package:flutter/material.dart';
import 'package:persistences_types/floor/daos/book_dao.dart';
import 'package:persistences_types/floor/database/appDatabase.dart';
import 'package:persistences_types/floor/models/book.dart';
import 'package:persistences_types/floor/screens/add_book.dart';
import 'package:persistences_types/utils/customStyles.dart';
import 'package:persistences_types/utils/customWidgets.dart';

class ListBookWidget extends StatefulWidget {
  const ListBookWidget({super.key});

  @override
  State<ListBookWidget> createState() => _ListBookWidgetState();
}

class _ListBookWidgetState extends State<ListBookWidget> {
  final title = const Text("Livros");
  final addRoute = const AddBookWidget();

  BookDAO? dao;
  List<Book> books = [];

  @override
  void initState(){
    super.initState();
    getAllBooks();
  }

  getAllBooks() async {
    final database = await $FloorAppDatabase
      .databaseBuilder("book_floor_database.db")
      .build();

    dao = database.bookDAO;
    if(dao != null){
      final result = await dao!.findAll();
      if(result.isNotEmpty){
        setState(() {
          books = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title, actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => addRoute));
            },
            icon: addIcon)
      ]),
      body: ListView.separated(
          itemBuilder: (context, index) => _buildItem(index),
          separatorBuilder: (context, index) => divisorList(),
          itemCount: books.length),
    );
  }

  Widget _buildItem(int index) {
    Book book = books[index];
    return Padding(
      padding: cardPadding,
      child: Container(
          decoration: cardBoxStyle(),
          child: ListTile(
            leading: Text(book.id.toString()),
            title: Text(book.name),
            subtitle: Text(book.description),
            onLongPress: () {
              //delete
            },
          )),
    );
  }
}

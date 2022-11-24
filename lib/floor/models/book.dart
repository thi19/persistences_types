import 'package:floor/floor.dart';

@entity
class Book {
  @primaryKey
  int? id;
  String name;
  String description;

  Book(this.name, this.description, {this.id});
}
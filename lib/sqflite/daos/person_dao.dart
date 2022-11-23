
import 'package:path/path.dart';
import 'package:persistences_types/sqflite/models/person.dart';
import 'package:sqflite/sqflite.dart';

class PersonDAO {

  Future<Database> getDatabase() async {
    Database db = await openDatabase(
      join(await getDatabasesPath(), 'person_database.db'),
      onCreate: ((db, version) {
        return db.execute("CREATE TABLE Person(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT)");
      }),
      version: 1);

    return db;
  }

  Future<List<Person>> readAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query("Person");

    final result = List.generate(maps.length, (index){
      return Person(maps[index]['firstName'], maps[index]['lastName'], id: maps[index]['id']);
    });

    return result;
  }

  Future<int> insertPerson(Person person) async {
    final db = await getDatabase();
    return db.insert("Person", person.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deletePerson(int id) async {
    final db = await getDatabase();
    return db.delete("Person", where: ' id = ? ', whereArgs: [id]);
  }
}
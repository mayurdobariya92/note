import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:note/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class one extends StatefulWidget {
  const one({Key? key}) : super(key: key);

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  Database? database;
  List list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    creatdb();
  }

  creatdb()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    print(path);

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, content TEXT)');
    });
    list = await database!.rawQuery("select * from Test");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super notes"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          Map m = list[index];
          return OpenContainer(
            closedBuilder: (context, action) {
              return ListTile(
                title: Text("${m['title']}"),
                subtitle: Text("${m['content']}"),
              );
            },
            openBuilder: (context, action) {
              return note(database!, "update", m);
            },
            transitionDuration: Duration(seconds: 1),
          );
        },
      ),
      floatingActionButton: OpenContainer(
        closedBuilder: (context, action) {
          return FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add),
          );
        },
        openBuilder: (context, action) {
          return note(database!, "insert");
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarks extends StatelessWidget {
  getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .map<Widget>((key) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image.network(prefs.get(key).toString()),
            ))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bookmarks', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getAllPrefs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data,
                  );
                }
                return Container();
              }),
        ));
  }
}

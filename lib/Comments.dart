import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  final List commentsList;

  Comments({ this.commentsList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Comments', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: this.commentsList.length,
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                List data = this.commentsList;
                return Row(
                  children: [
                    Text(data[i]['username'],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    SizedBox(width: 6.0),
                    Text(data[i]['comments']),
                  ],
                );
              }),
        ));
  }
}

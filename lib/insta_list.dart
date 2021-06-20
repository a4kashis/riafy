import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:riafy/Comments.dart';
import 'package:riafy/services/getData.dart';
import 'package:riafy/services/shredPref.dart';

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  bool isPressed = false;
  List bookMarkList = [];
  Future data;

  @override
  void initState() {
    data = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: data,
      builder: (ctx, AsyncSnapshot snap) {
        if (snap.hasData) {
          var data = snap.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: new NetworkImage(
                                        data[index]['low thumbnail'])),
                              ),
                            ),
                            new SizedBox(
                              width: 10.0,
                            ),
                            new Text(
                              data[index]['channelname'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        new IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: null,
                        )
                      ],
                    ),
                  ),
                  // "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",

                  Flexible(
                    fit: FlexFit.loose,
                    child: new Image.network(
                      data[index]['high thumbnail'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new IconButton(
                              icon: new Icon(isPressed
                                  ? Icons.favorite
                                  : FontAwesomeIcons.heart),
                              color: isPressed ? Colors.red : Colors.black,
                              onPressed: () {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                              },
                            ),
                            new SizedBox(width: 10.0),
                            new Icon(FontAwesomeIcons.comment),
                            new SizedBox(width: 20.0),
                            new Icon(FontAwesomeIcons.paperPlane),
                          ],
                        ),
                        new IconButton(
                          icon: Icon(
                            bookMarkList.contains(data[index]['id'])
                                ? FontAwesomeIcons.solidBookmark
                                : FontAwesomeIcons.bookmark,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            String key = data[index]['id'].toString();
                            String value =
                                data[index]['high thumbnail'].toString();

                            bookMarkList.add(data[index]['id']);
                            print(await SharedPref().checkKey(key));
                            if (await SharedPref().checkKey(key)) {
                              SharedPref().delete(key);
                            } else {
                              SharedPref().set(key: key, value: value);
                            }
                            setState(() {});
                            print(bookMarkList.length);
                          },
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        imageProfile,
                        RichText(
                          text: TextSpan(
                            text: "Liked by  ",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'neeharika_boda',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' and ',
                                  style: DefaultTextStyle.of(context).style),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 16.0, vertical: 4.0),
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: data[index]['channelname'],
                  //       style: TextStyle(
                  //           color: Colors.black, fontWeight: FontWeight.bold),
                  //       children: [
                  //         TextSpan(
                  //             text: ' ${data[index]['title']}',
                  //             style: DefaultTextStyle.of(context).style),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: Wrap(
                      children: [
                        Text(data[index]['channelname'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        ReadMoreText(
                          data[index]['title'],
                          style: TextStyle(color: Colors.black),
                          // trimLines: 1,
                          trimLines: 1,
                          trimLength: 10,
                          colorClickableText: Colors.black,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'more',
                          trimExpandedText: '',
                          moreStyle: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4.0),
                    child: FutureBuilder(
                      future: getComments(),
                      builder: (ctx, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    createRoute(
                                        Comments(commentsList: snapshot.data))),
                                child: Text(
                                  snapshot.data.length == 0 ||
                                          snapshot.data == null
                                      ? 'No comments'
                                      : 'View All Comments',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          );
                        } else
                          return Container();
                      },
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       new Container(
                  //         height: 40.0,
                  //         width: 40.0,
                  //         decoration: new BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           image: new DecorationImage(
                  //               fit: BoxFit.fill,
                  //               image: new NetworkImage(
                  //                   data[index]['low thumbnail'])),
                  //         ),
                  //       ),
                  //       new SizedBox(width: 10.0),
                  //       Expanded(
                  //         child: new TextField(
                  //           decoration: new InputDecoration(
                  //             border: InputBorder.none,
                  //             hintText: "Add a comment...",
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  //   child:
                  //       Text("1 Day Ago", style: TextStyle(color: Colors.grey)),
                  // )
                ],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Route createRoute(var page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget imageProfile = Container(
  padding: const EdgeInsets.all(8.0),
  height: 50.0,
  width: 100.0,
  // alignment: FractionalOffset.center,
  child: new Stack(
    //alignment:new Alignment(x, y)
    children: <Widget>[
      new Image.asset('assets/images/p1.png',height: 30,width: 30,),
      new Positioned(
        left: 20.0,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: new Image.asset('assets/images/p2.png',height: 30,width: 30,)),
      ),
      new Positioned(
        left: 40.0,
        child: new Image.asset('assets/images/p1.png',height: 30,width: 30,),
      )
    ],
  ),
);

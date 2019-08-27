import 'package:flutter/material.dart';
import 'package:bossword/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:bossword/screens/add_password.dart';
import 'package:bossword/screens/boss_login.dart';

class AllPasswords extends StatefulWidget {
  static const routeName = 'AllPasswords';

  @override
  _AllPasswordsState createState() => _AllPasswordsState();
}

class _AllPasswordsState extends State<AllPasswords> {
  final _fireStore = Firestore.instance;
  var dbCredential;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Saved Passwords',
            style: kInputBoxStyle,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Confirm signout Boss ?'),
                      contentPadding: EdgeInsets.all(12.0),
                      contentTextStyle: kInputBoxStyle,
                      actions: <Widget>[
                        RaisedButton(
                          child: Text(
                            'Yeah',
                            style: kInputBoxStyle.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () async {
                            await auth.signOut();
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              BossLogin.routeName,
                              ModalRoute.withName(BossLogin.routeName),
                            );
                          },
                          color: kInputBoxColor,
                        ),
                      ],
                      backgroundColor: kRedColor,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  },
                );
              },
            ),
          ],
          titleSpacing: 2.5,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: kRedColor,
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection('passwords').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: kInputBoxColor,
                  ),
                );
              }
              dbCredential = snapshot.data.documents;
              return ListView.builder(
                itemCount: dbCredential.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://www.google.com/search?biw=1536&bih=706&tbm=isch&sa=1&ei=DiVkXcSbEozcz7sPu-CE2AI&q=knowledge&oq=knowledge&gs_l=img.3..35i39j0i67l2j0l7.3864.5726..6255...0.0..0.84.403.5......0....1..gws-wiz-img.ZcU9XSbcIEQ&ved=0ahUKEwjE2rWzlaHkAhUM7nMBHTswASsQ4dUDCAY&uact=5#imgrc=_'),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${dbCredential[index].data['website']}',
                              style: kInputBoxStyle.copyWith(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Username : ${dbCredential[index].data['username']}',
                              style: kInputBoxStyle.copyWith(
                                color: Colors.blueGrey.shade100,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              'Password : ${dbCredential[index].data['password']}',
                              style: kInputBoxStyle.copyWith(
                                color: Colors.blueGrey.shade100,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('Are you sure Boss? You can\'t get it back'),
                                  contentPadding: EdgeInsets.all(12.0),
                                  contentTextStyle: kInputBoxStyle,
                                  actions: <Widget>[
                                    RaisedButton(
                                      child: Text(
                                        'Do as I say',
                                        style: kInputBoxStyle.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text('Boss I\m asking again. Please confirm'),
                                              contentPadding: EdgeInsets.all(12.0),
                                              contentTextStyle: kInputBoxStyle,
                                              actions: <Widget>[
                                                RaisedButton(
                                                  child: Text(
                                                    'Do it',
                                                    style: kInputBoxStyle.copyWith(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    setState(() {
                                                      showSpinner = true;
                                                    });
                                                    await Firestore.instance
                                                        .collection('passwords')
                                                        .document(
                                                        snapshot.data.documents[index].documentID)
                                                        .delete()
                                                        .catchError((e) {
                                                      setState(() {
                                                        showSpinner = false;
                                                      });
                                                      print(e);
                                                    });
                                                    setState(() {
                                                      showSpinner = false;
                                                    });
                                                    Navigator.pushNamedAndRemoveUntil(context, AllPasswords.routeName, ModalRoute.withName(AllPasswords.routeName));
                                                  },
                                                  color: kInputBoxColor,
                                                ),
                                                RaisedButton(
                                                  child: Text(
                                                    'Ok, don\'t',
                                                    style: kInputBoxStyle.copyWith(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  color: kInputBoxColor,
                                                ),
                                              ],
                                              backgroundColor: kRedColor,
                                              elevation: 6.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      color: kInputBoxColor,
                                    ),
                                    RaisedButton(
                                      child: Text(
                                        'Don\'t',
                                        style: kInputBoxStyle.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      color: kInputBoxColor,
                                    ),
                                  ],
                                  backgroundColor: kRedColor,
                                  elevation: 6.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete_outline),
                          iconSize: 26.0,
                        ),
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddPassword.routeName);
          },
          child: Icon(Icons.add),
          backgroundColor: kRedColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

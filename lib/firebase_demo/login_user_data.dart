import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  _LoginUserScreenState createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {

  ///Login_Data
  ///1... UserModel
  ///2..login_user_data_gives_in_current_user_also
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.navigate_before),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainA,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user!.photoURL!),
                radius: 70,
              ),
             const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    boxShadow:const [BoxShadow(color: Colors.grey,blurRadius: 12,spreadRadius: 1.5)],
                   // color: const Color(0xFF81d7ff),
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _RowData(
                        data: auth.currentUser!.email,
                        title: "Email: ",
                      ),
                      _RowData(
                        data: widget.user!.displayName,
                        title: "DisplayName: ",
                      ),
                      _RowData(
                        data: widget.user!.uid,
                        title: "Uid: ",
                      ),
                      _RowData(
                        data: widget.user!.emailVerified.toString(),
                        title: "EmailVerified: ",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RowData extends StatelessWidget {
  const _RowData({
    Key? key,
    this.title,
    this.data,
  }) : super(key: key);

  final String? title;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(data!),
      ],
    );
  }
}

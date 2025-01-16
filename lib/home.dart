import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_companion/variables.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getPersonData(context: context);
  }

  void getPersonData({required BuildContext context}) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('userProfile')
        .doc(uid)
        .get();

    Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

    if (!context.mounted) return;
    Provider.of<UserProfile>(context, listen: false).personName = data['name'];
    Provider.of<UserProfile>(context, listen: false).personEmail =
        data['email'];
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserProfile>(context);
    final screenSize = Provider.of<ScreenSize>(context);
    double paddingHorizontal = screenSize.screenWidth * 0.05;
    double paddingTop = screenSize.screenHeight * 0.15;
    double spaceBetweenFields = screenSize.screenHeight * 0.03;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: paddingHorizontal,
              right: paddingHorizontal,
              top: paddingTop),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userProfile.personEmail),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hello ${userProfile.personName}"),
                ],
              ),
              SizedBox(
                height: spaceBetweenFields,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        Auth().logout(context: context);
                      },
                      child: const Text("Log Out"))
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'View Places',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: 1,
      ),
    );
  }
}

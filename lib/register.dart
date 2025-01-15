import 'package:flutter/material.dart';
import 'package:travel_companion/auth.dart';
import 'package:travel_companion/login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double paddingHorizontal = screenWidth * 0.05;
    double paddingTop = screenHeight * 0.15;
    double inputWidth = 200, inputHeight = 50;
    double spaceBetweenFields = 10;

    TextEditingController _inputFromEmail = TextEditingController();
    TextEditingController _inputFromPassword = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: paddingHorizontal, right: paddingHorizontal, top: paddingTop),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(
              height: spaceBetweenFields,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: inputWidth,
                  height: inputHeight,
                  child: TextField(
                    controller: _inputFromEmail,
                    decoration: const InputDecoration(
                      labelText: ("Email"),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: spaceBetweenFields,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: inputWidth,
                  height: inputHeight,
                  child: TextField(
                    controller: _inputFromPassword,
                    decoration: const InputDecoration(
                      labelText: ("Password"),
                      border: InputBorder.none,
                    ),
                  ),
                ),
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
                      Auth().signup(
                          email: _inputFromEmail.text,
                          password: _inputFromPassword.text,
                          context: context);
                    },
                    child: Text("Register"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage())),
                    child: Text("Already Have An Account?"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

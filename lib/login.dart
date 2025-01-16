import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_companion/register.dart';
import 'package:travel_companion/variables.dart';

import 'auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = Provider.of<ScreenSize>(context);
    double paddingHorizontal = screenSize.screenWidth * 0.05;
    double paddingTop = screenSize.screenHeight * 0.15;
    double inputWidth = screenSize.screenWidth * 0.8, inputHeight = 50;
    double spaceBetweenFields = screenSize.screenHeight * 0.03;

    TextEditingController inputFromEmail = TextEditingController();
    TextEditingController inputFromPassword = TextEditingController();

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
                  Text(
                    "Login",
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
                      color: Colors.lightBlueAccent,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: inputWidth,
                    height: inputHeight,
                    child: TextField(
                      controller: inputFromEmail,
                      decoration: const InputDecoration(
                        labelText: null,
                        hintText: "Email",
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
                      controller: inputFromPassword,
                      decoration: const InputDecoration(
                        labelText: null,
                        hintText: "Password",
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
                      onPressed: () => Auth().login(
                          email: inputFromEmail.text,
                          password: inputFromPassword.text,
                          context: context),
                      child: const Text("Login"))
                ],
              ),
              SizedBox(
                height: spaceBetweenFields,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () =>
                          Auth().signInWithGoogle(context: context),
                      child: const Text("Continue With Google"))
                ],
              ),
              SizedBox(
                height: spaceBetweenFields,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegisterPage())),
                      child: const Text("Register"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

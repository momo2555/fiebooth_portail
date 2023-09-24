import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/background.jpg"),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 245,
                  ),
                  SizedBox(height: 120),
                  SimpleInput(
                    style: "light",
                    placeholder: "User Name",
                  ),
                  SizedBox(height: 15,),
                  SimpleInput(
                    style: "light",
                    type: "password",
                    placeholder: "Password",
                  ),
                  SizedBox(height: 15,),
                  ActionButton.smallRounded("Connexion", () {
                    Navigator.pushNamed(context, "/home");
                  },),
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

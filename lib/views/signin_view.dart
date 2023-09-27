import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_input.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/models/user_model.dart';
import 'package:fiebooth_portail/utils/error_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  String _login = "";
  String _password = "";
  FieboothController fiebooth = FieboothController();

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
                    onChange: (value) {
                      _login = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SimpleInput(
                    style: "light",
                    type: "password",
                    placeholder: "Password",
                    onChange: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ActionButton.smallRounded(
                    "Connexion",
                    () async {
                      UserModel user =
                          UserModel(userName: _login, userPassword: _password);
                      try {
                        UserModel? response_user =
                            await fiebooth.userLogin(user);
                        if (response_user != null &&
                            response_user.userToken != "") {
                          Navigator.pushNamed(context, "/home");
                        }
                      } on LoginException catch (e) {
                        Fluttertoast.showToast(
                          msg: "${e.toString()}",
                          backgroundColor: Theme.of(context).colorScheme.error,
                          textColor: Theme.of(context).colorScheme.onError,
                          webBgColor: Theme.of(context).colorScheme.error.toString(),
                          timeInSecForIosWeb: 5,
                          webShowClose: true,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

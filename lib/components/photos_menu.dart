import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_close_button.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/utils/global_utils.dart';
import 'package:flutter/material.dart';

class PhotosMenu extends StatefulWidget {
  const PhotosMenu({super.key});

  @override
  State<PhotosMenu> createState() => _PhotosMenuState();
}

class _PhotosMenuState extends State<PhotosMenu> {
  final FieboothController _fieboothController = FieboothController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15),
                        child: SimpleCloseButton(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 50,
                    child: SimpleText.bigText("AD", 1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SimpleText.titleText("Admin"),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ActionButton.sideMenu("Toutes les photos", () {
                    _selectUser("all");
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  SimpleText.labelTitle("Photos par utilisateurs"),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: _fieboothController.getUserList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                            children: snapshot.data!.map(
                          (userName) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ActionButton.sideMenu(userName, () {
                                _selectUser(userName);
                              }),
                            );
                          },
                        ).toList());
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectUser(String user) {
    Globals.selectedUser = user;
    _fieboothController.updateImageList();
    Navigator.pop(context);
  }
}

import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_close_button.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PhotosMenu extends StatefulWidget {
  const PhotosMenu({super.key});

  @override
  State<PhotosMenu> createState() => _PhotosMenuState();
}

class _PhotosMenuState extends State<PhotosMenu> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: SimpleCloseButton(),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: SimpleText.bigText("AD", 1),
                  radius: 50,
                ),
                SizedBox(height: 10,),
                SimpleText.titleText("Admin"),
                SizedBox(height: 15,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ActionButton.sideMenu("Toutes les photos", () {
          
                }),
                SizedBox(height: 20,),
                SimpleText.labelTitle("Photos par utilisateurs"),
                SizedBox(height: 10,),
                ActionButton.sideMenu("jean-luc", () {
          
                }),
                SizedBox(height: 10,),
                ActionButton.sideMenu("richard.fontaine", () {
          
                }),
                SizedBox(height: 10,),
                ActionButton.sideMenu("jean_philippe", () {
          
                }),
              ],
            ),
          ),

        ],
    
    
      ),
    );
  }
}
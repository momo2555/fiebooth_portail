import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key, required this.photo});
  final String photo;
  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.print_rounded),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          IconButton(
            onPressed: () {
              showSimpleDialog(
                ButtonInfo(title: "Annuler", action: () {}),
                ButtonInfo(title: "Supprimer", action: () {}),
                SimpleText.label(
                    "Voulez-vous vraiment supprimer cette photo ?"),
                SimpleText.titleText("Suppression"),
              );
            },
            icon: const Icon(Icons.hide_image_outlined),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(50),
                  spreadRadius: 70,
                  blurRadius: 40,
                ),
              ],
            ),
            child: Hero(
              tag: widget.photo,
              child: Image(
                image: AssetImage(widget.photo),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black.withAlpha(100),
        height: 90,
        width: double.infinity,
        child: Center(
          child: SimpleText.label("Capture_12_12_23_gustave.jpg"),
        ),
      ),
    );
  }
}

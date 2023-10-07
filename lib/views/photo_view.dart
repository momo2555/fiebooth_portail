import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
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
  FieboothController _fieboothController = FieboothController();
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
            onPressed: () {
              _fieboothController.printImage(widget.photo);
            },
            icon: const Icon(Icons.print_rounded),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          IconButton(
            onPressed: () {
              showConfirmDialog("Voulez-vous vraiment supprimer cette photo ?", "Suppression", () async {
                  await _fieboothController.deleteImage(widget.photo);
                  await _fieboothController.updateImageList();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },);
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
              child: Image.network(
                _fieboothController.getPhotoUri(widget.photo).toString(),
                headers: _fieboothController.getBearerHeader(),
                loadingBuilder:
                    (context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress != null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return child;
                  }
                },
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
          child: SimpleText.label(widget.photo.split("@")[1]),
        ),
      ),
    );
  }
}

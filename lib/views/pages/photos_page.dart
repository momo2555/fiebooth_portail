import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/utils/global_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  FieboothController _fieboothController = FieboothController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fieboothController.updateImageList();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Globals.photosList,
      builder: (context, value, child) {
        List<Widget> photosTiles = [
          Container(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: SimpleText.label(Globals.selectedUser),
            ),
          ),
          ...value.map((photoId) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/photo", arguments: photoId);
              },
              child: Hero(
                tag: photoId,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        _fieboothController
                            .getPhotoThumbnailUri(photoId)
                            .toString(),
                        headers: _fieboothController.getBearerHeader(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList()
        ];
        return Container(
          child: GridView.count(
            padding: EdgeInsets.all(15),
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: photosTiles,
          ),
        );
      },
    );
  }
}

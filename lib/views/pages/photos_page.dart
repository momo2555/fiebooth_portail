import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fieboothController.getAllPhotoIdsList(),
      builder: (context, snapshot) {
        print("coucou 1 : ${snapshot.hasData}");
        if (snapshot.data != null) {
          print("coucou 2");
          List<Widget> photosTiles = snapshot.data!.map((photo_id) {
            print(
                _fieboothController.getPhotoThumbnailUri(photo_id).toString());
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/photo", arguments: photo_id);
              },
              child: Hero(
                tag: photo_id,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        _fieboothController
                            .getPhotoThumbnailUri(photo_id)
                            .toString(),
                        headers: _fieboothController.getBearerHeader(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList();
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
        } else {
          return Container();
        }
      },
    );
  }
}

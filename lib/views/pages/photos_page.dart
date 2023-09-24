import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> photosTiles = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11].map((e) {
      var photo = "assets/images/test$e.jpg";
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/photo", arguments: photo);
        },
        child: Hero(
          tag: photo,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(photo),
                fit: BoxFit.cover
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
  }
}

import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/utils/dialog_utils.dart';
import 'package:fiebooth_portail/utils/global_utils.dart';
import 'package:flutter/material.dart';

class PhotosLengthIndicator extends StatefulWidget {
  const PhotosLengthIndicator({super.key});

  @override
  State<PhotosLengthIndicator> createState() => _PhotosLengthIndicatorState();
}

class _PhotosLengthIndicatorState extends State<PhotosLengthIndicator> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Globals.photosList,
      builder: (context, value, child) {
        return Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InkWell(
                onTap: () {
                  /*showSimpleDialog(null, ButtonInfo(title: "Ok", action: () {
                    Navigator.pop(context);
                  }), Container(), SimpleText.titleText("Nombre de photos"),);*/
                },
                child: SizedBox(
                  height: 35,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Center(child: SimpleText.label("${value.length}")),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

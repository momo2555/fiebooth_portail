import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadAllView extends StatefulWidget {
  const DownloadAllView({super.key, required this.user});
  final String user;

  @override
  State<DownloadAllView> createState() => _DownloadAllViewState();
}

class _DownloadAllViewState extends State<DownloadAllView> {
  FieboothController _fieboothController = FieboothController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: SimpleText.BigTitle("Télécharger"),
        centerTitle: true,
        toolbarHeight: 100,
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder(
            stream: _fieboothController.downloadAll(widget.user),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.status);
                if (snapshot.data!.status == "ZIPPING") {
                  return Column(
                    children: [
                      SimpleText.labelTitle("Compression des photos"),
                      const SizedBox(
                        height: 50,
                      ),
                      LinearProgressIndicator(
                        value: snapshot.data!.progress.toDouble() / 100,
                      ),
                      Text(
                        "${snapshot.data!.progress}%",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                } else if (snapshot.data!.status == "READY") {
                  return const Text(
                    "Le Téléchargement va se lancer",
                    style: TextStyle(color: Colors.white),
                  );
                } else if (snapshot.data!.status == "DOWNLOADING") {
                  return Column(
                    children: [
                      SimpleText.labelTitle("Téléchargement des photos"),
                      const SizedBox(
                        height: 50,
                      ),
                      LinearProgressIndicator(
                        value: snapshot.data!.progress.toDouble() / 100,
                      ),
                      Text(
                        "${snapshot.data!.progress}%",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                } else if (snapshot.data!.status == "DONE") {
                  return Column(
                    children: [
                      SimpleText.labelTitle("Fin du téléchargement"),
                      ]
                  );
                } else {
                  return Container();
                }
              } else {
                return Column(
                  children: [SimpleText.labelTitle("Récupération des informations de téléchargements ...")],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

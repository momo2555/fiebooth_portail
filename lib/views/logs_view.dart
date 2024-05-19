import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LogsView extends StatefulWidget {
  const LogsView({super.key});

  @override
  State<LogsView> createState() => _LogsViewState();
}

class _LogsViewState extends State<LogsView> {
  String? _logs;
  FieboothController _fieboothController = FieboothController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fieboothController.getLogs().then((String? logs) {
      setState(() {
        _logs = logs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: SimpleText.BigTitle("logs"),
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
      body: Container(

        child: _logs==null ? const Center(
          child: CircularProgressIndicator(),
        ) :
        Builder(builder: (context) {
          List<String> logsList = _logs!.split("\n");
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              
              children: logsList.map((String log) {
                return Text(">    $log", style: TextStyle(color: Colors.white),);
              },).toList(),
            ),
          );
        },)
      ),
    );
  }
}
import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_drop_down.dart';
import 'package:fiebooth_portail/components/simple_input.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/utils/dialog_utils.dart';
import 'package:flutter/material.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  final FieboothController _fieboothController = FieboothController();
  String _newUserPassword = "";
  String _newUserName = "";
  final TextEditingController _newUserPasswordController = TextEditingController();
  final TextEditingController _newUserNameController = TextEditingController();
  final GlobalKey<FormFieldState> _deleteUsersKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _uploadeUserkey = GlobalKey<FormFieldState>();
  String _deleteUserName = "";
  String _uploadUserNamee = "";
  bool _wait = false;
  List<String> _users = [];
  Future _updateUserList() async {
    _wait = true;
    _fieboothController.getUserList().then((value) {
      if (value != null) {
        _deleteUsersKey.currentState!
            .didChange(value.isNotEmpty ? value.first : "");
        _uploadeUserkey.currentState!
            .didChange(value.isNotEmpty ? value.first : "");
        _users = value;
        setState(() {
          _wait = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ..._createUserBloc,
                ..._uploadCloudBloc,
                ..._deletionBloc,
                ..._otherBloc,
              ],
            ),
          ),
        ),
        _wait
            ? Container(
                color: Theme.of(context).primaryColorDark.withAlpha(140),
                child: const Center(child: CircularProgressIndicator()),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    );
  }

  List<Widget> get _otherBloc {
    return [
      SimpleText.labelTitle("Autres"),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu("Voir les logs", () {
        Navigator.pushNamed(context, "/logs");
      }),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu("Imprimer les QRcodes", () {
        _fieboothController.printQrcodes();
      }),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu(
          "Redémerrer le Fiebooth", () => _fieboothController.rebootFiebooth()),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu("Se déconnecter", () {
        showConfirmDialog(
            "Vous êtes sur le point de vous déconnecter", "Déconnexion", () {
          _fieboothController.userLogout();
          Navigator.pop(context);
        });
      }),
      const SizedBox(
        height: 10,
      )
    ];
  }

  List<Widget> get _deletionBloc {
    return [
      SimpleText.labelTitle("Suppression"),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu("Suppression de toutes les photos", () {
        showConfirmDialog(
            "Voulez vous vraimenr supprimer toutes les photos, Il sera impossible de les récupérer",
            "Suppression", () {
          _fieboothController.deleteAllphotos();
          Navigator.pop(context);
        });
      }),
      const SizedBox(
        height: 15,
      ),
      SimpleDropDown(
        key: _deleteUsersKey,
        items: List.from(_users),
        onChange: (value) {
          _deleteUserName = value;
        },
      ),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu("Supprimer les photos de l'utilisateur", () {
        showConfirmDialog(
            "Voulez vraiment supprimer les photos de l'utilisateur $_deleteUserName ?",
            "Suppression", () async {
          try {
            setState(() {
              _wait = true;
            });
            await _fieboothController.deleteUserPhoto(_deleteUserName);
            await _updateUserList();
            Navigator.pop(context);
          } catch (e) {}
        });
      })
    ];
  }

  List<Widget> get _uploadCloudBloc {
    return [
      SimpleText.labelTitle("Envoie des images dans le Cloud"),
      const SizedBox(
        height: 10,
      ),
      SimpleDropDown(
        key: _uploadeUserkey,
        items: List.from(_users),
        onChange: (value) {
          _uploadUserNamee = value;
        },
      ),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu("Envoyer", () => null),
      const SizedBox(
        height: 15,
      ),
      ActionButton.sideMenu("Télécharger", () {
        Navigator.pushNamed(context, "/download_all",
            arguments: _uploadUserNamee);
      }),
      const SizedBox(
        height: 15,
      ),
    ];
  }

  List<Widget> get _createUserBloc {
    return [
      SimpleText.labelTitle("Utilisateurs"),
      const SizedBox(
        height: 10,
      ),
      SimpleInput(
        style: "filled",
        placeholder: "Nom d'utilisateur",
        onChange: (value) {
          _newUserName = value;
        },
        controller: _newUserNameController,
      ),
      const SizedBox(
        height: 10,
      ),
      SimpleInput(
        style: "filled",
        placeholder: "Mot de passe",
        type: "password",
        onChange: (value) {
          _newUserPassword = value;
        },
        controller: _newUserPasswordController,
      ),
      const SizedBox(
        height: 10,
      ),
      ActionButton.sideMenu("Nouvel utilisateur", () async {
        try {
          setState(() {
            _wait = true;
          });
          await _fieboothController.createNewUser(
              _newUserName, _newUserPassword);
          _newUserNameController.text = "";
          _newUserPasswordController.text = "";
          setState(() {
            _wait = false;
          });
          shwoInfoDialog(
              "L'utilisateur a été créé avec succès", "Confirmation");
        } catch (e) {}
      }),
      const SizedBox(
        height: 15,
      )
    ];
  }
}

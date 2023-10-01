import 'package:fiebooth_portail/components/action_button.dart';
import 'package:fiebooth_portail/components/simple_input.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }

  List<Widget> get _otherBloc {
    return [SimpleText.labelTitle("Autres"),
        SizedBox(height: 10,),
        ActionButton.squaredLight("Voir les logs", () => null),
        SizedBox(height: 10,),
        ActionButton.squaredLight("Redémerrer le Fiebooth", () => null),
        SizedBox(height: 10,),
        ActionButton.squaredLight("Se déconnecter", () => null),
        SizedBox(height: 10,)];
  }

  List<Widget> get _deletionBloc {
    return [SimpleText.labelTitle("Suppression"),
        SizedBox(height: 10,),
        ActionButton.squaredLight("Suppression de toutes les photos", () => null),
        SizedBox(height: 15,),
        SimpleInput(style: "filled", placeholder: "Nom d'utilisateur",),
        SizedBox(height: 10,),
        ActionButton.squaredLight("Supprimer les photos de l'utilisateur", () => null)];
  }

  List<Widget> get _uploadCloudBloc {
    return [SimpleText.labelTitle("Envoie des images dans le Cloud"),
        SizedBox(height: 10,),
        SimpleInput(style: "filled", placeholder: "Nom d'utilisateur",),
        SizedBox(height: 10,),
        ActionButton.squaredLight("Envoyer", () => null),
        SizedBox(height: 15,)];
  }

  List<Widget> get _createUserBloc {
    return [SimpleText.labelTitle("Utilisateurs"),
        SizedBox(height: 10,),
        SimpleInput(style: "filled", placeholder: "Nom d'utilisateur",),
        SizedBox(height: 10,),
        SimpleInput(style: "filled", placeholder: "Mot de passe", type: "password",),
        SizedBox(height: 10,),
        ActionButton.squaredLight("Nouvel utilisateur", () => null),
        SizedBox(height: 15,)];
  }
}
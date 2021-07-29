import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudatechproject/models/Characters.dart';
import 'package:saudatechproject/providers/CharacterProvider.dart';
import 'package:saudatechproject/widgets/CharacterCard.dart';

class CharacterScreen extends StatefulWidget {
  @override
  _CharacterScreenState createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void didChangeDependencies() {
    var provider = Provider.of<CharacterProvider>(context);
    provider.getCharacters().then((value) => provider.setCharacters(value));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CharacterProvider>(context);
    CharactersModel characters = provider.character;
    return Scaffold(
        body: Container(
            child: RefreshIndicator(
      child: characters != null
          ? ListView.builder(
              itemCount: characters.data.length,
              itemBuilder: (context, index) {
                return characterCard(context, characters.data[index]);
              },
              physics: const AlwaysScrollableScrollPhysics(),
            )
          : Center(child: CircularProgressIndicator()),
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          provider.getCharacters().then((value) => characters = value);
        });
      },
    )));
  }
}

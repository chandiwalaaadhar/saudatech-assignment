import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudatechproject/models/Characters.dart';
import 'package:saudatechproject/providers/CharacterProvider.dart';

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

  Widget characterCard(context, Datum data) {
    var size = MediaQuery.of(context).size;
    try {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (data.name != null) | (data.images != null)
              ? Container(
                  height: size.height / 6,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "${data.name.first} ${data.name.middle} ${data.name.last}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text("Age: ${data.age}"),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Occupation: ${data.occupation}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Species: ${data.species}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: SizedBox(
                            height: size.height / 8,
                            child: Image.network(
                              data.images.main,
                              fit: BoxFit.fitHeight,
                            ),
                          ))
                    ],
                  ),
                )
              : Exception(),
        ),
      );
    } catch (e) {
      return SizedBox();
    }
    ;
  }
}

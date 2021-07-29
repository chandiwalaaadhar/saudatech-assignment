import 'package:flutter/material.dart';
import 'package:saudatechproject/models/Characters.dart';

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
                          SizedBox(
                            width: size.width * 0.75,
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
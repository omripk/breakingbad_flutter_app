import 'dart:convert';
// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html' show HttpStatus;
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/charaterDeailScreen.dart';
import 'package:http/http.dart';
import '../models/seriesCharacter.dart';

class SeriesCharacters extends StatefulWidget {
  @override
  _SeriesCharactersState createState() => _SeriesCharactersState();
}

var characters = new List<SeriesCharacter>();

class _SeriesCharactersState extends State<SeriesCharacters> {
  void getCharacters() async {
    print("=========> Girdi");
    Response response = await get('https://breakingbadapi.com/api/characters');
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      setState(() {
        for (int i = 0; i < data.length; i++) {
          var character = new SeriesCharacter();
          var dataIndex = data[i];
          character.id = dataIndex['char_id'];
          character.name = dataIndex['name'];
          character.birthDate = dataIndex['birthday'];

          character.img = dataIndex['img'];
          character.nickName = dataIndex['nickname'];

          // character.occupations = new List<String>();
          for (var item in dataIndex['occupation']) {
            character.occupations.add(item);
          }

          characters.add(character);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Breaking Bad'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.autorenew),
              label: Text('Random'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SeriesCharacterDetail(isRandom: true)));
              },
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    Theme.of(context).accentColor,
                    Theme.of(context).scaffoldBackgroundColor
                  ],
                  tileMode: TileMode.mirror)),
          child: ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SeriesCharacterDetail(
                                characterId: characters[index].id,
                                isRandom: false,
                              )));
                },
                child: ListTile(
                  title: Text(
                    characters[index].name,
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 20.0),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(characters[index].img),
                  ),
                ),
              );
            },
          ),
        ));
  }
}

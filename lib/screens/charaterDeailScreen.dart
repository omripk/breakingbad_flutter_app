import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/functions/card.dart';
import 'package:flutter_app/models/seriesCharacter.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_fade/image_fade.dart';

class SeriesCharacterDetail extends StatefulWidget {
  // Oluşturulduktan sonra değişmeyen Id
  final int characterId;
  final bool isRandom;

  SeriesCharacterDetail({this.characterId, this.isRandom = false});

  @override
  _DetailState createState() => _DetailState();
}

var character = new SeriesCharacter();
bool isLoading = false;

class _DetailState extends State<SeriesCharacterDetail> {
  void getCharacterDetail() async {
    isLoading = false;
    print("=========> Girdi ${widget.characterId}");

    var url;
    if (widget.isRandom) {
      url = 'https://breakingbadapi.com/api/character/random';
    } else {
      url = 'https://breakingbadapi.com/api/characters/${widget.characterId}';
    }

    print(url);
    Response response = await get(url);
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      setState(() {
        character.id = data[0]['char_id'];
        character.name = data[0]['name'];
        var birtDay = data[0]['birthday'];
        character.birthDate =
            (birtDay == "Unknown" || birtDay == null ? "-" : birtDay);
        character.img = data[0]['img'];
        character.nickName = data[0]['nickname'];
        character.player = data[0]['portrayed'];
        character.status = data[0]['status'];
        for (var item in data[0]['occupation']) {
          character.occupations.add(item);
        }

        print(data);
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCharacterDetail();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            body: Center(
              child: SpinKitCircle(color: Colors.yellowAccent, size: 150.0),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TypewriterAnimatedTextKit(
                text: ['${character.name}'],
                textStyle:
                    TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic),
                isRepeatingAnimation: false,
                speed: Duration(milliseconds: 500),
              ),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: ImageFade(
                      image: NetworkImage(character.img),
                      height: 200,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      fadeDuration: Duration(seconds: 5),
                      fadeCurve: Curves.bounceInOut,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                    width: 250.0,
                    child: Divider(color: Theme.of(context).accentColor),
                  ),
                  createACard(context, 'Name', character.name),
                  createACard(context, 'Nick Name', character.nickName),
                  // createACard(
                  //     context,
                  //     'Occupations',
                  //     character.occupations.length > 1
                  //         ? character.occupations.first
                  //         : null),
                  createACard(context, 'Birth Date', character.birthDate),
                  createACard(context, 'Player', character.player),
                  createACard(context, 'Status', character.status),
                  createACard(context, 'id', character.id.toString()),
                ]),
          );
  }
}

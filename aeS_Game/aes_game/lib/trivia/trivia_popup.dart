import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../aes_game.dart';

// ignore: must_be_immutable
class TriviaPopup extends StatelessWidget {
  static const String id = 'TriviaPopup';
  final AesGame gameRef;
  Future<List>? jsonList;

  Future<List> getFuture() async{
    final String response = await rootBundle.loadString('triviaAssets/trivia.json');
    final data = await json.decode(response);
    var jsonData = data["TriviaList"];
    return jsonData;

  }

  TriviaPopup(Key key, {required this.gameRef}) : super(key: key){
    jsonList = getFuture();
  }

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          FutureBuilder<List>(
            future: jsonList,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                // while data is loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // data loaded:
                final jsonData = snapshot.data;
                return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 400,
                        height: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF70ffe7),
                          boxShadow: [  BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 10,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      SizedBox(
                        width: 1000,
                        height:500,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateColor.resolveWith((states) => const Color(0x00FFE69C)),
                            tapTargetSize: MaterialTapTargetSize.padded,
                            overlayColor: MaterialStateColor.resolveWith((states) => const Color(0x00FFE69C)),
                            shadowColor: MaterialStateColor.resolveWith((states) => const Color(0x00FFE69C)),
                            foregroundColor: MaterialStateColor.resolveWith((states) => const Color(0x00FFE69C)),
                          ),
                          onPressed: () {
                            gameRef.resumeEngine();
                            for (var element in gameRef.wasteController.wasteItems) {element.canClick = true;}
                            gameRef.overlays.remove(TriviaPopup.id);
                            
                          },
                          child: SizedBox(
                            width: 400,
                            height: 200,
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 25),
                                  child: Text(
                                    'Did you know?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.black,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 20.0,
                                          color: Colors.white,
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                    ),
                                  ),
                                
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    jsonData?[random.nextInt(jsonData.length-1)]["String"],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 20.0,
                                          color: Colors.white,
                                          offset: Offset(0, 0),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            
                            ])
                        ),
                      ),
                    )
                  ]
                );
              }
            }
          )
        ],
      ),
    );
  }
}

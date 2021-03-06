import 'package:flutter/material.dart';
import '../aes_game.dart';

// ignore: must_be_immutable
class QuotaPopup extends StatelessWidget {
  static const String id = 'QuotaPopup';
  final AesGame gameRef;

  const QuotaPopup(Key key, {required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 400,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE69C),
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
                    gameRef.overlays.remove(QuotaPopup.id);
                    
                  },
                  child: SizedBox(
                    width: 400,
                    height: 200,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 25),
                          child: Text(
                            'Your Turns Have Not Refreshed!',
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
                    ])
                ),
              ),
            )
            ]
          )
        ],
      ),
    );
  }
}

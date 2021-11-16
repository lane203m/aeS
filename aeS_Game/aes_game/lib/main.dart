import 'package:aes_game/aes_game.dart';
import 'package:aes_game/trivia/trivia_popup.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  AesGame aesGame = AesGame();

  runApp(
    GameWidget(
      game: aesGame,
      overlayBuilderMap: {TriviaPopup.id: (BuildContext context, AesGame gameRef) =>
                TriviaPopup(const Key(TriviaPopup.id),
                  gameRef: gameRef,
                )}
    ),
  );
}

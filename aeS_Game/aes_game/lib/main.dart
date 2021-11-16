import 'package:aes_game/aes_game.dart';
import 'package:aes_game/player/quota_popup.dart';
import 'package:aes_game/trivia/trivia_popup.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  AesGame aesGame = AesGame();

  runApp(
    GameWidget(
      mouseCursor: SystemMouseCursors.grab,
      game: aesGame,
      overlayBuilderMap: {TriviaPopup.id: (BuildContext context, AesGame gameRef) =>
                TriviaPopup(const Key(TriviaPopup.id),
                  gameRef: gameRef,
                ),
                QuotaPopup.id: (BuildContext context, AesGame gameRef) =>
                QuotaPopup(const Key(QuotaPopup.id),
                  gameRef: gameRef,
                )
      }
    ),
  );
}

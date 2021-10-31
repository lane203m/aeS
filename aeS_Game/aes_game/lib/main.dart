import 'package:aes_game/aes_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  AesGame aesGame = AesGame();
  
  runApp(
    GameWidget(
      game: aesGame,
    ),
  );
}

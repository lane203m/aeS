import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:flame/palette.dart';
import 'package:flame/image_composition.dart';
import 'dart:math' as math;



class WasteItem extends SpriteComponent with Tappable {
  late Sprite wasteSprite;
  bool isClicked = false;
  SpriteSheet? spriteSheet;
  Timer timer = Timer(2);
  int scoreToGive = 1;
  double angleToggle = 0.05 * (-3 + math.Random().nextInt(6) <= 0 ? (-3 + math.Random().nextInt(2)) as double : (1 + math.Random().nextInt(2)) as double);
  Paint currentPaint;
  bool canClick = true;

  static Paint _randomPaint() {
    final rng = math.Random();
    final color = Color.fromRGBO(
      rng.nextInt(256),
      rng.nextInt(256),
      rng.nextInt(256),
      0.9,
    );
    return PaletteEntry(color).paint();
  }

  WasteItem({required SpriteSheet? spriteSheet, required Vector2 position})
      : currentPaint = _randomPaint(),
        spriteSheet = spriteSheet,
        super(
          position: position,
          size: Vector2.all(48 + (64-48) * math.Random().nextDouble()),
        ){
    initialize();
  }

  void initialize() async{
    wasteSprite = spriteSheet!.getSprite(0, math.Random().nextInt(16));
    sprite = wasteSprite;
  }

  @override
  bool onTapUp(_) {
    return false;
  }

  @override
  bool onTapDown(_) {
    if(!isClicked && canClick){
      makeTransparent();
      add(ScaleEffect(scale: Vector2.all(1.6), speed: 2.0, curve: Curves.linear));
      add(RotateEffect(angle: -2/angleToggle, speed: 2, isInfinite: true, isAlternating: true));  
      isClicked = true;
      //OpacityEffect opacityEffect = OpacityEffect(duration: 2, opacity: 1, removeOnFinish: true);
      add(OpacityEffect(duration: 0.5, opacity: 1, isAlternating: true));
      timer.start();
    }
    return false;
    
  }

  @override
  bool onTapCancel() {
    return false;
  }
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    add(RotateEffect(angle: angleToggle, speed: 0.02 * 1 *math.Random().nextDouble(), isAlternating: true, isInfinite: true));
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    if(isClicked){
      if(timer.isRunning()){

        timer.update(dt);
      }
      else if(isClicked && !timer.isRunning()){
        removeFromParent();
        timer.stop();
        }
    }   
  }
}
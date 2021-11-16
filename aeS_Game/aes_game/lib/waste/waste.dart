import 'package:aes_game/models/waste_data.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:flame/image_composition.dart';
import 'dart:math' as math;
import 'package:flame/input.dart';


class WasteItem extends SpriteComponent with Tappable {
  late WasteData wasteData;
  SpriteSheet spriteSheet;
  bool canClick = true;

  WasteItem(this.spriteSheet,  bool isClicked, bool canClick, int spriteNumber, int wasteId, {required Vector2 position})
      : super(
          position: position,
          size: Vector2.all(48 + (64-48) * math.Random().nextDouble()),
        ){
    initialize(spriteNumber, isClicked, canClick, wasteId);
  }

  void initialize(int spriteNumber, bool isClicked, bool canClick, int wasteId) async{
    var wasteSprite = spriteSheet.getSprite(0, math.Random().nextInt(16));
    wasteData = WasteData(isClicked, canClick, wasteId, wasteSpriteValue: wasteSprite);
    sprite = wasteData.wasteSprite;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool onTapUp(_) {
    return false;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  bool onTapDown(_) {
    if(!wasteData.isClicked && canClick){
      triggerDespawn();
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
    add(RotateEffect(angle: wasteData.angleToggle, speed: 0.02 * 1 *math.Random().nextDouble(), isAlternating: true, isInfinite: true));
  }

  @override
  void update(double dt) {
    // ignore: todo
    // TODO: implement update
    super.update(dt);
    if(wasteData.isClicked){
      if(wasteData.timer.isRunning()){

        wasteData.timer.update(dt);
      }
      else if(wasteData.isClicked && !wasteData.timer.isRunning()){
        removeFromParent();
        wasteData.timer.stop();
        }
    }   
  }

  void triggerDespawn() {
      makeTransparent();
      add(ScaleEffect(scale: Vector2.all(1.6), speed: 2.0, curve: Curves.linear));
      add(RotateEffect(angle: -2/wasteData.angleToggle, speed: 2, isInfinite: true, isAlternating: true));  
      wasteData.isClicked = true;
      //OpacityEffect opacityEffect = OpacityEffect(duration: 2, opacity: 1, removeOnFinish: true);
      add(OpacityEffect(duration: 0.5, opacity: 1, isAlternating: true));
      wasteData.timer.start();
  }
}
import 'dart:html';

import 'package:aes_game/parallax_component.dart';
import 'package:aes_game/player/player_controller.dart';
import 'package:aes_game/player/quota_popup.dart';
import 'package:aes_game/waste/waste_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import './trivia/trivia_popup.dart';
class AesGame extends FlameGame with HasTappableComponents {
  late Image image;
  int score = 0;
  AesGame(){
    initialize();
  }
  
  late WasteController wasteController;
  late PlayerController playerController;

  void initialize() async {
    
  }

  @override
  // ignore: avoid_renaming_method_parameters
  void render(Canvas c){
    final Paint lightBlue = const PaletteEntry(Color(0xFF0087a4)).paint();
    final Paint darkBlue = const PaletteEntry(Color(0xFF005e73)).paint();
    final Paint medBlue = const PaletteEntry(Color(0xFF012932)).paint();
    Rect hugeRect = size.toRect();
    Rect medRect = Vector2(1920, 540).toRect();
    Rect smallRect = Vector2(1920, 360).toRect();
    c.drawRect(hugeRect, medBlue);
    c.drawRect(medRect, darkBlue);
    c.drawRect(smallRect, lightBlue);

    super.render(c);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    image = await Flame.images.load('../../../sprites/recycle_item_sprites.png');
    wasteController = WasteController(image: image);
    wasteController.generateWasteItems();
    debugPrint('${wasteController.wasteItems.length}');
    await add(SeaParallaxComponent());
    playerController = PlayerController(size);
    add(wasteController);
    add(playerController);
  }

  @override
  void update(double dt) {
    // ignore: todo
    // TODO: implement update
    super.update(dt);
    playerController.size = size;

    for (int i = 0 ; i<wasteController.wasteItems.length; i++){
      if(playerController.playerData.quota == 0 && DateTime.now().isBefore(playerController.playerData.dateTime.add(const Duration(seconds: 10)))){
        wasteController.wasteItems[i].canClick = false;
        //overlays.add(QuotaPopup.id);
        //for (var element in wasteController.wasteItems) { element.canClick = false;}
      }
      else if(wasteController.wasteItems[i].wasteData.isClicked && wasteController.wasteItems[i].wasteData.scoreToGive > 0 && playerController.playerData.quota == 0 && DateTime.now().isAfter(playerController.playerData.dateTime.add(const Duration(seconds: 10)))){
        playerController.playerData.score += wasteController.wasteItems[i].wasteData.scoreToGive*25;
        playerController.playerData.quota -= wasteController.wasteItems[i].wasteData.scoreToGive;
        wasteController.wasteItems[i].wasteData.scoreToGive = 0;
        playerController.postPlayerScore();

        playerController.updatePlayerState();
        overlays.add(TriviaPopup.id);
        for (var element in wasteController.wasteItems) { element.canClick = false;}
      }
      else if(wasteController.wasteItems[i].wasteData.isClicked && wasteController.wasteItems[i].wasteData.scoreToGive > 0){
        playerController.playerData.score += wasteController.wasteItems[i].wasteData.scoreToGive*25;
        playerController.playerData.quota -= wasteController.wasteItems[i].wasteData.scoreToGive;
        wasteController.wasteItems[i].wasteData.scoreToGive = 0;
        playerController.postPlayerScore();
        playerController.postPlayerActions();
        playerController.postActionTime();
        playerController.updatePlayerState();
        overlays.add(TriviaPopup.id);
        for (var element in wasteController.wasteItems) { element.canClick = false;}
      }
    }

    if(playerController.playerData.quota == 0 && !DateTime.now().isBefore(playerController.playerData.dateTime.add(const Duration(seconds: 10)))){
      for (var element in wasteController.wasteItems) {element.canClick = true;}
      playerController.postResetPlayerActions();
      playerController.postActionTime();
    }
  }

}


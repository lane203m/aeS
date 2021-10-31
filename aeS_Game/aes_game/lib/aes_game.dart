import 'package:aes_game/parallax_component.dart';
import 'package:aes_game/player/player_controller.dart';
import 'package:aes_game/waste/waste_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'dart:ui';

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
    await add(SeaParallaxComponent());
    playerController = PlayerController(size: size);
    add(wasteController);
    add(playerController);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    playerController.size = size;

    for (int i = 0 ; i<1000; i++){
      if(wasteController.wasteItems[i].isClicked){
        playerController.score += wasteController.wasteItems[i].scoreToGive*25;
        playerController.quota -= wasteController.wasteItems[i].scoreToGive;
        wasteController.wasteItems[i].scoreToGive = 0;
      }
      if(playerController.quota == 0){
        wasteController.wasteItems[i].canClick = false;
      }
    }
  }
}


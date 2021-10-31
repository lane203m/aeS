import 'package:aes_game/waste/waste.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'dart:math';

class WasteController extends Component {
  List<WasteItem> wasteItems = [];
  Image image;
  Random random = Random();
  late SpriteSheet spriteSheet;

  WasteController({required Image image})
    : image = image
  {
    initialize();
  }

  initialize() async {
    spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(64, 64)
    );
  }

  void generateWasteItems(){
    for (int i = 0; i < 1000; i++){
      random = Random();
      wasteItems.add(WasteItem(spriteSheet: spriteSheet, position: Vector2(1920*random.nextDouble(), 1080*random.nextDouble())));

    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    for(int i = 0; i<750; i++){
      add(wasteItems[i]);
    }
  }
}

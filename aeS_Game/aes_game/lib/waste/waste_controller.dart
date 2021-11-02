import 'package:aes_game/waste/waste.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'dart:math';

import 'package:flutter/foundation.dart';

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

  void generateWasteItems() async{

    wasteItems = await getWasteItems();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await wasteItems[0].sprite;
    for(int i = 0; i<wasteItems.length; i++){
      debugPrint('${wasteItems[i].wasteData.wasteId}');
      add(wasteItems[i]);
      debugPrint('${wasteItems[i].sprite?.image.toString()}');
      debugPrint('${wasteItems[i].sprite?.src}');
      debugPrint('${wasteItems[i].sprite?.src.toString()}');
    }
  }
  
  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    List<int> removedItems = getRemovedItems();
    wasteItems.forEach((wasteElement) {
      if(removedItems.contains(wasteElement.wasteData.wasteId)){
        wasteElement.triggerDespawn();
      }
    }
    );


  }

  List<int> getRemovedItems(){
    return [];
  }

  List<WasteItem> getWasteItems() {
    List<WasteItem> wasteItemResults = []; 
    
    for (int i = 0; i < 1000; i++){
      random = Random();
      wasteItemResults.add(WasteItem(spriteSheet, false, true, i, random.nextInt(16) , position: Vector2(1920*random.nextDouble(), 1080*random.nextDouble())));
    }
    debugPrint('${wasteItemResults.first.sprite}');
    return wasteItemResults;
  }
}

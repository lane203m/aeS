// ignore_for_file: implementation_imports
import 'package:aes_game/models/waste_response.dart';
import 'package:aes_game/waste/waste.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'dart:math';
import 'package:aes_game/connections/http_get.dart';

class WasteController extends Component {
  List<WasteItem> wasteItems = [];
  late DateTime updateTime; 
  Image image;
  Random random = Random();
  late SpriteSheet spriteSheet;

  WasteController({required Image image})
    // ignore: prefer_initializing_formals
    : image = image
  {
    initialize();
  }

  initialize() async {
    spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(64, 64)
    );
    updateTime = DateTime.now().toUtc();
  }

  Future generateWasteItems() async{

    wasteItems = await getWasteItems();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    wasteItems[0].sprite;
    for(int i = 0; i<wasteItems.length; i++){
      add(wasteItems[i]);
    }
  }
  

  static const double updateRate = 1;
  double _timeSinceUpdate = 0;
  @override
  void update(double dt) {
    // ignore: todo
    // TODO: implement update
    super.update(dt);
    if(_timeSinceUpdate < updateRate) {
      _timeSinceUpdate += dt;
      return;
    }
    _timeSinceUpdate = 0;

    handleRemovedItems();
  }

  void handleRemovedItems() async{
    List<WasteResponse> removedWasteData = await getDeleted(updateTime.subtract(const Duration(seconds: 10)));
    WasteItem? toDelete;
    while(removedWasteData.isNotEmpty){
      WasteResponse wasteResponse = removedWasteData.removeLast();

      toDelete = wasteItems.firstWhereOrNull((it) => it.wasteData.wasteId == wasteResponse.wasteID);
      if(toDelete != null && !toDelete.wasteData.isClicked){
        toDelete.wasteData.isClicked = true;
        toDelete.wasteData.scoreToGive = 0;
        toDelete.triggerDespawn();

      }

    }
    updateTime = DateTime.now().toUtc();
  }

  Future getWasteItems() async{

    List<WasteResponse> wasteData = await getAll();
    List<WasteItem> wasteItemResults = []; 
    
    for (WasteResponse element in wasteData){
      random = Random();
      wasteItemResults.add(WasteItem(spriteSheet, false, true, element.wasteType, element.wasteID , size: element.size, position: Vector2(element.xPos as double, element.yPos as double)));
    }
    //debugPrint('${wasteItemResults.first.sprite}');
    return wasteItemResults;
  }
}

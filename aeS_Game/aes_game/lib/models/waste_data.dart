import 'package:flame/components.dart';
import 'dart:math' as math;

class WasteData{
  Sprite wasteSprite;
  int wasteId;
  bool isClicked = false;
  Timer timer = Timer(2);
  int scoreToGive = 1;
  double angleToggle = 0.05 * (-3 + math.Random().nextInt(6) <= 0 ? (-3 + math.Random().nextInt(2)) as double : (1 + math.Random().nextInt(2)) as double);
  bool canClick = true;

  WasteData(this.isClicked, this.canClick, this.wasteId, {required Sprite wasteSpriteValue}) : wasteSprite = wasteSpriteValue;
}
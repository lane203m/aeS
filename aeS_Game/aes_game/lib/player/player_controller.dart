import 'package:aes_game/models/player_data.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
class PlayerController extends Component {
  late PlayerData playerData;
  Vector2 size;
  late TextComponent scoreOverlay;
  late TextComponent quotaOverlay;

  PlayerController(this.size)
  {
    initialize();
  }

  initialize() async {
    playerData = getPlayerData();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(size.x - 110, 10, 100, 20),
      Paint()..color = Colors.white,
    );

    canvas.drawRect(
      Rect.fromLTWH(size.x/2-50, 10, 100, 20),
      Paint()..color = Colors.white,
    );
    super.render(canvas); 
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    scoreOverlay = TextComponent(
        'Score: ',
        position: Vector2(size.x-60, 20),
        textRenderer: TextPaint(
          config: const TextPaintConfig(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'BungeeInline',
          ),
        ),
      );

      // Setting isHud to true makes sure that this component
      // does not get affected by camera's transformations.
      scoreOverlay.isHud = true;
      scoreOverlay.anchor = Anchor.center;
      add(scoreOverlay);

      // Create text component for player health.
      quotaOverlay = TextComponent(
        'Actions: ',
        position: Vector2(size.x/2, 20),
        textRenderer: TextPaint(
          config: const TextPaintConfig(
            color: Colors.green,
            fontSize: 12,
            fontFamily: 'BungeeInline',
          ),
        ),
      );

      quotaOverlay.anchor = Anchor.center;

      // Setting isHud to true makes sure that this component
      // does not get affected by camera's transformations.
      quotaOverlay.isHud = true;
      add(quotaOverlay);
  }
  @override
  void update(double dt) {
    // ignore: todo
    // TODO: implement update
    super.update(dt);
      scoreOverlay.text = 'Score: ${playerData.score}';
    if(playerData.quota > 0){
      quotaOverlay.text = 'Actions: ${playerData.quota}';
      quotaOverlay.textRenderer = TextPaint(
          config: const TextPaintConfig(
            color: Colors.green,
            fontSize: 12,
            fontFamily: 'BungeeInline',
          ),
      ); 
    }else{
      initializeDateFormatting('en_US', null);
      quotaOverlay.text = '${(playerData.dateTime.add(const Duration(seconds: 10))).difference(DateTime.now())}';/*DateFormat.Hms(DateTime.now().toString())}';*/
      quotaOverlay.textRenderer = TextPaint(
          config: const TextPaintConfig(
            color: Colors.orange,
            fontSize: 12,
            fontFamily: 'BungeeInline',
          ),
      ); 
    }
    scoreOverlay.position = Vector2(size.x/2, 20);
    quotaOverlay.position = Vector2(size.x-60, 20);
  }

  void updatePlayerState(){
    playerData = playerData;//getPlayerData()
  }

  PlayerData getPlayerData() {
    PlayerData playerData; 
    
    playerData = PlayerData(0, 10, DateTime.now(), "1.0");

    return playerData;
  }

  void postPlayerScore(){
    //currentScore +=1
  }

  void postResetPlayerActions(){
    playerData.quota = 10;
    
    playerData.dateTime = DateTime.now();
  }

  void postActionTime(){
    playerData.dateTime = DateTime.now();
  }

  void postPlayerActions(){
    //actions =- 1
  }

}

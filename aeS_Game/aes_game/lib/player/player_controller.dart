import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PlayerController extends Component {
  late int score;
  late int quota;
  Vector2 size;
  late TextComponent scoreOverlay;
  late TextComponent quotaOverlay;
  late DateTime dateTime;

  PlayerController({required Vector2 size}):size = size
  {
    initialize();
  }

  initialize() async {
    score = 0;
    quota = 10;
    dateTime = DateTime.now();
  }

  void getPlayerState(){
    score = score;
    quota = quota;
    dateTime = dateTime;
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
    // TODO: implement update
    super.update(dt);
    quotaOverlay.text = 'Actions: $quota';
    scoreOverlay.text = 'Score: $score';
    scoreOverlay.position = Vector2(size.x/2, 20);
    quotaOverlay.position = Vector2(size.x-60, 20);
  }
}

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';

class SeaParallaxComponent extends ParallaxComponent {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('../../../sprites/sea_background.png'),
        ParallaxImageData('../../../sprites/farground.png'),
        ParallaxImageData('../../../sprites/mid_background.png'),
        ParallaxImageData('../../../sprites/foreground.png'),
      ],
      baseVelocity: Vector2(1, 0),
      velocityMultiplierDelta: Vector2(1, 1.0),
      size: Vector2(1920,1080)
    );
  }
}
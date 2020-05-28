import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import '../game.dart';

import './explosion_component.dart';

class EnemyComponent extends AnimationComponent with HasGameRef<SpaceShooterGame>{

  static const enemy_speed = 150;

  bool destroyed = false;

  EnemyComponent(double x, double y):
    super(25, 25,Animation.sequenced("enemy.png", 4, textureWidth: 16, textureHeight: 16)) {
      this.x = x;
      this.y = y;
    }

  //imimigo atinge player
  @override
  void update(double dt) {
    super.update(dt);

    y += enemy_speed * dt;

    if (gameRef.player != null && gameRef.player.toRect().overlaps(toRect())) {
      takeHit();
      //player toma dano
      gameRef.playerTakeHit();
    }
  }

    //player é destruído, placar é zerado
  void takeHit() {
    destroyed = true;

    gameRef.add(ExplosionComponent(x - 25, y - 25));
    gameRef.increaseScore();
  }

  @override
  bool destroy() => destroyed || y >= gameRef.size.height;
}


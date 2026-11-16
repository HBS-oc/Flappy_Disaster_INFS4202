import 'bird.dart';
import 'pipe.dart';
import 'dart:math';

class GameMechanics {
  Bird bird = Bird(
      y: 300,
      velocityY: 0,
      gravity: 750,
      width: 40,
      height: 30,
      flapStrength: 375
      flapStrength: 300
    );
  List<DoublePipe> pipes;
  int score;
  bool isGameOver;


  GameMechanics({
    required this.pipes, 
    required this.score, 
    required this.isGameOver,
  });

  void reset() {
    bird = Bird(
      y: 300,
      velocityY: 0,
      gravity: 750,
      width: 40,
      height: 30,
      flapStrength: 375
    );
    pipes.clear();
    score = 0;
    isGameOver = false;
  }

  void update(double changeTime, double height){
    if (isGameOver){
      return;
    }
    bird.update(changeTime);
    for(DoublePipe pipe in pipes){
      pipe.update(changeTime);
    }
    if(detectCollision() || detectBoundaryCollision(height)){
      isGameOver = true;
      return;
    }
    updateScore();
    removePipesOutScreen();
  }

  void spawnPipe(double width, double height, double gapSize){
    final random = Random();

    double minGapY = gapSize / 2 + 170; //create a low boundary for randomization
    double maxGapY = height - gapSize / 2 - 170; //create a high boundary for randomization

    double randomGapY = minGapY + random.nextDouble() * (maxGapY - minGapY); //randomized pipe generation

    pipes.add(
      DoublePipe(
        x: width,
        gapY: randomGapY,
        gapSize: gapSize,
        width: 60,
        speed: 150
      )
    );
  }

  bool detectBoundaryCollision(double height){
    return bird.y <= 0 || bird.y + bird.width >= height - 60;
  }

  bool detectCollision(){
    for(DoublePipe pipe in pipes){
      bool widthHitbox = bird.x < pipe.x + pipe.width && bird.width + bird.x > pipe.x;
      bool heightHitbox = bird.y < pipe.topPipeEdge || bird.y + bird.height > pipe.bottomPipeEdge;
      
      if(widthHitbox && heightHitbox){
        return true;
      }
    }
    return false;
  }

  void updateScore() {
    for(DoublePipe pipe in pipes){
      if(bird.x > pipe.x + pipe.width && !pipe.passed){
        score++;
        pipe.passed = true;
      }
    }
  }

  void removePipesOutScreen(){
    pipes.removeWhere((pipe) => pipe.x + pipe.width < 0);
  }
}

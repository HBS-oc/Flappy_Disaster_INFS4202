import 'game_mechanics.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'pipe.dart';

class GameScreen extends StatefulWidget {
  final String difficulity;
  final String selectedSkin;

  const GameScreen({
    super.key,
    required this.difficulity,
    required this.selectedSkin,
  });

  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final GameMechanics game = GameMechanics(
    pipes: [],
    score: 0,
    isGameOver: false,
  );
  Timer? gameTimer;
  Timer? pipeSpawnTimer;
  final stopwatch = Stopwatch();
  double screenHeight = 0;
  double screenWidth = 0;
  double backgroundOffset = 0;
  double backgroundSpeed = 60;
  double groundOffset = 0;
  double groundSpeed = 150;

  @override
  void initState() {
    // acts similar to before all
    super.initState();
    startGameTimer();
  }

  double getGapsize() {
    if (widget.difficulity == 'Easy') {
      return 220;
    } else if (widget.difficulity == 'Medium') {
      return 180;
    } else {
      return 140;
    }
  }

  void startGameTimer() {
    stopwatch.start(); //using stopwatch rather than Timer.periodic because of desync issues and high severity because it contains game update logic (mentioned on many threads online)
    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (gameT) {
      double changeTime = stopwatch.elapsedMilliseconds / 1000;
      stopwatch.reset();
      game.update(changeTime, screenHeight);

      setState(() {
        backgroundOffset = backgroundOffset - backgroundSpeed * changeTime;
        groundOffset = groundOffset - groundSpeed * changeTime;
        if (backgroundOffset <= -screenWidth) {
          backgroundOffset += screenWidth;
        }
        if (groundOffset <= -screenWidth) {
          groundOffset += screenWidth;
        }
      });

      if (game.isGameOver) {
        stopwatch.stop();
        pipeSpawnTimer?.cancel();
        gameT.cancel();
      }
    });

    pipeSpawnTimer = Timer.periodic(const Duration(milliseconds: 1500), (
      spawnT,
    ) {
      game.spawnPipe(screenWidth, screenHeight, getGapsize());
    });
  }

  void restartGame() {
    gameTimer?.cancel();
    pipeSpawnTimer?.cancel();
    game.reset();
    startGameTimer();
  }

  void pauseGame() {
    stopwatch.stop();
    gameTimer?.cancel();
    pipeSpawnTimer?.cancel();
  }

  void resumeGame() {
    startGameTimer();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      onDrawerChanged: (bool isOpened) {
        if (isOpened) {
          pauseGame();
        }
      },
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 242, 233, 202),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Paused', style: TextStyle(fontFamily: 'Pix', fontSize: 40)),
            SizedBox(height: 40),
            Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 137, 189, 77),
              ),
              alignment: Alignment.center,
              child: ListTile(
                title: Text('Resume', style: TextStyle(fontFamily: "Pix")),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    resumeGame();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 133, 146, 212),
              ),
              alignment: Alignment.center,
              child: ListTile(
                title: Text('Restart', style: TextStyle(fontFamily: "Pix")),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    restartGame();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 213, 174, 84),
              ),
              alignment: Alignment.center,
              child: ListTile(
                title: Text('Home', style: TextStyle(fontFamily: "Pix")),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (!game.isGameOver) {
            game.bird.flap();
          }
        },
        child: Stack(
          children: [
            Positioned(
              left: backgroundOffset,
              top: 0,
              child: Image.asset(
                'assets/Background.png',
                width: screenWidth * 2,
                height: screenHeight,
                repeat: ImageRepeat.repeatX,
                fit: BoxFit.fitHeight,
                alignment: Alignment.topLeft,
                filterQuality: FilterQuality.none,
              ),
            ),
            for (DoublePipe pipe in game.pipes)
              Positioned(
                left: pipe.x,
                top: 0,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Image.asset(
                    'assets/Pipe.png',
                    height: pipe.topPipeEdge,
                    width: 60,
                    fit: BoxFit.fill,
                    centerSlice: Rect.fromLTWH(10, 50, 7, 1),
                    filterQuality: FilterQuality.none,
                  ),
                ),
              ),
            for (DoublePipe pipe in game.pipes)
              Positioned(
                left: pipe.x,
                top: pipe.bottomPipeEdge,
                child: Image.asset(
                  'assets/Pipe.png',
                  height: screenHeight - pipe.bottomPipeEdge,
                  width: 60,
                  fit: BoxFit.fill,
                  centerSlice: Rect.fromLTWH(10, 50, 7, 1),
                  filterQuality: FilterQuality.none,
                ),
              ),
            Positioned(
              left: game.bird.x,
              top: game.bird.y,
              child: Transform.rotate(
                angle: (game.bird.velocityY / 750 - 0.45),
                child: Image.asset(
                  'assets/${widget.selectedSkin}.png',
                  width: 40,
                  height: 30,
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Text(
                '${game.score}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Pix"),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(height: 60, color: Color(0xFFFCF1BA)),
            ),
            Positioned(
              bottom: 0,
              left: groundOffset,
              right: 0,
              child: Image.asset(
                'assets/Ground.png',
                height: 60,
                width: screenWidth * 2,
                repeat: ImageRepeat.repeatX,
                fit: BoxFit.none,
                alignment: Alignment.topLeft,
                filterQuality: FilterQuality.none,
              ),
            ),
            if (game.isGameOver)
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 242, 233, 202),
                  ),
                  height: 400,
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Game Over',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pix',
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Score:  ${game.score}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pix',
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Best:  ${game.score}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pix',
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 133, 146, 212),
                        ),
                        alignment: Alignment.center,
                        child: ListTile(
                          title: Text(
                            'Restart',
                            style: TextStyle(fontFamily: "Pix"),
                          ),
                          onTap: () {
                            setState(() {
                              restartGame();
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 213, 174, 84),
                        ),
                        alignment: Alignment.center,
                        child: ListTile(
                          title: Text(
                            'Home',
                            style: TextStyle(fontFamily: "Pix"),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: 40,
              left: 20,
              child: Builder(
                builder: (context) => Container(
                  decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(15)),
                  child: IconButton(
                    icon: Icon(Icons.pause_rounded, color: Colors.white, size: 40),
                    onPressed: Scaffold.of(context).openDrawer,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // acts similar to after all
    gameTimer?.cancel();
    pipeSpawnTimer?.cancel();
    super.dispose();
  }
}

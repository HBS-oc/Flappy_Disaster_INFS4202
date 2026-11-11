class DoublePipe {
  double x;
  final double gapY;
  final double gapSize;
  final double width;
  final double speed;
  bool passed = false;

  DoublePipe({
    required this.x,
    required this.gapY,
    required this.gapSize,
    required this.width,
    required this.speed,
  });

  void update(double changeTime){
    x = x - (speed*changeTime); //used x = x - vt
  }

  double get topPipeEdge => gapY - gapSize/2;
  double get bottomPipeEdge => gapY + gapSize/2;
}
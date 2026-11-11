class Bird {
  double x = 100;
  double y;
  double velocityY;
  double gravity;
  double width;
  double height;
  double flapStrength;

  Bird({
    required this.y,
    required this.velocityY,
    required this.gravity,
    required this.width,
    required this.height,
    required this.flapStrength
  });

  void flap(){
    velocityY = -flapStrength;
  }

  void update(double changeTime) {
    velocityY = (gravity * changeTime) + velocityY; //Used v = gt + u
    y = y + (velocityY*changeTime); //Used s = u + vt
  }
}
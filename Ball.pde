class Ball implements GameObject {

  private float x;
  private float y;
  private float tamanhoBola = 50;
  
  private float direcaoX = 1;
  private float vel = 200;
  
  private float dx = 0;
  private float dy = 0;
  
  private float d = 180;
  private float h = 200;
  
  private BallState state;
  Platform platform = null; 

  Ball(float x, float y) {
    this.x = x;
    this.y = y;
    
    state = BallState.BEGINNING;
  }
  
  void update(float elapsedTime) {
    
    switch(state) {
    case HASPLATFORM:
      x += vel * elapsedTime * direcaoX;
      if (platform.isHorizontallyOut(x)) {
        state = BallState.FALLING;
        dx = 0;
        y += h;
        dy = h;
      }
      break;
      
    case JUMPING:
      x += vel * elapsedTime * direcaoX;
      dx += vel * elapsedTime * direcaoX;
      dy = calc_dy(dx);
      
      if ((dx > 0 && direcaoX == 1) || (dx < 0 && direcaoX == -1)) {
        state = BallState.FALLING;
      }
      break;
 
    case FALLING: 
      x += vel * elapsedTime * direcaoX;
      dx += vel * elapsedTime * direcaoX;
      dy = calc_dy(dx);
      break;

    case BEGINNING:
      y += vel * elapsedTime;
      break;
    }
  }
  
  Boolean collided(Platform to) {
    if ((state == BallState.FALLING || state == BallState.BEGINNING) && 
        x > to.getX() && x < to.getX() + to.getWidth() &&
        y - dy > to.getY() - tamanhoBola / 2 && y - dy < to.getY() + tamanhoBola / 2) {

      platform = to;
      y = to.y - tamanhoBola / 2;
      dy = 0;
      state = BallState.HASPLATFORM;
      return true;
    }
    
    return false;
  }
  
  void render() {
    circle(x, y - dy, tamanhoBola);
  }
  
  void mousePressed() {
    if (state == BallState.HASPLATFORM) {
       state = BallState.JUMPING;
       platform = null;
       dx = -d/2 * direcaoX;
    }
  }
  
  void keyPressed() {
    if (keyCode == 32 && state == BallState.HASPLATFORM) { direcaoX = -direcaoX; }
  }
  
  private float calc_dy(float dx) {
    return (-4*h*dx*dx)/(d*d) + h;
  }
}

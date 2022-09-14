class Ball implements GameObject {

  private float x;
  private float y;
  private float tamanhoBola = 50;
  
  private float direcaoX = 1;
  private float vel = 200;
  private float velX = 200;
  
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
      x += elapsedTime * direcaoX * velX;
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
    
    velX = velX >= velX/100 ? velX - velX/100 : 1;
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
  
  Boolean collided(EnemyObject enemy) {
    if (enemy.isCollision(this.x + (direcaoX * tamanhoBola/2), this.y - dy)) {
      println("D I E D");
      this.direcaoX = 0;
      return true;
    }
    return false;
  }
  
  void render() {
    circle(x, y - dy, tamanhoBola);
  }
  
  void mousePressed() { }
  
  void keyPressed() {
    
    switch(keyCode) {
      case 37:
        if (state == BallState.HASPLATFORM) { 
          direcaoX = -1;
          velX = 200;
        }
        break;

       case 39:
        if (state == BallState.HASPLATFORM) { 
          direcaoX = 1;
          velX = 200;
        }
        break;

      case 32:
        if (state == BallState.HASPLATFORM) { 
          state = BallState.JUMPING;
          platform = null;
          dx = -d/2 * direcaoX;
        }
        break;
    }
  }
  
  private float calc_dy(float dx) {
    return (-4*h*dx*dx)/(d*d) + h;
  }
}

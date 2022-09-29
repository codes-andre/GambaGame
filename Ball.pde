class Ball implements GameObject {

  private float x;
  private float y;
  private float tamanhoBola;
  
  private float direcaoX = 1;
  private float vel = 200;
  private float velX = 50;
  private float originVelX = 50;
  
  private float dx = 0;
  private float dy = 0;
  
  private float d = 180;
  private float h = 200;
  
  private BallState state;
  private SpecialItem keey = null;
  
  Platform platform = null; 
  PlatMove platmove = null;

  Ball(float x, float y, float tamanhoBola) {
    this.x = x;
    this.y = y;
    this.tamanhoBola = tamanhoBola;
    
    state = BallState.BEGINNING;
  }
  
  void update(float elapsedTime) {
    
    velX -= elapsedTime * originVelX;
    if (velX < 0) {
      velX = 0;
    }
    
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
      
    case HASPLATMOVE:
      x += elapsedTime * direcaoX * velX;
      if (platmove.isHorizontallyOut(x)) {
        state = BallState.FALLING;
        dx = 0;
        y += h;
        dy = h;
      }else{
        y = platmove.getY() - tamanhoBola/2;
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
  
  Image getImage() {
    return new Image(loadImage("idle.png"), x - tamanhoBola, y-dy - (tamanhoBola*2.2), 50, 50);
  }
  
  Boolean collided(SpecialItem item) {
    if (x > item.getX() && x < item.getX() + item.getWidth() &&
        y - dy > item.getY() - tamanhoBola / 2 && y - dy < item.getY() + tamanhoBola / 2) {

      if (item.type == ItemType.KEY) {
          keey = item;
      }
      
      return true;
    }
    return false;
  }
  
  Boolean collided(PlatMove to) {
    if (state != BallState.HASPLATMOVE && (state == BallState.FALLING || state == BallState.BEGINNING) && 
        x > to.getX() && x < to.getX() + to.getWidth() &&
        y - dy > to.getY() - tamanhoBola / 2 && y - dy < to.getY() + tamanhoBola / 2) {

      platmove = to;
      y = to.y - tamanhoBola / 2;
      dy = 0;
      state = BallState.HASPLATMOVE;
      return true;
    }
    return false;
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
  
  Boolean collided(BaseEnemyObject enemy) {
    float middleRadio = cos(45)*tamanhoBola/2;
    // Pontos: 0°, 315°, 270°, 225°, 180°, 135°, 90°, 45°
    
    Boolean p1 = enemy.isCollision(this.x + tamanhoBola/2, this.y - dy);
    Boolean p2 = p1 || enemy.isCollision(this.x + middleRadio, this.y - middleRadio - dy);
    Boolean p3 = p2 || enemy.isCollision(this.x, this.y - tamanhoBola/2 - dy);
    Boolean p4 = p3 || enemy.isCollision(this.x - middleRadio, this.y - middleRadio - dy);
    Boolean p5 = p4 || enemy.isCollision(this.x - tamanhoBola/2, this.y - dy);
    Boolean p6 = p5 || enemy.isCollision(this.x - middleRadio, this.y + middleRadio - dy);
    Boolean p7 = p6 || enemy.isCollision(this.x, this.y + tamanhoBola/2 - dy);
    Boolean p8Colision = p7 || enemy.isCollision(this.x + middleRadio, this.y + middleRadio - dy);
    
    return p8Colision;
  }
  
  Boolean hasKey() {
    return keey != null;
  }
  
  void render() {
    circle(x, y - dy, tamanhoBola);
  }
  
  void mousePressed() { }
  
  void keyPressed() {
    
    switch(keyCode) {
      case 37:
        if (state == BallState.HASPLATFORM || state == BallState.HASPLATMOVE) { 
          direcaoX = -1;
          velX = originVelX;
        }
        break;

       case 39:
        if (state == BallState.HASPLATFORM || state == BallState.HASPLATMOVE) { 
          direcaoX = 1;
          velX = originVelX;
        }
        break;

      case 32:
        if (state == BallState.HASPLATFORM || state == BallState.HASPLATMOVE) { 
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

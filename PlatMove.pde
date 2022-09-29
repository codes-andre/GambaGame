class PlatMove implements GameObject {
  
  private float dx = 0;
  private float dy = 0;
  private float shift = 300;
  private float direcaoY = 1;
  private float vel = 50;
  MovimentDirection direction;
    
  private float x;
  private float y;
  private float w;
  private float h;
    
  
  PlatMove(float x, float y, float w, float h, MovimentDirection direction){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;    
    this.direction = direction;
  }
  
  float getX() { return this.x; }
  float getY() { return this.y; }
  float getWidth() { return this.w; }
  
  Boolean isHorizontallyOut(float x) {
  return x < this.x || x > this.x + this.w;
  }
  
    // GameObject
    
  void update(float elapsedTime) {
   
    switch(direction) {
    case VERTICAL:
      y += elapsedTime * direcaoY * vel;
      dy += elapsedTime * direcaoY * vel;
      if (dy > shift) {
        direcaoY = -1;
      }
        
      if (dy < 0) {
        direcaoY = 1;
      }
        
      break;
    case HORIZONTAL: break;
    }
  }
  
  void render() {
    rect(x + dx, y, w, h);
  }
    
    // BaseEnemyObject
  Image getImage() {
    return new Image(loadImage("cloud.png"), x, y, 50, 50);
  }
    
  Boolean isCollision(float x, float y) {
    return (x > realY() && x < realY() + this.w && y > this.y && y < this.y + this.h);
  }
    
    // Private Methods
    
  private float realY() {
    return x + dy;
   }
}

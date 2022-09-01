class Platform implements GameObject {

  private float x;
  private float y;
  private float w = 300;
  private float h = 20;
 
  Platform(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  float getX() { return this.x; }
  float getY() { return this.y; }
  float getWidth() { return this.w; }
  
  void update(float elapsedTime) {
  
  }
  
  void render() {
    rect(x, y, w, h);
  }

  Boolean isHorizontallyOut(float x) {
    return x < this.x || x > this.x + this.w;
  }
}

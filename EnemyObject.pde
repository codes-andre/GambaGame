class EnemyObject implements GameObject {
  private float x;
  private float y;
  private float w;
  private float h;
 
  EnemyObject(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void update(float elapsedTime) {

  }

  void render() {
    rect(x, y, w, h);
  }
  
  Boolean isCollision(float x, float y) {
    return (x > this.x && x < this.x + this.w && y > this.y && y < this.y + this.h);
  }
  
  float getX() { return this.x; }
}

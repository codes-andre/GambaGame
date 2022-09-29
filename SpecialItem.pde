class SpecialItem implements GameObject {

  private float x;
  private float y;
  private float w;
  private float h;
  
  public ItemType type;
  boolean wasAquired;

  SpecialItem(float x, float y, float w, float h, ItemType type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }
  
  float getX() { return this.x; }
  float getY() { return this.y; }
  float getWidth() { return this.w; }
  
  void update(float elapsedTime) { }

  void render() {
    noStroke();
    noFill();
    rect(x, y, w, h);
  }
  
  Image getImage() {
    String name = "";
    
    switch(type){
    case KEY:
      name = "key.png";
      break;
    case DOOR:
      name = "door.png";
      break;
    }
    return new Image(loadImage(name), x, y, w, h);
  }
}

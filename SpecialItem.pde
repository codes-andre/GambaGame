class SpecialItem implements GameObject {

  private float x;
  private float y;
  private float w;
  private float h;
  
  private ItemType type;

  SpecialItem(float x, float y, float w, float h, ItemType type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }
  
  void update(float elapsedTime) { }

  void render() {
    rect(x, y, w, h);
  }
  
}

class Image {
  
  PImage image;
  float x;
  float y;
  float h;
  float w;
  
  Image(PImage image, float x, float y, float w, float h) {
    this.image = image;
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }
}

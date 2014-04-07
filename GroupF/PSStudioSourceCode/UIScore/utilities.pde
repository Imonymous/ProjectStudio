// ************************************************************************ COLORS 
color black=#000000, white=#FFFFFF, // set more colors using Menu >  Tools > Color Selector
   red=#FF0000, grey=#818181, green=#00FF01, blue=#0300FF, yellow=#FEFF00, cyan=#00FDFF, magenta=#FF00FB;

// ************************************************************************ GRAPHICS 
void pen(color c, float w) {stroke(c); strokeWeight(w);}
void showDisk(float x, float y, float r) {ellipse(x,y,r*2,r*2);}


// ************************************************************************ FILES 
String path="data/pts"; 
void saveToFile(File selection) {
  if (selection == null) println("Window was closed or the user hit cancel.");
  else path=selection.getAbsolutePath();
  println("    save path = "+path);
  }

void readFromFile(File selection) {
  if (selection == null) println("Window was closed or the user hit cancel or file not found.");
  else path=selection.getAbsolutePath();
  println("    read path = "+path);
  }



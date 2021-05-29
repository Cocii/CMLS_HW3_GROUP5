import controlP5.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ControlP5 cp5;
Knob master_knob;
Knob attack_knob;
Knob release_knob;
PFont CmlsFont;
float master0;
float attack0;
float release0;
float master1;
float attack1;
float release1;
float master2;
float attack2;
float release2;
float master3;
float attack3;
float release3;
int knobColorBackground;
int knobColorForeground;
int knobColorActive;
int knobColorCaptionLabel;
int ColorBackground;

void setup() {
  knobColorBackground = color(207,240,158);
  knobColorForeground = color(121,189,154);
  knobColorActive = color(168,219,168);
  knobColorCaptionLabel = color(59,134,134);
 
  size(600, 800);
  background(255);

  smooth();

  noStroke();
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  cp5 = new ControlP5(this);
  //CmlsFont = createFont("CMLS.ttf",60);
  //textFont(CmlsFont);

//**************************** risset knob ****************************
  master_knob = cp5.addKnob("master0")
     .setPosition(returnX(12), returnY(6))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 1)
     .setValue(1)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  attack_knob = cp5.addKnob("attack0")
     .setPosition(returnX(40), returnY(6))
     .setSize(returnX(20),returnY(15))
     .setRange(0, 0.5)
     .setRadius(50)
     .setValue(0.005)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  release_knob = cp5.addKnob("release0")
     .setPosition(returnX(68), returnY(6))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 2)
     .setValue(2)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
//**************************** piano knob ****************************

  master_knob = cp5.addKnob("master1")
     .setPosition(returnX(12), returnY(30))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 1)
     .setValue(1)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  attack_knob = cp5.addKnob("attack1")
     .setPosition(returnX(40), returnY(30))
     .setSize(returnX(20),returnY(15))
     .setRange(0, 1)
     .setRadius(50)
     .setValue(0.02)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  release_knob = cp5.addKnob("release1")
     .setPosition(returnX(68), returnY(30))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 1)
     .setValue(0.2)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);

//**************************** bass knob ****************************

  master_knob = cp5.addKnob("master2")
     .setPosition(returnX(12), returnY(54))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 1)
     .setValue(1)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  attack_knob = cp5.addKnob("attack2")
     .setPosition(returnX(40), returnY(54))
     .setSize(returnX(20),returnY(15))
     .setRange(0, 1)
     .setRadius(50)
     .setValue(0.02)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  release_knob = cp5.addKnob("release2")
     .setPosition(returnX(68), returnY(54))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 1)
     .setValue(0.2)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
//**************************** nleep knob ****************************

  master_knob = cp5.addKnob("master3")
     .setPosition(returnX(12), returnY(78))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 1)
     .setValue(1)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  attack_knob = cp5.addKnob("attack3")
     .setPosition(returnX(40), returnY(78))
     .setSize(returnX(20),returnY(15))
     .setRange(0, 1)
     .setRadius(50)
     .setValue(0.02)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
     
  release_knob = cp5.addKnob("release3")
     .setPosition(returnX(68), returnY(78))
     .setSize(returnX(20),returnY(15))
     .setRadius(50)
     .setRange(0, 1)
     .setValue(0.2)
     .setColorForeground(knobColorBackground)
     .setColorBackground(knobColorForeground)
     .setColorActive(knobColorActive)
     .setColorCaptionLabel(knobColorCaptionLabel);
}

void draw() {
  ColorBackground = color(255,235,205);
  background(ColorBackground);
  stroke(knobColorCaptionLabel);
  fill(ColorBackground);
  strokeWeight(2);
  //rect(returnX(5), returnY(2), returnX(90), returnY(96), 10);
  rect(returnX(5), returnY(4), returnX(90), returnY(20), 10);
  rect(returnX(5), returnY(28), returnX(90), returnY(20), 10);
  rect(returnX(5), returnY(52), returnX(90), returnY(20), 10);
  rect(returnX(5), returnY(76), returnX(90), returnY(20), 10);
  
  textSize(22);
  fill(0,0,0);
  //textAlign(CENTER);
  text("Risset", returnX(43), returnY(23));
  
  textSize(22);
  fill(0,0,0);
  text(" Piano", returnX(42), returnY(47));
  
  textSize(22);
  fill(0,0,0);
  text("Bass", returnX(44), returnY(71));
  
  textSize(22);
  fill(0,0,0);
  text(" Bleep", returnX(42), returnY(95));
}


//ControlP5 ControlEvent.
 //every control event is automatically forwarded to the function controlEvent(ControlEvent)
 //inside a sketch if such function is available. 
 
void controlEvent(ControlEvent theEvent) {
  OscMessage myMessage = new OscMessage("/knob");
  
  myMessage.add(master0);
  myMessage.add(attack0);
  myMessage.add(release0);
  
  myMessage.add(master1);
  myMessage.add(attack1);
  myMessage.add(release1);
  
  myMessage.add(master2);
  myMessage.add(attack2);
  myMessage.add(release2);
  
  myMessage.add(master3);
  myMessage.add(attack3);
  myMessage.add(release3);
  oscP5.send(myMessage, myRemoteLocation); 
  myMessage.print();
  
  
}

int returnX(int value){
  return (value * width)/100;
}

int returnY(int value){
  return (value * height)/100;
}

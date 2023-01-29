#include <SPI.h>
#define xAxis 14  // A0 for Arduino UNO
#define yAxis 15  // A1 for Arduino UNO

//Botones de la joystick Shield Game
int buttonUp = 2;
int buttonRight = 3;
int buttonDown = 4;
int buttonLeft = 5;

const byte identificacion[6] = "00001";

void setup() {
  Serial.begin(9600);
  //Declaramos los botones en modo PULL_UP
  pinMode(buttonUp, INPUT_PULLUP);
  pinMode(buttonRight, INPUT_PULLUP);
  pinMode(buttonDown, INPUT_PULLUP);
  pinMode(buttonLeft, INPUT_PULLUP);

  //Inicializamos los estados de los botones
  digitalWrite(buttonUp, LOW);
  digitalWrite(buttonRight, LOW);
  digitalWrite(buttonDown, LOW);
  digitalWrite(buttonLeft, LOW);
  Serial.begin(9600);
}

void loop() {
  GetLectura();
  delay(50);
}

void GetLectura() {
  if (analogRead(xAxis) > 900) {
    Serial.print('r');
  } else if (analogRead(xAxis) < 100) {
    Serial.print('l');
  } else if (analogRead(yAxis) > 900) {
    Serial.print('u');
  } else if (analogRead(yAxis) < 100) {
    Serial.print('d');
  }
  if (digitalRead(buttonUp) == 0) {
    Serial.print('x');
  } else if (digitalRead(buttonRight) == 0) {
    Serial.print('a');
    delay(200);
  } else if (digitalRead(buttonDown) == 0) {
    Serial.print('b');
    delay(200);
  } else if (digitalRead(buttonLeft) == 0) {
    Serial.print('y');
  }
}
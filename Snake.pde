//panel = 5
int angle = 0;
int snakesize;   //tamaño de la serpiente
int time, manzanitas, velocidad;     //cada cuanto se hace el desplazamiento y el contador de las manzanas
//vectores para saber donde está el cuerpo de la serpiente
int[] headx = new int[2500];
int[] heady = new int[2500];
int applex = (round(random(47)) + 1) * 8;
int appley = (round(random(47)) + 1) * 8;
//booleanos para saber si se vuelve a generar una manzana y si se detiene el juego
boolean redo = true;
boolean stopgame = true, dead = false;

void snake_setup() {
  restart();
  textAlign(CENTER);
  time = 0;
  manzanitas = 0;
  velocidad = 7;
}

void snake() {
  //Contador de manzanas
  image(apple, width - 60, -20);
  textFont(font);
  fill(0);
  noStroke();
  text(manzanitas, width - 55, 35);

  //Se lee el arduino
  try {
    if (joystick.available() > 0) {
      try {
        val = joystick.lastChar();
        keyPressedS(val);
      }
      catch (Exception e) {
      }
    }
  }
  catch (Exception a) {
  }

  keyPressedS();
  if (!stopgame) {
    time += 1;
    image(apple, applex - 22, appley - 34);
    if ((time % velocidad) == 0) {
      travel();
      display();
      checkdead();
    }
  } else {
    background(249, 212, 34);
    pausa();
    textFont (tipoLetra, 230);
    if (!dead) {
      fill(227, 6, 19);
      text("PAUSE", width/2 - 493, height/ 2 - 259, 1000, 1000);
      fill(255);
      text("PAUSE", width/2 - 483, height/ 2 - 259, 1000, 1000);
      fill(0);
      text("PAUSE", width/2 - 488, height/ 2 - 259, 1000, 1000);
    } else {
      textFont (tipoLetra, 230);
      fill(227, 6, 19);
      text("GAME OVER", width/2 - 493, height/ 2 - 259, 1000, 1000);
      fill(255);
      text("GAME OVER", width/2 - 483, height/ 2 - 259, 1000, 1000);
      fill(0);
      text("GAME OVER", width/2 - 488, height/ 2 - 259, 1000, 1000);
      switch(avatar) {
      case 1:
        image(alejo_snake, width/2, height - 600, 600, 600);
        break;
      case 2:
        image(aleja_snake, width/2, height - 600, 600, 600);
        break;
      case 3:
        image(juanmi_snake, width/2, height - 600, 600, 600);
        break;
      }
    }

    fill(227, 6, 19);
    stroke(255);
    //Cambio de pulsor del mouse de arrow a mano
    if (overButton == false) {
      noCursor();
      ellipse(mouseX, mouseY, 10, 10);
    } else {
      noCursor();
      triangle(mouseX - 10, mouseY + 15, mouseX, mouseY, mouseX + 10, mouseY + 15);
      overButton = false;
    }
  }
}

//controles con teclas
public void keyPressedS() {
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP && angle != 270 && (heady[1] - 8) != heady[2]) {
        angle = 90;
      }
      if (keyCode == DOWN && angle != 90 && (heady[1] + 8) != heady[2]) {
        angle = 270;
      }
      if (keyCode == LEFT && angle != 0 && (headx[1] - 8) != headx[2]) {
        angle = 180;
      }
      if (keyCode == RIGHT && angle != 180 && (headx[1] + 8) != headx[2]) {
        angle = 0;
      }
      if (keyCode == SHIFT) {
        //Se reinicia el juego presionando shift
        restart();
      }
      if (keyCode == CONTROL) {
        stopgame = !stopgame;
        background(249, 212, 34);
        delay(200);
      }
    }
  }
}

//Controles con Arduino
public void keyPressedS(char val) {
  if (val == 'u' && angle != 270 && (heady[1] - 8) != heady[2]) {
    angle = 90;
  } else if (val == 'd' && angle != 90 && (heady[1] + 8) != heady[2]) {
    angle = 270;
  } else if (val == 'l' && angle != 0 && (headx[1] - 8) != headx[2]) {
    angle = 180;
  } else if (val == 'r' && angle != 180 && (headx[1] + 8) != headx[2]) {
    angle = 0;
  } else if (val == 'x') {
    restart();
  } else if (val == 'b') {
    stopgame = !stopgame;
    background(249, 212, 34);
    delay(200);
  }
}

//Subrutina para mover a la serpiente
void travel() {
  for (int i = snakesize; i > 0; i--) {
    if (i != 1) {
      headx[i] = headx[i - 1];
      heady[i] = heady[i - 1];
    } else {
      switch (angle) {
      case 0:
        headx[1] += 24;
        break;
      case 90:
        heady[1] -= 24;
        break;
      case 180:
        headx[1] -= 24;
        break;
      case 270:
        heady[1] += 24;
        break;
      }
    }
  }
}

//Subrutina para imprimir la manzana y la serpiente
void display() {
  //Condicional para saber si se está comiendo la manzana
  if ((headx[1] <= applex + 22 && headx[1] >= applex) && (heady[1] <= appley + 22 && heady[1] >= appley)) {
    fill(249, 212, 34);
    rect(width - 65, 0, 30, 40);
    snakesize += 1;
    manzanitas++;
    if (manzanitas % 5 == 0 && velocidad > 1) {
      velocidad--;
    }
    redo = true;
    //Mientras que se esté comiendo a la manzana se vuelve a hacer
    while (redo) {
      applex = (round(random(width/24 - 10)) + 1) * 24;
      appley = (round(random(height/24 - 10)) + 1) * 24;
      for (int i = 1; i < snakesize; i++) {
        if ((headx[1] <= applex + 22 && headx[1] >= applex) && (heady[1] <= appley + 22 && heady[1] >= appley)) {
          redo = true;
        } else {
          redo = false;
          i = 1000;
        }
      }
    }
  }

  //Se dibuja la cabeza de la serpiente
  image(snkhd, headx[1], heady[1]);
  //se borra la cola
  fill(249, 212, 34);
  noStroke();
  rect(headx[snakesize], heady[snakesize] - 1, 24, 24);
}

//Se revisa si moriste
void checkdead() {
  for (int i = 2; i <= snakesize; i++) {
    //Si la cabeza se está comiendo el cuerpo
    if (headx[1] == headx[i] && heady[1] == heady[i]) {
      stopgame = true;
      dead = true;
      switch(avatar) {
      case 1:
        image(alejo_snake, width/2 - 300, height - 600, 600, 600);
        break;
      case 2:
        image(aleja_snake, width/2 - 300, height - 600, 600, 600);
        break;
      case 3:
        image(juanmi_snake, width/2 - 300, height - 600, 600, 600);
        break;
      }
    }
    //Si la cabeza choca contra las paredes
    if (headx[1] >= (width - 8) || heady[1] >= (height - 8) || headx[1] <= 0 || heady[1] <= 0) {
      stopgame = true;            //el juego se detiene
      dead = true;
      switch(avatar) {
      case 1:
        image(alejo_snake, width/2 - 300, height - 600, 600, 600);
        break;
      case 2:
        image(aleja_snake, width/2 - 300, height - 600, 600, 600);
        break;
      case 3:
        image(juanmi_snake, width/2 - 300, height - 600, 600, 600);
        break;
      }
    }
  }
}

//Genera la serpiente y la manzana aleatoriamente
void restart() {
  background(249, 212, 34);
  headx[1] = (round(random(width/24 - 10)) + 1) * 24;
  heady[1] = (round(random(height/24 - 10)) + 1) * 24;
  for (int i = 2; i < 1000; i++) {
    headx[i] = 0;
    heady[i] = 0;
  }

  //Vuelve a iniciar el juego
  stopgame = false;
  applex = (round(random(width/24 - 10)) + 1) * 24;
  appley = (round(random(height/24 - 10)) + 1) * 24;
  snakesize = 2;
  time = 0;
  angle = 0;
  redo = true;
  manzanitas = 0;
  dead = false;
}

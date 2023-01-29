/**
 *
 * @authors Juan Carrasquilla, Alejandro Toro & Alejandra Valencia
 */

import processing.sound.*;
import processing.serial.*;
import static processing.serial.Serial.list;

SoundFile click;
Serial joystick;
int panel = 1, avatar, game;
float speed;
PFont tipoLetra, font;
PImage icon, moneda, instagram, instagram_white, youtube, youtube_white, web, web_white, back, back_white, next, next_white,
  alejo, alejo_, aleja, aleja_, juanmi, juanmi_, exit, exit_white, snkhd, apple, snkhd_big, laberinto, pared, piso,
  personaje_alejo, personaje_aleja, personaje_juanmi, meta, llave, llaveG, tesoro, tesoroG, aleja_snake, alejo_snake, juanmi_snake, alejo_llave2, alejo_llave1,
  aleja_llave2, aleja_llave1, juanmi_llave2, juanmi_llave1;
String[] images = {"icono.png", "coin.png", "ig.png", "ig_.png", "yt.png", "yt_.png", "web.png", "web_.png", "back.png", "back_.png", "next.png", "next_.png",
  "alejo.png", "alejo_.png", "aleja.png", "aleja_.png", "juanmi.png", "juanmi_.png", "exit.png", "exit_.png", "snkhead3.png", "apple.png", "snkhead_big.png", "Lab.png",
  "pared.png", "piso.png", "personaje_alejo.png", "personaje_aleja.png", "personaje_juanmi.png", "meta.png", "llave.png", "llaveG.png", "tesoro.png", "tesoroG.png",
  "aleja_snake.png", "alejo_snake.png", "juanmi_snake.png", "juanmi_llave1.png", "juanmi_llave2.png", "alejo_llave1.png", "alejo_llave2.png", "aleja_llave1.png",
  "aleja_llave2.png"};
String[] sonido = {"click.mp3"};
boolean overButton = false, mouse = false, setupS = true, setupL = true, arduino = true;
char val;

void setup() {
  fullScreen();
  background(249, 212, 34);
  surface.setTitle("Arkad");
  surface.setResizable(false);

  //Llamamos a la clase coin para generar un movimiento de las monedas
  moneda = loadImage(images[1]);
  for (int i = 0; i < coin.length; i++) {
    coin[i] = new coins();
  }

  //Cargamos tipos de letras
  tipoLetra = createFont("American Captain.otf", 200);
  textFont(tipoLetra, 200);
  textAlign(CENTER);
  font = createFont("andalemo.ttf", 24);

  //Cargamos imágenes desde archivos
  icon = loadImage(images[0]);
  surface.setIcon(icon);
  instagram = loadImage(images[2]);
  instagram_white = loadImage(images[3]);
  youtube = loadImage(images[4]);
  youtube_white = loadImage(images[5]);
  web = loadImage(images[6]);
  web_white = loadImage(images[7]);
  back = loadImage(images[8]);
  back_white = loadImage(images[9]);
  next = loadImage(images[10]);
  next_white = loadImage(images[11]);
  alejo = loadImage(images[12]);
  alejo_ = loadImage(images[13]);
  aleja = loadImage(images[14]);
  aleja_ = loadImage(images[15]);
  juanmi = loadImage(images[16]);
  juanmi_ = loadImage(images[17]);
  exit = loadImage(images[18]);
  exit_white = loadImage(images[19]);
  snkhd = loadImage(images[20]);
  apple = loadImage(images[21]);
  snkhd_big = loadImage(images[22]);
  laberinto = loadImage(images[23]);
  pared = loadImage(images[24]);
  piso = loadImage(images[25]);
  personaje_alejo = loadImage(images[26]);
  personaje_aleja = loadImage(images[27]);
  personaje_juanmi = loadImage(images[28]);
  meta = loadImage(images[29]);
  llave = loadImage(images[30]);
  llaveG = loadImage(images[31]);
  tesoro = loadImage(images[32]);
  tesoroG = loadImage(images[33]);
  aleja_snake = loadImage(images[34]);
  alejo_snake = loadImage(images[35]);
  juanmi_snake = loadImage(images[36]);
  juanmi_llave1 = loadImage(images[37]);
  juanmi_llave2 = loadImage(images[38]);
  alejo_llave1 = loadImage(images[39]);
  alejo_llave2 = loadImage(images[40]);
  aleja_llave1 = loadImage(images[41]);
  aleja_llave2 = loadImage(images[42]);

  //Cargamos archivos de sonido
  click = new SoundFile(this, sonido[0]);
  click.amp(0.1);
  click.rate(2);
}
coins[] coin = new coins[500];    //Vector con la imagen de la moneda

void draw() {
  if (arduino) {
    //Puerto serial arduino
    try {
      joystick = new Serial(this, list()[0], 9600); //puerto serial arduino
      arduino = false;
    }
    catch (Exception e) {
    }
  }

  //Procedimientos para mover aleatoriamente la imagen de las monedas
  speed = map(10, 0, width, 0, 100);
  if (setupS && setupL) {
    background(249, 212, 34);
    translate(0, 0);
    for (int i = 0; i < coin.length; i++) {
      coin[i].update();
      coin[i].show();
    }
  }

  //Condicional para conexión entre ventanas
  if (panel == 1) {
    Inicio();  //Procedimiento de la ventana principal
    setupS = true;
    setupL = true;
  } else if (panel == 2) {
    //Ventana para escoger el personaje
    avatars();
  } else if (panel == 3) {
    //Ventana de créditos
    credits();
  } else if (panel == 4) {
    //Ventana para escoger el juego
    opciones();
    if (mouseX > width / 2 - 523 & mouseX < width / 2 - 123 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
      //Game Snake
      overButton = true;
      if (mousePressed) {
        game = 1;
        click.play();
      }
    } else if (mouseX > width / 2 + 117 & mouseX < width / 2 + 517 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
      //Game Laberinto
      overButton = true;
      if (mousePressed) {
        game = 2;
        click.play();
      }
    } else if (mouseX > width / 2 + 632 & mouseX < width / 2 + 682 & mouseY > 0 & mouseY < 50) {
      //Salir del programa
      overButton = true;
      if (mousePressed) {
        click.play();
        exit();
      }
    } else if (game == 1 & mouseX > width / 2 + 617 & mouseX < width / 2 + 677 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
      //Continúa a la ventana de Snake
      overButton = true;
      if (mousePressed) {
        click.play();
        panel = 5;
      }
    } else if (game == 2 & mouseX > width / 2 + 617 & mouseX < width / 2 + 677 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
      //Continúa a la ventana del Laberinto
      overButton = true;
      if (mousePressed) {
        click.play();
        panel = 6;
      }
    } else {
      overButton = false;
    }
  } else if (panel == 5) {
    //Setup de Snake
    if (setupS) {
      snake_setup();
      setupS = false;
    }
    snake();
  } else if (panel == 6) {
    //Dificultades del Laberinto
    dificultades();
  } else if (panel == 7) {
    //Setup del Laberinto
    if (setupL) {
      lab_setup();
      setupL = false;
    }
    laberinto();
  }

  fill(227, 6, 19);
  stroke(255);
  //Cambio de pulsor del mouse de arrow a mano
  if (overButton == false) {
    if (panel != 5 & panel != 7) {
      noCursor();
      ellipse(mouseX, mouseY, 10, 10);
    }
  } else {
    if (panel != 5 & panel != 7) {
      noCursor();
      triangle(mouseX - 10, mouseY + 15, mouseX, mouseY, mouseX + 10, mouseY + 15);
      overButton = false;
    }
  }
}

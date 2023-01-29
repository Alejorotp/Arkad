class coins {
  float x, x1, y1, y, z, px, py, pz;
  coins() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    pz = z;
  }

  void update() {
    z = z - speed;
    if (z < 1) {
      z = width;
      x = random(-width, width);
      y = random(-height, height);
      pz = z;
    }
  }

  void show() {
    fill(255);
    noStroke();
    float sx = map(x/z, 0, 1, 0, width);
    float sy = map(y/z, 0, 1, 0, height);
    float r = map(z, 0, width, 16, 0);
    r += 25;
    image(moneda, sx, sy, r, r);
    float px = map(x/pz, 0, 1, 0, width);
    float py = map(y/pz, 0, 1, 0, height);
    pz = z;
    stroke(255);
    line(px, py, sx, sy);
  }
}

//Panel = 1
void Inicio() {
  //Título principal
  textFont (tipoLetra, 230);
  fill(227, 6, 19);
  text("ARKAD", width/2 - 493, height/ 2 - 259, 1000, 1000);
  fill(255);
  text("ARKAD", width/2 - 483, height/ 2 - 259, 1000, 1000);
  fill(0);
  text("ARKAD", width/2 - 488, height/ 2 - 259, 1000, 1000);

  //Botón de Inicio
  if (mouseX > width/ 2 - 103 & mouseX < width/ 2 - 103 + 210 & mouseY > height/ 2 - 34 & mouseY < height/ 2 - 34 + 70) {
    fill(255);
  } else {
    fill(0);
  }
  
  noStroke();
  rect(width/ 2 - 103, height/ 2 - 34, 210, 70, 25);
  if (mouseX > width/ 2 - 103 & mouseX < width/ 2 - 103 + 210 & mouseY > height/ 2 - 34 & mouseY < height/ 2 - 34 + 70) {
    fill(0);
    overButton = true;
    if (mousePressed) {
      click.play();
      panel = 2;      //Ventana para personajes
      delay(200);
    }
  } else {
    fill(255);
  }
  textFont(tipoLetra, 60);
  text("INICIO", width/ 2 - 145, height/2 - 22, 300, 300);

  //Botón de Créditos
  if (mouseX > width/ 2 - 103 & mouseX < width/ 2 - 103 + 210 & mouseY > height/ 2 + 66 & mouseY < height/ 2 + 66 + 70) {
    fill(255);
  } else {
    fill(0);
  }
  noStroke();
  rect(width/ 2 - 103, height/ 2 + 66, 210, 70, 25);
  if (mouseX > width/ 2 - 103 & mouseX < width/ 2 - 103 + 210 & mouseY > height/ 2 + 66 & mouseY < height/ 2 + 66 + 70) {
    fill(0);
    overButton = true;
    if (mousePressed) {
      click.play();
      panel = 3;           //Ventana de Créditos
    }
  } else {
    fill(255);
  }
  textFont (tipoLetra, 60);
  text("CRÉDITOS", width/ 2 - 148, height/ 2 +78, 300, 300);

  //Botón de Instagram
  if (mouseX > width/ 2 - 143 & mouseX < width/ 2 - 43 & mouseY > height/ 2 + 176 & mouseY < height/ 2 + 276) {
    image(instagram_white, width/ 2 - 143, height/ 2 + 176, 100, 100);
    overButton = true;
    if (mousePressed) {
      click.play();
      link("https://www.instagram.com/arkadgames_official/");        //Direcciona al link de la página oficial de Instagram
    }
  } else {
    image(instagram, width/ 2 - 143, height/ 2 + 176, 100, 100);
  }

  //Botón de YouTube
  if (mouseX > width/ 2 - 38 & mouseX < width/ 2 + 62 & mouseY > height/ 2 + 176 & mouseY < height/ 2 + 276) {
    image(youtube_white, width/ 2 - 38, height/ 2 + 176, 100, 100);
    overButton = true;
    if (mousePressed) {
      click.play();
      link("https://www.youtube.com/@arkadgames_retro/featured");       //Direcciona al canal de YouTube
    }
  } else {
    image(youtube, width/ 2 - 38, height/ 2 + 176, 100, 100);
  }

  //Botón de Página Web
  if (mouseX > width/ 2 + 67 & mouseX < width/ 2 + 167 & mouseY > height/ 2 + 176 & mouseY < height/ 2 + 276) {
    image(web_white, width/ 2 + 67, height/ 2 + 176, 100, 100);
    overButton = true;
    if (mousePressed) {
      click.play();
      link("https://arkad9.godaddysites.com/");        //Direcciona al link de la página web oficial de Arkad
    }
  } else {
    image(web, width/ 2 + 67, height/ 2 + 176, 100, 100);
  }

  //Botón de Salida
  if (mouseX > width - 51 & mouseX < width - 1 & mouseY > 0 & mouseY < 50) {
    image(exit_white, width - 51, 0, 50, 50);
    overButton = true;
    if (mousePressed) {
      click.play();
      exit();
    }
  } else {
    image(exit, width - 51, 0, 50, 50);
  }
}

//Panel = 2
void avatars() {
  speed = map(10, 0, width, 0, 100);
  background(249, 212, 34);
  translate(0, 0);
  for (int i = 0; i < coin.length; i++) {
    coin[i].update();
    coin[i].show();
  }

  //Seleccionar avatar
  textFont(tipoLetra, 50);
  fill(0);
  text("Selecciona tu avatar:", width/2 - 193, height/2 - 334, 400, 400);

  //Avatar de Alejo
  fill(227, 6, 19);
  textSize(60);
  text("Alejo", width/2 - 401, height/2 - 174);
  fill(255);
  if (avatar == 1) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 - 523, height/2 - 144, 250, 400, 25);
  noStroke();
  if (mouseX > width/2 - 523 & mouseX < width/2 - 273 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
    image(alejo_, width/2 - 688, height/2 - 234, 600, 600);
    overButton = true;
    if (mousePressed) {
      avatar = 1;
      click.play();
    }
  } else {
    image(alejo, width/2 - 688, height/2 - 234, 600, 600);
  }

  //Avatar de Aleja
  fill(227, 6, 19);
  textSize(60);
  text("Aleja", width/2 + 7, height/2 - 174);
  fill(255);
  if (avatar == 2) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 - 118, height/2 - 144, 250, 400, 25);
  noStroke();
  if (mouseX > width/2 - 118 & mouseX < width/2 + 132 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
    image(aleja_, width/2 - 283, height/2 - 234, 600, 600);
    overButton = true;
    if (mousePressed) {
      avatar = 2;
      click.play();
    }
  } else {
    image(aleja, width/2 - 283, height/2 - 234, 600, 600);
  }

  //Avatar de Juanmi
  fill(227, 6, 19);
  textSize(60);
  text("Juanmi", width/2 + 405, height/2 - 174);
  fill(255);
  if (avatar == 3) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 + 277, height/2 - 144, 250, 400, 25);
  noStroke();
  if (mouseX > width/2 + 277 & mouseX < width/2 + 527 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
    image(juanmi_, width/2 + 107, height/2 - 234, 600, 600);
    overButton = true;
    if (mousePressed) {
      avatar = 3;
      click.play();
    }
  } else {
    image(juanmi, width/2 + 107, height/2 - 234, 600, 600);
  }

  //Botón para regresar
  if (mouseX > width/2 - 673 & mouseX < width/2 - 613 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
    image(back_white, width/2 - 673, height/2 + 316, 60, 60);
    overButton = true;
    if (mousePressed) {
      click.play();
      panel = 1;
    }
  } else {
    image(back, width/2 - 673, height/2 + 316, 60, 60);
  }

  if (mouse) {
    //Botón para continuar
    if (mouseX > width/2 + 617 & mouseX < width/2 + 677 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
      image(next_white, width/2 + 617, height/2 + 316, 60, 60);
      overButton = true;
      if (mousePressed) {
        click.play();
        panel = 4;
        delay(200);
      }
    } else {
      image(next, width/2 + 617, height/2 + 316, 60, 60);
    }
  }

  //Botón de Salida
  if (mouseX > width - 51 & mouseX < width - 1 & mouseY > 0 & mouseY < 50) {
    image(exit_white, width - 51, 0, 50, 50);
    overButton = true;
    if (mousePressed) {
      click.play();
      exit();
    }
  } else {
    image(exit, width - 51, 0, 50, 50);
  }
}

//Panel = 3
void credits() {
  speed = map(10, 0, width, 0, 100);
  background(249, 212, 34);
  translate(0, 0);
  for (int i = 0; i < coin.length; i++) {
    coin[i].update();
    coin[i].show();
  }

  textFont (tipoLetra, 200);
  textSize(120);
  fill(227, 6, 19);
  text("Credits", width/2 + 5, height/ 2 - 280);
  fill(255);
  text("Credits", width/2 - 5, height/ 2 - 280);
  fill(0);
  text("Credits", width/2, height/ 2 - 280);

  fill(255);
  textSize(60);
  text("Desarrolladores:", width/2, height/ 2 - 210);
  fill(0);
  textSize(50);
  text("Juan M. Carrasquilla E. --------------  Back end & Front end", width/2, height/ 2 - 145);
  text("Alejandro Toro P. ---------------------  Back end & Front end", width/2, height/ 2 - 75);
  text("Alejandra Valencia R. ----------------  Back end & Front end", width/2, height/ 2 - 5);

  fill(255);
  textSize(60);
  text("class coins:", width/2, height/ 2 + 80);
  fill(0);
  textSize(50);
  text("The Coding Train --------------  Creador de la clase", width/2, height/ 2 + 140);

  fill(255);
  textSize(60);
  text("Con la ayuda de:", width/2, height/ 2 + 230);
  fill(0);
  textSize(50);
  text("Rocio Ramos RodrIguez --------------  Licenciada", width/2, height/ 2 + 300);
  text("Universidad del Norte", width/2, height/ 2 + 360);

  if (mouseX > width/2 - 673 & mouseX < width/2 - 613 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
    image(back_white, width/2 - 673, height/2 + 316, 60, 60);
    overButton = true;
    if (mousePressed) {
      click.play();
      panel = 1;
    }
  } else {
    image(back, width/2 - 673, height/2 + 316, 60, 60);
  }
}

//Panel = 4
void opciones() {
  mouse = false;
  setupS = true;
  setupL = true;

  speed = map(10, 0, width, 0, 100);
  background(249, 212, 34);
  translate(0, 0);
  for (int i = 0; i < coin.length; i++) {
    coin[i].update();
    coin[i].show();
  }

  //Seleccionar juego
  textFont(tipoLetra, 50);
  fill(0);
  text("Selecciona tu juego:", width/2 - 193, height/ 2 - 334, 400, 400);

  //Game: Snake
  fill(227, 6, 19);
  textSize(60);
  text("SNAKE", width/2 - 333, height/ 2 - 174);
  fill(255);
  if (game == 1) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 - 523, height/ 2 - 144, 400, 400, 25);
  noStroke();
  image(snkhd_big, width/2 - 473, height/ 2 - 99, 300, 300);

  //Game: Laberinto
  fill(227, 6, 19);
  textSize(60);
  text("LABERINTO", width/2 + 314, height/ 2 - 174);
  fill(255);
  if (game == 2) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 + 117, height/ 2 - 144, 400, 400, 25);
  noStroke();
  image(laberinto, width/2 + 117, height/ 2 - 144, 400, 400);

  //Botón para regresar
  if (mouseX > width/2 - 673 & mouseX < width/2 - 613 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
    image(back_white, width/2 - 673, height/2 + 316, 60, 60);
    overButton = true;
    if (mousePressed) {
      click.play();
      panel = 2;
      delay(200);
    }
  } else {
    image(back, width/2 - 673, height/2 + 316, 60, 60);
  }

  if (mouse) {
    //Botón para continuar
    if (mouseX > width/2 + 617 & mouseX < width/2 + 677 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
      image(next_white, width/2 + 617, height/2 + 316, 60, 60);
      overButton = true;
      if (mousePressed) {
        click.play();
        panel = 4;
        delay(200);
      }
    } else {
      image(next, width/2 + 617, height/2 + 316, 60, 60);
    }
  }

  //Botón de Salida
  if (mouseX > width - 51 & mouseX < width - 1 & mouseY > 0 & mouseY < 50) {
    image(exit_white, width - 51, 0, 50, 50);
    overButton = true;
    if (mousePressed) {
      click.play();
      exit();
    }
  } else {
    image(exit, width - 51, 0, 50, 50);
  }
}

void pausa() {
  //Botón de Inicio
  if (mouseX > width/ 2 - 103 & mouseX < width/ 2 - 103 + 210 & mouseY > height/ 2 - 34 & mouseY < height/ 2 - 34 + 70) {
    fill(255);
  } else {
    fill(0);
  }
  noStroke();
  rect(width/ 2 - 103, height/ 2 - 34, 210, 70, 25);
  if (mouseX > width/ 2 - 103 & mouseX < width/ 2 - 103 + 210 & mouseY > height/ 2 - 34 & mouseY < height/ 2 - 34 + 70) {
    fill(0);
    overButton = true;
    if (mousePressed) {
      setupS = true;
      setupL = true;
      click.play();
      panel = 1;      //Ventana de Inicio
      delay(200);
    }
  } else {
    fill(255);
  }
  textFont(tipoLetra, 60);
  text("INICIO", width/ 2 - 145, height/2 - 22, 300, 300);
  
  //Botón de Salida
  if (mouseX > width - 51 & mouseX < width - 1 & mouseY > 0 & mouseY < 50) {
    image(exit_white, width - 51, 0, 50, 50);
    overButton = true;
    if (mousePressed) {
      click.play();
      exit();
    }
  } else {
    image(exit, width - 51, 0, 50, 50);
  }
}

void dificultades() {
  speed = map(10, 0, width, 0, 100);
  background(249, 212, 34);
  translate(0, 0);
  for (int i = 0; i < coin.length; i++) {
    coin[i].update();
    coin[i].show();
  }
  //Seleccionar la dificultad
  textFont(tipoLetra, 50);
  fill(0);
  text("Selecciona la dificultad:", width/2 - 183, height/2 - 334, 500, 500);
  //Avatar de Alejo
  fill(255);
  if (dificultad == 1) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 - 523, height/2 - 75, 250, 100, 25);
  noStroke();
  fill(227, 6, 19);
  textSize(60);
  text("FACILITO", width/2 - 401, height/2);
  if (mouseX > width/2 - 523 & mouseX < width/2 - 273 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
    overButton = true;
    if (mousePressed) {
      dificultad = 1;
      n = 2;
      m = 2;
      click.play();
    }
  }

  //Medio
  fill(255);
  if (dificultad == 2) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 - 118, height/2 - 75, 250, 100, 25);
  noStroke();
  fill(227, 6, 19);
  textSize(60);
  text("MEDIO", width/2, height/2);
  if (mouseX > width/2 - 118 & mouseX < width/2 + 132 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
    overButton = true;
    if (mousePressed) {
      dificultad = 2;
      n = 10;
      m = 5;
      click.play();
    }
  }

  //HARD
  fill(255);
  if (dificultad == 3) {
    stroke(0);     //Borde al seleccionar
    mouse = true;
  }
  rect(width/2 + 277, height/2 - 75, 250, 100, 25);
  noStroke();
  fill(227, 6, 19);
  textSize(60);
  text("DIFICIL", width/2 + 401, height/2);
  if (mouseX > width/2 + 277 & mouseX < width/2 + 527 & mouseY > height/2 - 144 & mouseY < height/2 + 256) {
    overButton = true;
    if (mousePressed) {
      dificultad = 3;
      n = 20;
      m = 10;
      click.play();
    }
  }

  //Botón para regresar
  if (mouseX > width/2 - 673 & mouseX < width/2 - 613 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
    image(back_white, width/2 - 673, height/2 + 316, 60, 60);
    overButton = true;
    if (mousePressed) {
      click.play();
      panel = 4;
      delay(200);
    }
  } else {
    image(back, width/2 - 673, height/2 + 316, 60, 60);
  }

  if (mouse) {
    //Botón para continuar
    if (mouseX > width/2 + 617 & mouseX < width/2 + 677 & mouseY > height/2 + 316 & mouseY < height/2 + 376) {
      image(next_white, width/2 + 617, height/2 + 316, 60, 60);
      overButton = true;
      if (mousePressed) {
        click.play();
        panel = 7;
      }
    } else {
      image(next, width/2 + 617, height/2 + 316, 60, 60);
    }
  }

  //Botón de Salida
  if (mouseX > width - 51 & mouseX < width - 1 & mouseY > 0 & mouseY < 50) {
    image(exit_white, width - 51, 0, 50, 50);
    overButton = true;
    if (mousePressed) {
      click.play();
      exit();
    }
  } else {
    image(exit, width - 51, 0, 50, 50);
  }
}

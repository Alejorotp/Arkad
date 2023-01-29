//panel = 6
int[][] matrix;
int n = 0, m = 0, movx, movy, antpx, antpy, dificultad = 2, niveles, Ntesoro, tesorox, tesoroy, stackx, stacky;
int pilaxv[] = new int [10000];
int pilayv[] = new int [10000];
boolean keys[], llave_Azar, tesoroB, paus;

void lab_setup() {
  niveles = 0;
  Ntesoro=0;
  keys = new boolean[2];
  nextlevel();
  llave_Azar = true;
  tesoroB = true;
  stackx = 0;
  stacky = 0;
  paus = true;
}

void laberinto() {
  if (paus) {
    dificultad(true);

    //Dibuja el número de llaves
    if (keys[0] | keys[1]) {
      image(llaveG, 5, 3);
      if (keys[0] & keys[1]) {
        image(llaveG, 60, 3);
      }
    }

    //Dibuja el nivel actual
    fill(255);
    rect(width/2 - 100, 3, 100, 40);
    fill(0);
    textSize(24);
    text("Nivel " + niveles, width/2 - 50, 30);
    //Dibuja el numero de tesoros
    image(tesoroG, 400, 3);
    fill(0);
    textSize(24);
    text(Ntesoro, 380, 35);

    //Se lee el arduino
    try {
      if (joystick.available() > 0) {
        try {
          val = joystick.lastChar();
          keyPressed(val);
        }
        catch (Exception e) {
        }
      }
    }
    catch (Exception a) {
    }

    if (tesoroB) {
      if (movx==tesorox && movy==tesoroy) {
        Ntesoro++;
        tesoroB=false;
      }
    }

    //Cambia al personaje de posición si se movió
    matrix[antpx][antpy] = 3;
    matrix[movx][movy] = 7;
    //imprime el laberinto
    for (int i=0; i<n*2+1; i++ ) {
      for (int j=0; j<m*2+1; j++) {
        if (matrix[i][j] == 1 || matrix[i][j] == 0) {
          image(pared, 25 + i * 25, 25 + j * 25);
        } else if (movx == i && movy == j && matrix[i][j] == 7) {
          switch(avatar) {
          case 1:
            image(personaje_alejo, 22 + i * 25, 25 + j * 25);
            break;
          case 2:
            image(personaje_aleja, 22 + i * 25, 25 + j * 25);
            break;
          case 3:
            image(personaje_juanmi, 22 + i * 25, 25 + j * 25);
            break;
          }
        } else if (i==n*2-1 && j==m*2-1) {
          image(meta, 22 + i * 25, 25 + j * 25);
        } else if (matrix[i][j] == 3 || matrix[i][j] == 4 || matrix[i][j] == 5) {
          image(piso, 22 + i * 25, 25 + j * 25);
        } else if (matrix[i][j] == 9) {
          image(llave, 22 + i * 25, 25 + j * 25);
        } else if (matrix[i][j]==10) {
          image(tesoro, 22 + i * 25, 25 + j * 25);
        } else {
          image(piso, 22 + i * 25, 25 + j * 25);
        }
      }
    }
    dificultad(false);
  } else {
    try {
      if (joystick.available() > 0) {
        try {
          val = joystick.lastChar();
          keyPressed(val);
        }
        catch (Exception e) {
        }
      }
    }
    catch (Exception a) {
    }
    background(249, 212, 34);
    pausa();
    textFont (tipoLetra, 230);
    fill(227, 6, 19);
    text("PAUSE", width/2 - 493, height/ 2 - 259, 1000, 1000);
    fill(255);
    text("PAUSE", width/2 - 483, height/ 2 - 259, 1000, 1000);
    fill(0);
    text("PAUSE", width/2 - 488, height/ 2 - 259, 1000, 1000);
    fill(227, 6, 19);
    stroke(255);
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

//Controles con teclas
void keyPressed() {
  if (key == 'w') {
    if (matrix[movx][movy - 1] != 1 && matrix[movx][movy - 1] != 0) {
      antpy = movy;
      antpx = movx;
      movy -= 1;
    }
  } else if (key == 's') {
    if (matrix[movx][movy + 1] != 1 && matrix[movx][movy + 1] != 0) {
      antpy = movy;
      antpx = movx;
      movy += 1;
    }
  } else if (key == 'a') {
    if (matrix[movx - 1][movy] != 1 && matrix[movx - 1][movy] != 0) {
      antpy = movy;
      antpx = movx;
      movx -= 1;
    }
  } else  if (key == 'd') {
    if (matrix[movx + 1][movy] != 1 && matrix[movx + 1][movy] != 0) {
      antpy = movy;
      antpx = movx;
      movx += 1;
    }
  } else if (key == 'p') {
    paus = !paus;
    delay(200);
  }
}

//Subrutina que crea el laberinto recursivamente
void RomperparedesRecursive(int x, int y) {
  matrix[x][y]=3;
  int cont=0;
  int[] vecinos={0, 0, 0, 0, 0};

  if (matrix[x-1][y]==1 && matrix[x-2][y]==2) {
    cont++;
    vecinos[1]=1;
  }
  if (matrix[x][y+1]==1 && matrix[x][y+2]==2) {
    cont++;
    vecinos[2]=1;
  }
  if (matrix[x+1][y]==1 && matrix[x+2][y]==2) {
    cont++;
    vecinos[3]=1;
  }
  if (matrix[x][y-1]==1 && matrix[x][y-2]==2) {
    cont++;
    vecinos[4]=1;
  }
  if (cont != 0) {
    float  num=(int)random(cont);
    int k = 0, i = 0;
    while (k < num+1 & i<4 ) {
      i++;
      if (vecinos[i] == 1) {
        k++;
      }
    }

    switch(i) {
    case 1:
      matrix[x-1][y]=4;
      RomperparedesRecursive(x-2, y);
      break;
    case 2:
      matrix[x][y+1]=4;
      RomperparedesRecursive(x, y+2);
      break;
    case 3:
      matrix[x+1][y]=4;
      RomperparedesRecursive(x+2, y);
      break;
    case 4:
      matrix[x][y-1]=4;
      RomperparedesRecursive(x, y-2);
      break;
    default :
      print("ALgo salió muy mal");
      break;
    }
  } else {
    if (matrix[x-1][y]==4 && matrix[x-2][y]==3) {
      matrix[x][y]=5;
      RomperparedesRecursive(x - 2, y);
    } else if (matrix[x][y+1]==4 && matrix[x][y+2]==3) {
      matrix[x][y]=5;
      RomperparedesRecursive(x, y + 2);
    } else if (matrix[x+1][y]==4 && matrix[x+2][y]==3) {
      matrix[x][y]=5;
      RomperparedesRecursive(x + 2, y);
    } else if (matrix[x][y-1]==4 && matrix[x][y-2]==3) {
      matrix[x][y]=5;
      RomperparedesRecursive(x, y - 2);
    }
  }
}

void pusha(int x, int y) {
  stackx++;
  stacky++;
  pilaxv[stackx] = x;
  pilayv[stacky] = y;
}

int popx(int x) {
  x = pilaxv[stackx];
  stackx--;
  return x;
}

int popy(int y) {
  y = pilayv[stacky];
  stacky--;
  return y;
}

//Subrutina que crea el laberinto iterativamente
void RomperparedesIterative(int x, int y) {
  matrix[x][y] = 3;
  pusha(x, y);
  while (stackx > 0) {
    x = popx(x);
    y = popy(y);
    int cont=0;
    int[] vecinos={0, 0, 0, 0, 0};

    if (matrix[x-1][y]==1 && matrix[x-2][y]==2) {
      cont++;
      vecinos[1]=1;
    }
    if (matrix[x][y+1]==1 && matrix[x][y+2]==2) {
      cont++;
      vecinos[2]=1;
    }
    if (matrix[x+1][y]==1 && matrix[x+2][y]==2) {
      cont++;
      vecinos[3]=1;
    }
    if (matrix[x][y-1]==1 && matrix[x][y-2]==2) {
      cont++;
      vecinos[4]=1;
    }
    if (cont != 0) {
      pusha(x, y);
      float  num=(int)random(cont);
      int k = 0, i = 0;
      while (k < num+1 & i<4 ) {
        i++;
        if (vecinos[i] == 1) {
          k++;
        }
      }

      switch(i) {
      case 1:
        matrix[x-1][y] = 4;
        matrix[x-2][y] = 3;
        pusha(x - 2, y);
        break;
      case 2:
        matrix[x][y+1]=4;
        matrix[x][y + 2] = 3;
        pusha(x, y + 2);
        break;
      case 3:
        matrix[x+1][y] = 4;
        matrix[x+2][y] = 3;
        pusha(x + 2, y);
        break;
      case 4:
        matrix[x][y-1]=4;
        matrix[x][y - 2] = 3;
        pusha(x, y - 2);
        break;
      default :
        print("ALgo salió muy mal");
        break;
      }
    }
  }
}

//Controles con Arduino
void keyPressed(char val) {
  antpy = movy;
  antpx = movx;
  if (val == 'u') {
    if (matrix[movx][movy - 1] != 1 && matrix[movx][movy - 1] != 0)
      movy -= 1;
  } else if (val == 'd') {
    if (matrix[movx][movy + 1] != 1 && matrix[movx][movy + 1] != 0)
      movy += 1;
  } else if (val == 'l') {
    if (matrix[movx - 1][movy] != 1 && matrix[movx - 1][movy] != 0)
      movx -= 1;
  } else if (val == 'r') {
    if (matrix[movx + 1][movy] != 1 && matrix[movx + 1][movy] != 0)
      movx += 1;
  } else if (val == 'b') {
    paus = !paus;
  }
}

void nextlevel () {
  background(249, 212, 34);
  niveles++;
  tesoroB=true;
  keys[0] = false;
  keys[1] = false;
  if (m < 19) {
    m += 1;
  } else if (n < 36) {
    n += 1;
  }
  if (n < 36) {
    n += 1;
  }
  movx = 1;
  movy = 1;
  antpx = 1;
  antpy = 1;
  matrix= new int[n*2+1][m*2+1];

  for (int i=0; i < n*2+1; i++) {
    for (int j=0; j < m*2+1; j++) {
      if (i==0 || j==0 || i==n*2 || j==m*2 || (i%2==0 && j%2==0)) {
        matrix[i][j]=0;
      } else if ((i%2==0 && j%2!=0)||(i%2!=0 && j%2==0) ) {
        matrix [i][j]=1;
      } else {
        matrix [i][j]=2;
      }
    }
  }
  
  //RomperparedesRecursive(1, 1);
  RomperparedesIterative(1, 1);
  matrix[n*2 - 1][m*2 - 1] = 8;
  matrix[n*2 - 1][1] = 9;
  matrix[1][m*2 - 1] = 9;
  matrix[movx][movy] = 7;
  do {
    tesorox=2*int(random(n))+1;
    tesoroy=2*int(random(m))+1;
  } while ((tesorox==n*2 - 1 && tesoroy== m*2 - 1) || (tesorox==n*2 - 1 && tesoroy==  1) || (tesorox==1 && tesoroy== m*2 - 1)|| (tesorox==1 && tesoroy== 1));
  matrix[tesorox][tesoroy]=10;
}

void dificultad(boolean backG) {
  switch(dificultad) {
  case 1:
    if (matrix[n*2 - 1][m*2 - 1] == 7) {
      nextlevel();
    } else if (backG) {
      background(249, 212, 34);
    }
    matrix[n*2 - 1][1] = 3;
    matrix[1][m*2 - 1] = 3;
    break;
  case 2:
    if (llave_Azar) {
      matrix[n*2 - 1][1] = 9;
      matrix[1][m*2 - 1] = 3;
      if (keys[0]) {
        matrix[n*2 - 1][1] = 3;
      }
      if (movx == n*2 - 1 && movy == 1) {
        keys[0] = true;
      }
      if (matrix[n*2 - 1][m*2 - 1] == 7) {
        if (keys[0]) {
          nextlevel();
          if (random(1)==1) {
            llave_Azar=true;
          } else {
            llave_Azar=false;
          }
        } else {
          switch(avatar) {
          case 1:
            image(alejo_llave1, width/2, height - 600, 600, 600);
            break;
          case 2:
            image(aleja_llave1, width/2, height - 600, 600, 600);
            break;
          case 3:
            image(juanmi_llave1, width/2, height - 600, 600, 600);
            break;
          }
        }
      } else if (backG) {
        background(249, 212, 34);
      }
    } else {
      matrix[n*2 - 1][1] = 3;
      matrix[1][m*2 - 1] = 9;
      if (keys[1]) {
        matrix[1][m*2 - 1] = 3;
      }
      if (movx == 1 && movy == m*2 - 1) {
        keys[1] = true;
      }
      if (matrix[n*2 - 1][m*2 - 1] == 7) {
        if (keys[1]) {
          nextlevel();
          if (random(1)==1) {
            llave_Azar=true;
          } else {
            llave_Azar=false;
          }
        } else {
          switch(avatar) {
          case 1:
            image(alejo_llave1, width/2, height - 600, 600, 600);
            break;
          case 2:
            image(aleja_llave1, width/2, height - 600, 600, 600);
            break;
          case 3:
            image(juanmi_llave1, width/2, height - 600, 600, 600);
            break;
          }
        }
      } else if (backG) {
        background(249, 212, 34);
      }
    }
    break;
  case 3:
    if (movx == n*2 - 1 && movy == 1) {
      keys[0] = true;
    }
    if (movx == 1 && movy == m*2 - 1) {
      keys[1] = true;
    }
    if (matrix[n*2 - 1][m*2 - 1] == 7) {
      if (keys[0] && keys[1]) {
        nextlevel();
      } else if (!keys[0] && !keys[1]) {
        switch(avatar) {
        case 1:
          image(alejo_llave2, width/2, height - 600, 600, 600);
          break;
        case 2:
          image(aleja_llave2, width/2, height - 600, 600, 600);
          break;
        case 3:
          image(juanmi_llave2, width/2, height - 600, 600, 600);
          break;
        }
      } else {
        switch(avatar) {
        case 1:
          image(alejo_llave1, width/2, height - 600, 600, 600);
          break;
        case 2:
          image(aleja_llave1, width/2, height - 600, 600, 600);
          break;
        case 3:
          image(juanmi_llave1, width/2, height - 600, 600, 600);
          break;
        }
      }
    } else if (backG) {
      background(249, 212, 34);
    }
    break;
  }
}

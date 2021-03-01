# SurfaceOfRevolution by Fabián Alfonso Beirutti Pérez
Surface of revolution 3D model using processing.

## Introducción
El objetivo de esta segunda práctica de la asignatura de 4to, Creación de Interfaces de Usuario (CIU), es empezar a tratar los conceptos y las primitivas básicas 3D para el dibujo de objetos. Para ello, se ha pedido el desarrollo de una aplicación capaz de crear a partir de un perfil de una figura, en la medida de lo posible, cualquier sólido de revolución usando el lenguaje de programación y el IDE llamado Processing. Este permite desarrollar código en diferentes lenguajes y/o modos, como puede ser processing (basado en Java), p5.js (librería de JavaScript), Python, entre otros.
<p align="center"><img src="/solidOfRevolutionGif.gif" alt="Solid of revolution 3D model using processing"></img></p>

Como se puede apreciar en el vídeo anterior, que demuestra el funcionamiento de la aplicación desarrollada, podemos identificar claramente dos fases en la ejecución del programa:
- **1era:** Dibujado por parte del usuario de un perfil de la figura deseada, a partir del cual se creará un sólido de revolución.
- **2da:** Observación y apreciación del resultado obtenido.

Antes de continuar, es prudente conocer la definición del concepto sólido de revolución:
> *Un sólido de revolución es un cuerpo que puede obtenerse mediante una operación geométrica de rotación de una superficie plana alrededor de una recta que es contenida en su mismo plano (la recta es a veces denominada eje). En principio, cualquier cuerpo con simetría axial o cilíndrica es un sólido de revolución.* (<a href="https://es.wikipedia.org/wiki/Sólido_de_revolución">Fuente</a>)

## Controles
Los controles de la aplicación se mostrarán en todo momento por pantalla para facilitar su uso al usuario:
- **Click izquierdo:** Si vamos haciendo click izquierdo en la parte derecha de la pantalla, vemos como se irán conectando los puntos relativos a los lugares donde hayamos presionado el botón del mouse, obteniendo así un boceto de la figura deseada.
- **Click derecho:** Una vez tengamos un mínimo de 2 puntos, podremos hacer click derecho sobre la pantalla, lo cual nos generará el sólido de revolución obtenido a partir del boceto realizado en el primer paso.
- **Mouse**: Mientras estemos observando el resultado podremos desplazar el mouse y en consecuencia, el módelo del sólido de revolución se moverá por la ventana de la aplicación.
- **Teclas W A S D:** Al presionar estas teclas podremos rotar nuestra figura 3D para observar el resultado en su completitud.
- **Tecla C:** Mientras estemos en la 2da fase de la ejecución de la aplicación, podremos cambiar el color de nuestro modelo en tres dimensiones.

## Descripción
Aprovechando que el lenguaje de programación que utiliza el IDE Processing por defecto está basado en Java, podemos desarrollar nuestro código utilizando el paradigma de programación de "Programación Orientada a Objetos". Así pues, hemos descrito tres clases de Java:
- **SolidOfRevolution:** clase principal.
- **Model:** clase que representa al objeto/resultado de crear el sólido de revolución a partir del perfil de la figura introducido por el usuario.
- **Point:** clase que representa cada uno de los puntos introducidos por el usuario

## Explicación
### Clase SolidOfRevolution
Esta es la clase principal de la aplicación, la cual gestiona la información mostrada por pantalla al usuario (interfaz gráfica), esto es, el desarrollo de los métodos *setup()* y *draw()*. 
```
void setup() {
  surface.setTitle("Solid of revolution");
  size(800, 600, P3D);
  stroke(95, 230, 255);
  image = loadImage("Captura.JPG");
  points = new ArrayList();
  menu = true;
  sketchMode = false;
  modelMode = false;
  model = new Model();
}

void draw() {
  if (menu) menu();
  if (modelMode) {
    pushMatrix();
    background(0);
    showHelp();
    translate(mouseX, mouseY-150, -300);
    shape(shape);
    model.rotateModel();
    popMatrix();
  }
}
```
En el método *draw()*, el comando *translate()* tiene dos valores numéricos en sus dos últimos argumentos. Esto se debe a que para representar correctamente el sólido al completo y que se pudiera desplazar en cierta "sincronía" con el desplazamiento del mouse, hemos restado unas cantidades determinadas a los ejes de coordenadas para desplazar la figura -150 puntos en el eje Y y -300 en el Z (alejarlo de la vista del usuario para apreciar todo su tamaño).

Por otra parte, esta misma clase es la que maneja la interacción entre el usuario y la interfaz mediante la implementación de los métodos *keyPressed()*, *keyReleased()*, *mousePressed()*, entre otros. Un ejemplo se muestra a continuación:
```
void mouseClicked() {
  if (menu) return;
  if (mouseButton == LEFT && mouseX > width/2 && sketchMode) {
    currentPoint = new Point(mouseX, mouseY, 0);
    drawLine();
    points.add(new Point(currentPoint.x - width / 2, currentPoint.y - height / 2, 0));
  }
  if (mouseButton == RIGHT && sketchMode && points.size() >= 2) {
    sketchMode = false;
    model.showModel(points);
    shape = model.getModel();
    modelMode = true;
  }
}
```
Como se puede ver, si presionamos el click izquierdo del mouse, empezaremos a dibujar puntos que al unirlos conforman el perfil de la figura deseada por el usuario. Mostramos las líneas del contorno del boceto y vamos añadiendo los puntos a un vector de tipo *ArrayList* (optamos por esta estructura de datos por su versatilidad a la hora de añadir nuevos elementos, además de su facilidad para recorrer y tratar los mismos). En cambio, si presionamos click derecho le estamos diciendo a la aplicación que cree el sólido en revolución a partir de los puntos dados y que habilite la fase de visualización del resultado.

## Descarga y prueba
Para poder probar correctamente el código, es necesario descargar todos los ficheros (los .pde y la carpeta data, esta contiene los archivos extras que utiliza la aplicación) y guardarlo en una carpeta. El archivo "README.md" es opcional, si se descarga no debería influir en el funcionamiento de código ya que, es exclusivo de la plataforma GitHub.

## Recursos empleados
Para la realización de este modelado 3D de un sólido de revolución, se han consultado y/o utilizado los siguientes recursos:
* Guión de prácticas de la asignatura CIU
* <a href="https://processing.org">Página de oficial de Processing y sus referencias y ayudas</a>
* Processing IDE

Por otro lado, las librerías empleadas fueron:
* <a href="https://github.com/extrapixel/gif-animation">GifAnimation</a>

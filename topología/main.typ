// ------------------ CONFIGURACIONES GLOBALES ------------------

// Configuración del documento en general
#set page(
  paper: "a4",
  margin: 2.5cm,
)

#set text(
  font: "libertinus serif",
  size: 11pt,
  lang: "es",
)

#set par(
  justify: true,
  leading: 0.7em,
)

// Configuración de los headers 
#set heading(numbering: "1.")

// Configuración del titulo y autor
#set document(
  author: "César Pérez",
  date: datetime.today(),
  title: "Notas de topología y sus aplicaciones",
)
#show title: set text(size: 20pt, weight: "bold")
#show title: set align(center)
#show title: set block(below: 1.2em)

#let displayauthor() = align(center)[
  César Pérez \ 
  Universidad De Las Americas Puebla \
  #link("mailto: cesar.perezar@udlap.mx")
]

// Envs personalizados:
#import "@preview/great-theorems:0.1.2": *
#import "@preview/rich-counters:0.2.1": *

#show: great-theorems-init

#let mathcounter = rich-counter(
  identifier: "mathblocks",
  inherited_levels: 1
)

#let theorem = mathblock(
  blocktitle: "Teorema",
  counter: mathcounter,
  breakable: false
)

#let lemma = mathblock(
  blocktitle: "Lemma",
  counter: mathcounter,
  breakable: false
)

#let note = mathblock(
  blocktitle: "Nota",
  prefix: [_Nota._],
)

#let notation = mathblock(
  blocktitle: "notación",
  prefix: [*Notación.*],
)

#let example = mathblock(
  blocktitle: "Ejemplo",
  prefix: [_Ejemplo._],
)

#let proposition = mathblock(
  blocktitle: "Proposición",
  counter: mathcounter,
  breakable: false
)

#let definition = mathblock(
  blocktitle: "Definición",
  counter: mathcounter,
  breakable: false
)

#let proof = mathblock(
  blocktitle: "Demostración",
  prefix: [_Demostración._],
  suffix: [#h(1fr) $square$],
)

#let sketchproof = mathblock(
  blocktitle: "Media Demostración",
  prefix: [_Borrador de la demostración._],
  suffix: [#h(1fr) $square^*$],
)

// Paquetes extra
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge // diagramas


// ------------------ FIN CONFIGURACIONES GLOBALES ------------------

// ------------------ CONTENIDO ------------------

// Titulo y autor
#title()
#displayauthor()
#pagebreak()

// Tabla de contenidos
#outline()
#pagebreak()

// Capitulo 1
= Espacios métricos
Una gran mayoría de los ejemplos que usamos para los conceptos del curso vienen del análisis topológico de datos, una rama en crecimiento de la topología aplicada. Cuando analizamos datos nos interesa medir distancias en nuestro muestreo (por ejemplo, el error de un modelo de regresión lineal multiple se mide tomando las distancias de cada medición real con la predicción), y para eso necesitamos una buena noción de lo que significa medir, en concreto una buena noción de _distancia_ (Spoiler: *métricas*). Además nos interesa que esta buena noción de distancia pueda relacionar cosas parecidas como cercanas.

== Métricas
#definition(title: "Métrica")[
  Sea $X$ un conjunto. una *métrica* es una función $d: X times X -> RR$, tal que:
  + $d(x, y) >= 0$
  + $d(x, y) <=> x = y$
  + $d(x, y) = d(y, x)$
  + *Desigualdad del triángulo:* $d(x, z) <= d(x, y) + d(y, z)$
] <dfn1>

#align(center)[
#diagram(
  let (x, y, z) = ((0, 1), (2, 0), (3, 1)),
  spacing: 30pt,
  node(x, $x$),
  node(y, $y$),
  node(z, $z$),
  
  edge(x, y, "<->", label-angle: auto, $d(x, y)$),
  edge(x, z, "<->", label-anchor: "center", label-sep: -10pt, $d(x, z)$),
  edge(y, z, "<->", label-angle: auto, $d(y, z)$),
)
]

#example[
  Tomemos como "métrica" el tiempo que toma llegar de un punto a otro, sabemos que el tiempo transcurrido siempre es positivo, por lo tanto 1. se cumple. Si nos toma 0 unidades de tiempo llegar a un punto significa que estamos parados justamente en ese punto, entonces 2. se cumple. Sin embargo, el tiempo que nos toma ir de un punto $x$ a un punto $y$ no siempre es igual que el tiempo que nos toma ir de $y$ a $x$, por lo tanto este ejemplo *no* es una métrica.
]

#note[
  A esta pseudo-métrica se le conoce como la *métrica del alpinista*, ya que para un alpinista toma más tiempo llegar a la sima de una montaña que a la cima. 
]

#proposition(title: "Distancia en los reales")[
  Sea $d: RR times RR -> RR$ la función dada por $d(x, y) = abs(x - y)$. Entonces $d$ define una métrica sobre $RR$. 
] <prop1>

#proof[
  Sea $d(x, y) = abs(x - y) $ para $x, y in RR$
  + Por definición de valor absoluto $abs(x - y) = d(x, y) >= 0$. 
  + Si $x = y$ entonces $x - y = 0$ y por lo tanto $abs(x - y) = d(x, y) = abs(0) = 0$. Además si $abs(x - y) = d(x, y) = 0$ entonces por definición de valor absoluto $x - y = 0$ lo que implica $x = y$. 
  + Por propiedades de valor absoluto $d(x, y) = abs(x - y) = abs(y - x) = d(y, x)$.
  + Desigualdad del triángulo: $d(x, z) = abs(x - z) = abs((x - y) + (y - z))$, por desigualdad triángular del valor absoluto en $RR$, para cualesquiera números $a, b in RR$ se cumple que $abs(a + b) <= abs(a) + abs(b)$. Sean $a = (x - y), b = (y - z)$ obtenemos $ d(x, z) = abs((x - y) + (y - z)) <= abs(x - y) + abs(y - z) $En terminos de la función: $d(x, z) <= d(x, y) + d(y, z)$ 
  Se concluye que $d$ define una métrica sobre $RR$.
]

#note[
  Para 4. utilizamos una desigualdad auxiliar, en muchas de las demostraciones de funciones como métricas para demostrar la desigualdad del triángulo vamos a utilizar este tipo de desigualdades.
]

#proposition(title: "Métrica de Manhattan")[
  Sean $arrow(x) = (x_1, ..., x_n), arrow(y) = (y_1, ..., y_n) in RR^n$ y \ $d:RR^n times RR^n -> RR$ la función dada por: $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) $ Entonces $d$ define una métrica sobre $RR^n$
] <prop2>

#proof[
  Sean $arrow(x) = (x_1, ..., x_n), arrow(y) = (y_1, ..., y_n), arrow(z) = (z_1, ..., z_n) in RR^n, alpha in {1, ..., n}$ y $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) $ 
  + Cada uno de los sumandos $abs(x_alpha - y_alpha) >= 0$ entonces $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) >= 0 $ 
  + Si $arrow(x) = arrow(y)$ entonces $x_alpha = y_alpha$ por lo que $x_alpha - y_alpha = 0$, por lo tanto $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) = sum_(i=1)^n abs(0) = 0 $ Además, tenemos que si $d(arrow(x), arrow(y)) = 0$ entonces cada uno de los sumandos $abs(x_alpha - y_alpha) = 0,$ y $x_alpha = y_alpha$ por lo tanto $arrow(x) = arrow(y)$ 
  + Como $abs(x_alpha - y_alpha) = abs(y_alpha - x_alpha)$ entonces $ d(arrow(x), arrow(y)) = sum_(i=1)^n abs(x_i - y_i) = sum_(i=1)^n abs(y_i - x_i) = d(arrow(y), arrow(x)) $
  + Por @prop1 tenemos que $abs(x_alpha - z_alpha) <= abs(x_alpha - y_alpha) + abs(y_alpha - z_alpha)$ entonces por axiomas de orden en $RR$ tenemos que $ (d(x, z) = sum_(i=1)^n abs(x_i - z_i)) <= (sum_(i=1)^n abs(x_i - y_i) + sum_(i=1)^n abs(y_i - z_i) = d(x, y) + d(y, z)) $
  Se concluye que $d$ define una métrica sobre $RR^n$
]

#note[
  Se le conoce como métrica de Manhattan ya que en $RR^2$ al visualizar la métrica se "parece" a las calles de Nueva York, en el sentido que es de _izquierda a derecha_ y _arriba a abajo_ y no en diagonal:
]

#align(center)[
#cetz.canvas({
  import cetz.draw: *

  // --- CONFIGURACIÓN ---
  let xp = 1.5; let yp = 1.5
  let xq = 5.5; let yq = 3.5
  
  // Estilos
  let axis-style = (thickness: 1pt, paint: black)
  let dash-style = (dash: "dashed", paint: black) 
  let point-style = (fill: red, stroke: none, radius: 0.08) 
  
  // --- 1. EJES ---
  line((-1, 0), (6.5, 0), stroke: axis-style) // Eje X
  line((0, -1), (0, 5), stroke: axis-style)   // Eje Y

  // --- 2. PROYECCIONES A LOS EJES (Solo a los ejes) ---
  // Proyecciones hacia el Eje X
  line((xp, 0), (xp, yp), stroke: dash-style) // De P abajo
  line((xq, 0), (xq, yq), stroke: dash-style) // De Q abajo
  
  // Proyecciones hacia el Eje Y
  line((0, yp), (xp, yp), stroke: dash-style) // De P izquierda
  line((0, yq), (xq, yq), stroke: dash-style) // De Q izquierda
  
  // (Se eliminaron las proyecciones internas que conectaban P y Q directamente)

  // --- 3. PUNTOS Y ETIQUETAS P/Q ---
  circle((xp, yp), ..point-style)
  content((xp, yp), [$P$], anchor: "north-east", padding: 0.15)
  
  circle((xq, yq), ..point-style)
  content((xq, yq), [$Q$], anchor: "south-west", padding: 0.15)

  // --- 4. LLAVES Y TEXTO DE DISTANCIA ---

  // --- Horizontal: |x_1 - y_1| ---
  let h-brace-y = -0.6 
  let h-text-y = -1.2  
  
  line((xp, h-brace-y), (xq, h-brace-y), stroke: (paint: black))
  line((xp, h-brace-y - 0.1), (xp, h-brace-y + 0.1), stroke: (paint: black)) 
  line((xq, h-brace-y - 0.1), (xq, h-brace-y + 0.1), stroke: (paint: black)) 
  
  content(((xp + xq)/2, h-text-y), text(size: 10pt)[$|x_1 - y_1|$])


  // --- Vertical: |x_2 - y_2| ---
  let v-brace-x = -0.6 
  let v-text-x = -1.8  
  
  line((v-brace-x, yp), (v-brace-x, yq), stroke: (paint: black))
  line((v-brace-x - 0.1, yp), (v-brace-x + 0.1, yp), stroke: (paint: black)) 
  line((v-brace-x - 0.1, yq), (v-brace-x + 0.1, yq), stroke: (paint: black)) 
  
  content((v-text-x, (yp + yq)/2), text(size: 10pt)[$|x_2 - y_2|$])

})
]

#proposition(title: "Distancia euclidiana")[
  Sean $arrow(x) = (x_1, ..., x_n), arrow(y) = (y_1, ..., y_n) in RR^n$ y \ $d:RR^n times RR^n -> RR$ la función dada por: $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) $ Entonces $d$ define una métrica sobre $RR^n$
] <prop3>

#sketchproof[
  Sean $arrow(x) = (x_1, ..., x_n) in RR^n, arrow(y) = (y_1, ..., y_n) in RR^n, alpha in {1, ..., n}$ y $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) $ 
  + Cada uno de los sumandos $(x_alpha - y_alpha)^2 >= 0$ entonces $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) >= 0 $ 
  + Si $arrow(x) = arrow(y)$ entonces $x_alpha = y_alpha$ por lo que $x_alpha - y_alpha = 0$, por lo tanto $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) = sqrt(sum_(i=1)^n (0)^(2)) = 0 $ Además, tenemos que si $d(arrow(x), arrow(y)) = 0$, cada uno de los sumandos $(x_alpha - y_alpha)^2 = 0$ y $x_alpha = y_alpha$ por lo tanto $arrow(x) = arrow(y)$ 
  + Como $(x_alpha - y_alpha)^2 = (y_alpha - x_alpha)^2$ entonces $ d(arrow(x), arrow(y)) = sqrt(sum_(i=1)^n (x_i - y_i)^(2)) = sqrt(sum_(i=1)^n (y_i - x_i)^(2)) = d(arrow(y), arrow(x)) $
  + To be continued (Spoiler: *Desigualdad de Cauchy-Schwarz*)
]

#proposition(title: [Métrica $p$-esima])[
  Sean $arrow(x) = (x_1, ..., x_n), arrow(y) = (y_1, ..., y_n) in RR^n$ y \ $d : RR^n times RR^n -> RR$ la función dada por $ d(arrow(x), arrow(y)) = (sum_(i=1)^n abs(x_i - y_i)^p)^(frac(1, p)) $ Entonces $d$ define una métrica sobre $RR^n$
] <prop4> 

Para las 3 primeras propiedades de métrica la demostracíon de @prop4 es muy similar a la de @prop2, sin embargo, como sucedio con la @prop3, necesitamos una desigualdad auxiliar un poco más compleja para demostrar la desigualdad del triángulo, entonces, la demostración se deja en pausa para poder continuar con los contenidos del capitulo.

#note[
  La métrica de Manhattan y la distancia euclidiana son casos particulares de la métrica $p$-esima, en donde respectivamente $p = 1$ y $p = 2$, además la métrica $p$-esima nos define una infinidad de medir distancias en $RR^n$. 
]

#notation[
  Para diferenciar cada una de las métricas que hemos definido, se usa la notación $d_p$ es decir, para la métrica de Manhattan usamos $d_1$ para la distancia euclidiana usamos $d_2$ y para la $p$-esima $d_p$
]

#proposition(title: "Métrica de Chebyshev")[
  Sean $arrow(x) = (x_1, ..., x_n), arrow(y) = (y_1, ..., y_n) in RR^n$ y \ $d_infinity: RR^n times RR^n -> RR$ la función dada por: $ d_(infinity)(arrow(x), arrow(y)) = limits(max)_(1 <= i <=n)abs(x_i - y_i) $ Entonces $d_infinity$ define una métrica sobre $RR^n$
] <prop5>

#proof[
  Sean $arrow(x) = (x_1, ..., x_n), arrow(y) = (y_1, ..., y_n), arrow(z) = (z_1, ..., z_n) in RR^n, alpha in {1, ..., n}$ y $ d_(infinity)(arrow(x), arrow(y)) = limits(max)_(1 <= i <=n)abs(x_i - y_i) $
  + Cada uno de los candidatos a máximo $abs(x_alpha - y_alpha) >= 0$ entonces $ d_(infinity)(arrow(x), arrow(y)) = limits(max)_(1 <= i <=n)abs(x_i - y_i) >= 0 $
  + Si $arrow(x) = arrow(y)$ entonces $x_alpha = y_alpha$ por lo que $x_alpha - y_alpha = 0$, por lo tanto $ d_(infinity)(arrow(x), arrow(y)) = limits(max)_(1 <= i <=n)abs(x_i - y_i) = limits(max)_(1 <= i <= n)abs(0) = 0 $ Además si $d_(infinity)(arrow(x), arrow(y)) = 0$ entonces cada uno de los candidatos a máximo $abs(x_alpha - y_alpha) = 0$, y $x_alpha = y_alpha$ por lo tanto $arrow(x) = arrow(y)$
  + Por propiedades de valor absoluto, cada uno de los candidatos a máximo $(x_alpha - y_alpha) = (y_alpha - x_alpha)$ entonces $ d_(infinity)(arrow(x), arrow(y)) = limits(max)_(1 <= i <=n)abs(x_i - y_i) = limits(max)_(1 <= i <=n)abs(y_i - x_i) = d_(infinity)(arrow(y), arrow(x)) $
  + Sea $d_(infinity)(arrow(x), arrow(z)) = abs(x_alpha - z_alpha)$, por @prop1 $abs(x_alpha - z_alpha) <= abs(x_alpha - y_alpha) + abs(y_alpha - z_alpha)$ además, si $d_(infinity)(arrow(x), arrow(y)) = limits(max)_(1 <= i <= n)abs(x_i - y_i) != abs(x_alpha - y_alpha)$ ó $d_(infinity)(arrow(y), arrow(z)) = limits(max)_(1 <= i <= n)abs(y_i - z_i) != abs(y_alpha - z_alpha)$ entonces $ d_(infinity)(arrow(x), arrow(z)) = abs(x_alpha - z_alpha) <= abs(x_alpha - y_alpha) + abs(y_alpha - z_alpha) <= d_(infinity)(arrow(x), arrow(y)) + d_(infinity)(arrow(y), arrow(z)) $ Por transitividad $ d_(infinity)(arrow(x), arrow(z)) <= d_(infinity)(arrow(x), arrow(y)) + d_(infinity)(arrow(y), arrow(z))$
  Se concluye que $d_(infinity)$ define una métrica sobre $RR^n$
]

#note[
  Todos los ejemplos de métricas que hemos definido son para datos númericos, sin embargo, ¿Cómo medimos distancias entre datos categóricos?
]
#pagebreak()

== Métricas para datos categóricos
#definition(title: "Dato categórico")[
  Un dato categórico es una variable que toma valores dentro de un conjunto finito y predefinido de etiquetas o clases. Representan cualidades o características, en lugar de cantidades numéricas continuas.
] <dfn2>

Al no tener cantidades númericas involucradas nuestras métricas definidas anteriormente no pueden medir _directamente_ distancias entre datos categóricos. Pero si podemos comparar su *igualdad*.

#proposition(title: "Métrica discreta")[
  Sea $X$ un conjunto de datos categóricos, $x, y in X$ y \ $d_("disc") : X times X -> RR$ la función dada por: $ d_("disc")(x, y) = cases(
    0 "si" x = y,
    1 "si" x != y
  ) $ Entonces $d$ define una métrica sobre $X$
] <prop6>

#proof[
  Sea $X$ un conjunto de datos categóricos, $x, y, z in X$ y $ d_("disc")(x, y) = cases(
    0 "si" x = y,
    1 "si" x != y
  ) $
  + Como $"Im"(d_("disc")) = {0, 1}$ entonces $d_("disc")(x, y) >= 0$
  + Por definición de $d_("disc"): d_("disc")(x, y) = 0 <=> x = y$
  + Como $x = y <=> y = x$ entonces $d_("disc")(x, y) = d_("disc")(y, x)$
  + Si $x = z$ entonces $0 = d_("disc")(x, z) <= d_("disc")(x, y) + d_("disc")(y, z)$, además si $x != z$ y tomamos $x = y$ y $y = z$ por transitividad $x = z (!)$ entonces $1 = d_("disc")(x, z) <= d_("disc")(x, y) + d_("disc")(y, z)$
  Se concluye que $d_("disc")$ define una métrica sobre $X$
]

#example[
  Para datos categóricos del tipo "negro ó blanco" esta métrica funciona muy bien, sin embargo, ¿Cómo medimos distancias para cosas como colores? Por ejemplo ¿Hay alguna forma de medir $d(#text(fill: green)[verde], #text(fill: blue)[azul])$, mantiendo además la relación parentesco-cercanía? Pues conocemos formas de medir distancias en $RR^3$, entonces nos convendría tener una asociación de la forma $f: #text(fill: gradient.linear(red, yellow, green, blue,))[colores] -> RR^3$. Dicha asociación ya existe y se denota $"rgb", x = (r, g, b)$ por la cantidad de rojo, verde y azul de cada color, algo importante es que mantiene los colores parecidos "cerca".
]

En este caso el problema se resolvió aplicando un proceso llamado "vectorización", tomamos un color (dato cualitativo) y lo vectorizamos con valores númericos basandonos en la cantidad de colores primarios que contienen. En general vectorizar es muy útil ya que nos permite utilizar las métricas que ya definimos sobre $RR^n$, sin embargo hay que recordar que es importante mantener la relación parentesco-cercanía.

#example[
  ¿Cómo medimos distancias o más bien "similitud" en dos carritos de Amazon? Podemos vectorizar basandonos en las compras, imaginemos que Amazon solo tiene 8 objetos a la venta y si un usuario compra uno asignamos "1", el resto siendo "0", i.e: $ bold(c_1) = (0,1,1,1,1,1,1,0) \ bold(c_2) = (1,1,1,1,1,0,1,1) $  Tomamos la cardinalidad de la diferencia geométrica de los dos vectores, es decir $ d(bold(c_1), bold(c_2)) = \#(bold(c_1) triangle bold(c_2)) = 3 $
]

#note[
  Podemos aplicar este módelo de contar en cuántas coordenadas dos objetos son diferentes a muchos problemas. 
]

#proposition(title: "Distancia de Hamming")[
  Sean $Sigma$ un abecedario finito de la forma ${ell_1, ..., ell_m}$, \ $n in NN$, dos palabras finitas $p_1 = (ell_1^1, ..., ell_n^1), p_2 = (ell_1^2, ..., ell_n^2) in Sigma^n$ y $d_H : Sigma^n times Sigma^n -> NN$ la función dada por: $ d_(H)(p_1, p_2) = \#{i in {1, ..., n} : ell_i^1 != ell_i^2} $ Entonces $d_H$ define una métrica sobre $Sigma^n$
] <prop7>

#sketchproof[
  Sean $Sigma$ un abecedario finito de la forma ${ell_1, ..., ell_m}$, $n in NN$, dos palabras finitas $p_1 = (ell_1^1, ..., ell_n^1), p_2 = (ell_1^2, ..., ell_n^2) in Sigma^n$ y $ d_(H)(p_1, p_2) = \#{i in {1, ..., n} : ell_i^1 != ell_i^2} $
  + La cardinalidad siempre es un número natural $d_(H)(p_1, p_2) = \#{i in {1, ..., n} : ell_i^1 != ell_i^2} >= 0$
  + Si $p_1 = p_2$ entonces $ell_i^1 = ell_i^2$ para toda $i in {1, ..., n}$ por lo tanto $\#{i in {1, ..., n}: ell_i^1 != ell_i^2} = \#emptyset = 0$. Además si $d_(H)(p_1, p_2) = 0$ entonces $\#{i in {1, ..., n}: ell_i^1 != ell_i^2} = 0$ lo que implica que no existe ningún elemento distinto entre las palabras es decir $p_1 = p_2$
  + Por la definición del conjunto contable ${i in {1, ..., n}: ell_i^1 != ell_i^2} = {i in {1, ..., n}: ell_i^2 != ell _i^1}$ tomando cardinalidades: $d_(H)(p_1, p_2) = d_(H)(p_2, p_1)$
  + To be continued (Spoiler: *Distancia en grafos*)
]

#proposition(title: "Distancia en grafos")[
  Sean $G = (V, E)$ un grafo no orientado y finito, $u, v in V$ y \ $d_(G): V times V -> NN$ la función dada por: $ d_(G)(u, v) = min{k: "existe un camino de longitud" k "entre" u, v} $ Entonces $d_(G)$ define una métrica sobre los vertices de $G$
] <prop8>

#proof[
  Sean $G = (V, E)$ un grafo no orientado y finito, $u, v, w in V$ y $ d_(G)(u, v) = min{k: "existe un camino de longitud" k "entre" u, v} $
  + Como la longitud de cualquier camino es una suma de aristas de tamaño $k in NN$ el mínimo de un conjunto de números naturales siempre es mayor o igual a 0. Esto es $d_(G)(u, v) >= 0$ 
  + Si $u = v$, el camino trivial de longitud 0 existe, por lo tanto $d_(G)(u, v) = 0$. Además si $d_(G)(u, v) = 0$ el cámino mas corto tiene 0 aristas. Un camino sin aristas empieza y termina en el mismo vertice, es decir $u = v$ 
  + Al ser un grafo no orientado, si existe un camino más corto de $u$ a $v$ dado por la secuencia de vertices $(u, x_1, ..., x_k, v)$ la secuencia inversa $(v, x_k, ..., x_1, u)$ es un camino de $v$ a $u$ de la misma longitud. Por tanto la distancia mínima es igual, es decir $d_(G)(u, v) = d_(G)(v, u)$
  + Sean $P_(u v)$ un camino mínimo entre $u$ y $v$ (longitud $d_(G)(u, v)$) y $P_(v w)$ un camino mínimo entre $v$ y $w$ (longitud $d_(G)(v, w)$). Al concatenar estos dos caminos, formamos un camino de $u$ a $w$ que pasa por $v$, cuya longitud total es $d_(G)(u, v) + d_(G)(v, w)$, como $d_(G)(u, w)$ esta definido como la longitud del camino más corto posible entre $u$ y $w$ este debe ser menor o igual que la longitud de cualquier otro camino arbitrario que construyamos (incluyendo el que pasa por $v$) por lo tanto $ d_(G)(u, w) <= d_(G)(u, v) + d_(G)(v, w) $.
  Se concluye que $d_(G)$ define una métrica sobre $V$
]

#note[
  Usando la distancia de grafos podemos mapear una equivalencia con la distancia de Hamming y construir un grafo que modele el espacio de palabras para demostrar indirectamente la desigualdad del triángulo de $d_(H)$
]

#lemma(title: "Equivalencia de métricas")[
  Construimos un grafo $G = (V, E)$ con $V = Sigma^n$ y conectamos dos palabras $u, v in V$ si y solo si difieren exactamente en una posición. Es decir $ (u, v) in E <=> d_(H)(u, v) = 1 $ Entonces $d_(H)(p_1, p_2) = d_(G)(p_1, p_2)$
] <lemma1>

#proof(title: [Continuación de $d_(H)$])[
  Ya demostramos 1. 2. y 3. Ahora, usando el @lemma1 $d_(G) = d_(H)$, como ya demostramos $d_(G)(p_1, p_3) <= d_(G)(p_1, p_2) + d_(G)(p_2, p_3)$ sustituyendo con $d_(H)$: $ d_(H)(p_1, p_3) <= d_(H)(p_1, p_2) + d_(H)(p_2, p_3) $ Se concluye que $d_(H)$ define una métrica sobre $Sigma^n$
]
#pagebreak()

== Distancia entre funciones
Al modelar tenemos que tomar en cuenta la robustez del módelo, es decir, que una pequeña distorción en los datos cause una pequeña distorción en el módelo. Como por lo general el módelo es una función continua podemos tomar lo que varían los resultados reales contra los esperados, es decir, tomar la distancias entre estos.

// Gráfica
#let model(x) = { 0.5 * x + 1.5 }
#let data_points = (
  (1.5, -1.2), // r1
  (3.0,  1.2), // r2
  (4.5, -0.8), // r3
  (6.0,  0.9), // r4
  (7.5, -0.5), // r5
  (9.0,  1.1), // r6
)
#align(center)[
#cetz.canvas({
  import cetz-plot: plot
  import cetz.draw

  plot.plot(
    size: (10, 6),
    axis-style: "school-book",
    x-tick-step: none,
    y-tick-step: none,
    x-min: -1, x-max: 11,
    y-min: -1, y-max: 8,
    {
      // --- DIBUJAR EL MODELO (LÍNEA) ---
      plot.add(
        domain: (-1, 10.5),
        model,
        style: (stroke: (paint: blue, thickness: 2pt))
      )

      // --- DIBUJAR PUNTOS Y ERRORES ---
      for (i, (x, offset)) in data_points.enumerate() {
        let y_pred = model(x)
        let y_real = y_pred + offset
        let idx = i + 1

        // 1. Línea de error (Residuo)
        plot.add(
          ((x, y_pred), (x, y_real)),
          style: (stroke: (paint: gray, dash: "dashed", thickness: 1.5pt))
        )

        // 2. Punto Real (r)
        plot.add(
          ((x, y_real),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: blue, stroke: none)
        )

        // 3. Punto Predicho (y)
        plot.add(
          ((x, y_pred),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: white, stroke: (paint: blue, thickness: 1.5pt))
        )

      }
      
    }
  )
})
]

Suponiendo que nuestro conjunto de datos reales es $R = (r_1, ..., r_n)$ y nuestro conjunto de predicciones en esos datos es $Y = (y_1, ..., y_n)$ entonces podemos usar la métrica de Manhattan para calcular el error del módelo: $d_(1)(R, Y) = abs(r_1 - y_1) + ... + abs(r_n - y_n)$, sin embargo, nos interesa además poder derivar esta expresión para minimizarla, para esto lo que hacemos es elevar al cuadrado cada expresión: $"Error" = (r_1 - y_1)^(2) + ... + (r_n - y_n)^(2)$ 

¿Qué pasa con resultados continuos? Entonces podemos representar los resultados como una función; nuestro módelo también es una función, entonces podemos medir distancias como áreas entre curvas. En donde $d_(1)(e, r) = integral_a^b abs(e(x) - r(x)) dif x$, asumiendo que $e$ es nuestro módelo y $r$ son los datos reales.

// Gráfica
#let f_line(x) = { 0.5 * x + 1 }
#let f_curve(x) = { 0.5 * x + 1 + 0.8 * calc.sin(x * 1.5) }
#align(center)[
#cetz.canvas({
  import cetz-plot: *
  import cetz.draw: *

  plot.plot(
    size: (10, 6),
    // Usamos estilo "school-book" para ejes que cruzan en (0,0) 
    axis-style: "school-book",
    // Ocultamos los números de los ejes como en la imagen 
    x-tick-step: none,
    y-tick-step: none,
    x-min: -2, x-max: 7,
    y-min: -1, y-max: 5,
    {
      // 1. El área verde (Integral de la diferencia)
      // Usamos add-fill-between para rellenar entre f_line y f_curve 
      plot.add-fill-between(
        domain: (-10, 6.2), // Rango donde se ve el sombreado
        f_line,
        f_curve,
        style: (fill: green.lighten(50%), stroke: none)
      )

      // 2. La línea azul l(x) [cite: 227]
      plot.add(
        domain: (-2, 6.5),
        f_line,
        style: (stroke: (paint: blue, thickness: 2pt))
      )

      // 3. La curva roja r(x)
      plot.add(
        domain: (-2, 6.5),
        f_curve,
        style: (stroke: (paint: red, thickness: 2pt))
      )
      
    }
  )
})
]

En general podemos encontrar la distancia con métricas que ya conocemos, por ejemplo: $ d_(p)(e, r) = (integral_a^b abs(e(x) - r(x))^p)^(1/p) $

== Normas
== Distancias entre distancias
== Espacios
== La desigualdad de Cauchy-Schwarz

// Capitulo 2
= Conceptos fundamentales de topología
== Bolas
== Conjuntos abiertos y propiedades de bolas
== Topología
== Conjuntos cerrados
== Subespacios
== Frontera, clausura, interior y exterior
== Continuidad
// ------------------ FIN CONTENIDO ------------------
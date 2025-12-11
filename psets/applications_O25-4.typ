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
  title: "Applications O25-4",
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

= Ejercicios

== Ejercicio 5.

Sea $bold(u) = (4600, 4290, 5250)$, el vector que representa las unidades fabricadas de tres modelos de teléfonos celulares, $bold(v) = (499.99, 199.99, 99.99)$, el vector que representa los precios (en dólares) de cada modelo.

El producto punto se calcula como: 

$
bold(u) ⋅ bold(v) = (4600)(499.99) + (4290)(199.99) + (5250)(99.99)
$

Calculamos cada término:

$
(4600)(499.99) = 2,299,954; (4290)(199.99) = 857,957.10; (5250)(99.99) = 524,947.50
$

Sumando los resultados:

$
bold(u) ⋅ bold(v) = 2,299,954 + 857,957.10 + 524,947.50 = 3,682,858.60
$

El producto punto es:

$
bold(u) ⋅ bold(v) = 3,682,858.60
\ "dolares"
$

Este valor representa el *ingreso total* que se obtendría al vender todas las unidades fabricadas de los tres modelos de teléfonos celulares.

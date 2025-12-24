# 📓 Notes

> *Espero que sean de ayuda, futuro César.*

Este repositorio contiene mis **notas personales** sobre temas que me han interesado a lo largo del tiempo, principalmente **matemáticas** y **finanzas**.  
Las notas están pensadas como un **registro estructurado de ideas**, no como material didáctico autosuficiente.

---

## 📚 Contenido y filosofía

- Las notas **recogen ideas clave**, definiciones y estructuras conceptuales.
- Se **evitan ejemplos extensos**, aunque ocasionalmente aparece alguno si es imprescindible.
- Muchas definiciones aparecen **tal cual en los textos estándar**, porque reinventar notación o definiciones rara vez aporta valor.
- El objetivo principal es **capturar mi proceso de pensamiento** al entender un tema.

> Existen notas hechas a mano que me gustaría publicar, pero por una sucesión de malas decisiones (principalmente indecisión sobre dónde escribirlas) hoy son **imposibles de exportar**, y soy ***MUY*** flojo como para arreglarlo.

👾

---

## ✏️ Notación

Gran parte del contenido está centrado en matemáticas, por lo que las notas están escritas en **LaTeX**.

- La notación es la **estándar de cualquier libro**.
- Ejemplo:  
  `\int f(x)\,dx` siempre representa la integral de una función.
- No se introducen convenciones personales raras ni símbolos exóticos innecesarios.

---

## ❗ Cómo usar estas notas

Estas notas **no son un curso** ni un sustituto de libros o clases.

- ❌ No es recomendable estudiar un tema *solo* con ellas.
- ✅ Funcionan bien como **acompañamiento**, resumen estructural o recordatorio rápido.
- El contenido no pretende ser *groundbreaking* ni original en el sentido académico.

---

## 🛠️ Compilación

No se proveen los PDFs generados.

Para compilar las notas necesitas:
- Un compilador de **LaTeX** (`latexmk`, `pdflatex`, etc.)
- Un visor de PDF (recomendado: **Zathura**)

> Aprender a compilar LaTeX vale completamente la pena.

---

## 🧠 Proceso y sistema de toma de notas

El sistema es algo complejo, pero extremadamente eficiente para tomar notas **en tiempo real**, incluso durante clases.

### 1. Editor de texto
Uso **Neovim** por:
- Velocidad
- Portabilidad
- Control total del entorno

---

### 2. Plugins y snippets
La clave del sistema.

- Los snippets permiten escribir matemáticas **a velocidad casi natural**.
- Los plugins están pensados para **no estorbar**, solo acelerar.
- Toda mi configuración vive en mi repositorio de  
  👉 [`dotfiles`](https://github.com/CsarrrX/dotfiles)

Más abajo se documentan los plugins y snippets principales usados aquí.

---

### 3. Organización
- Cada semestre tiene su propia carpeta.
- Dentro de cada semestre hay una carpeta por curso.
- Para simplificar el acceso, uso un **symlink** (cursoact) que apuntan al curso activo mediante un script de hora que se encuentra en mi .zshrc.
- Hay funciones en mi `.zshrc` para automatizar navegación y creación de archivos.
  - `view` abre con Zathura el pdf de la matería actual, y  `curso` cambia la dirección del symlink al que se especifique, `update_curso` cambia el curso conforme a mi horario. Además, mis dotfiles vienen con un script de tmux que inicializa todo por tí, solo hay que empezar a escribir. 

Todo esto también está documentado en mis dotfiles.

---

### 4. Figuras
Las figuras se crean usando **Inkscape**, integradas directamente con Neovim mediante Lua.

- Se genera automáticamente la figura
- Se inserta el entorno `figure` en LaTeX
- Se abre Inkscape para dibujar

Este flujo se explica en detalle más abajo.

---

## 🚀 Uso del sistema

### Plugins principales

#### 🎨 Tokyo Night
Tema visual limpio y sin distracciones.

- Plugin: `folke/tokyonight.nvim`
- Se carga al inicio
- Mejora legibilidad en sesiones largas

---

#### 📄 VimTeX
Soporte completo para LaTeX.

- Plugin: `lervag/vimtex`
- Compilación y sincronización inversa
- Visor configurado: **Zathura**

---

#### ✂️ LuaSnip
Motor de snippets en modo **standalone** para máxima velocidad.

- Expansión inmediata
- Soporte para regex
- Navegación con `Tab` y `Shift+Tab`
- Snippets cargados desde `user/snippets`

👉 El uso de snippets es **central** en este sistema.

---

## 🧩 LaTeX Snippets (Guía rápida)

> Todos los snippets se expanden con **Tab**

### Estructura
| Trigger | Resultado |
|-------|----------|
| `beg` | `\begin{...} ... \end{...}` |
| `sec` | `\section{}` |
| `sub` | `\subsection{}` |
| `ssub` | `\subsubsection{}` |

### Matemáticas
| Trigger | Resultado |
|-------|----------|
| `mk` | `$ ... $` |
| `dm` | `\[\n ... \n\]` |

### Operaciones
| Trigger | Resultado |
|-------|----------|
| `ff` | `\frac{}{}` |
| `sq` | `\sqrt{}` |
| `td` | `^{}` |
| `sub` | `_{} ` |

### Cálculo
| Trigger | Resultado |
|-------|----------|
| `int` | `\int` |
| `dint` | `\int_{-\infty}^{\infty}` |
| `sum` | `\sum_{i=1}^{n}` |
| `lim` | `\lim_{x \to \infty}` |
| `df` | `\frac{d}{dx}` |
| `part` | `\frac{\partial}{\partial x}` |

### Conjuntos y lógica
| Trigger | Resultado |
|-------|----------|
| `RR` | `\mathbb{R}` |
| `NN` | `\mathbb{N}` |
| `cc` | `\subset` |
| `inn` | `\in` |
| `imp` | `\implies` |
| `fa` | `\forall` |

### Regex (automáticos)
| Entrada | Resultado |
|-------|----------|
| `x1` | `x_{1}` |
| `A12` | `A_{12}` |
| `avv` | `\vec{a}` |

---

## 🖼️ Figuras con Inkscape (Workflow)

Este sistema permite crear figuras **sin salir de Neovim**.

### Cómo usarlo

1. Presiona: CTRL + f.
2. Ingresa el nombre de la figura.
3. Automáticamente:
- Se crea la carpeta `figures/` si no existe
- Se crea (o abre) un archivo `.svg`
- Se inserta en el `.tex`:
```tex
\begin{figure}[ht]
 \centering
 \incfig{nombre}
 \caption{nombre}
 \label{fig:nombre}
\end{figure}
```
4. Se abre inkscape con la figura.
**IMPORTANTE**: antes de cerrar inkscape es necesario exportar la figura a pdf con la opción saltar pdf y generar latex, es necesario para que incfig funcione bien

### Objetivo final
- Escribir matemáticas **rápido**
- Mantener **estructura y limpieza**
- Minimizar la **fricción mental**
- Tomar notas a nivel **universitario / posgrado** sin perder ideas

# Theoria.cls

**Theoria** is a modern LaTeX class tailored for physics research papers with lots of displayed mathematics. It uses contemporary fonts, a wide single-column layout, and a clean, readable look—ideal for manuscripts rich in long formulas, figures, and technical detail.

## Key Features

- **Fonts & Math**  
  - Libertinus text + NewTX math  
  - `mathalfa` for fancy script & fraktur alphabets  

- **Layout**  
  - Single-column, A4 paper with wide (3.5 cm) margins  
  - Comfortable line spacing for dense mathematical content  

- **Section Headings**  
  - Sans-serif, bold titles  
  - Colored underline for visual separation  

- **Abstract**  
  - Boxed environment with soft background  
  - Compact (9 pt) sans-serif font  

- **Drop Caps**  
  - Decorative initial-letter support via `\firstletter{}`  

- **Authors & Affiliations**  
  - Automatic, deduplicated numbering  
  - Per-author email & corresponding-author symbols  

- **Captions**  
  - Upright, footnotesize text  
  - Colored rule above each caption  

- **Bibliography**  
  - Default `apsrev4-2` style, footnotesize  

---

## Quick Start

1. **Install**  
   Place `Theoria.cls` in your working directory (or in a local `texmf` tree).

2. **Document Preamble**  
   ```latex
   \documentclass{Theoria}
   \title{My Physics Paper}
   \author{Alice A. Researcher}
   \email{alice@uni.edu}
   \affiliation{Department of Physics, Example University, City, Country}
   \author{Bob B. Scientist}
   \affiliation{Institute of Advanced Studies, Other University, Country}
   \date{\today}  % optional—date is suppressed by default
   ```

3. **Abstract**

   ```latex
   \begin{abstract}
   We present a new result on…
   \end{abstract}
   ```

4. **Drop-Cap Paragraph**

   ```latex
   \firstletter{I}n this introduction…
   ```

5. **Sections & Math**

   ```latex
   \section{Introduction}
   A displayed equation:
   \[
     E = mc^2.
   \]
   ```

6. **Figures & Captions**

   ```latex
   \begin{figure}[ht]
     \centering
     \includegraphics[width=0.6\columnwidth]{diagram}
     \caption{A sample diagram.}
   \end{figure}
   ```

7. **Bibliography**

   ```latex
   \bibliography{myrefs}
   ```

---

## License

This class is released under the **MIT License**, a permissive, non-restrictive open-source license. See [LICENSE](LICENSE) for details.


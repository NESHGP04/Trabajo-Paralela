# Trabajo-Paralela
OpenMP Trabajando con cálculos - Paralela

## Ejercicio 1
### Qué imprimió con Private?
Hilo 0, Planeta 0: Velocidad final = 49.00
Hilo 1, Planeta 1: Velocidad final = 18.50
Hilo 9, Planeta 9: Velocidad final = 2.90
Hilo 3, Planeta 3: Velocidad final = 8.10
Hilo 2, Planeta 2: Velocidad final = 44.35
Hilo 8, Planeta 8: Velocidad final = 1370.00
Hilo 7, Planeta 7: Velocidad final = 55.75
Hilo 6, Planeta 6: Velocidad final = 44.35
Hilo 5, Planeta 5: Velocidad final = 52.20
Hilo 4, Planeta 4: Velocidad final = 123.95

### Qué imprimió con FirstPrivate?
Hilo 3, Planeta 3: Velocidad final = 23.60
Hilo 6, Planeta 6: Velocidad final = 59.85
Hilo 9, Planeta 9: Velocidad final = 18.40
Hilo 8, Planeta 8: Velocidad final = 1385.50
Hilo 5, Planeta 5: Velocidad final = 67.70
Hilo 7, Planeta 7: Velocidad final = 71.25
Hilo 4, Planeta 4: Velocidad final = 139.45
Hilo 0, Planeta 0: Velocidad final = 64.50
Hilo 1, Planeta 1: Velocidad final = 34.00
Hilo 2, Planeta 2: Velocidad final = 59.85

## Ejercicio 2
### Cuántos nucleos funcionaron mejor?
| Integrante  | Núcleos  | T schedule(static) | T schedule(dynamic) | Diferencia |
| ----------- | -------- | ------------------ | ----------- | -----------|
| Camila      | 10       | 1.615673           | 1.413764    |0.037246    |
| Marinés     | 10       | 0.630255           | 0.593009    |0.037246    |
| Carlos      | 10       | 0.781017           | 0.662523    |0.118494    |

**Respuesta:** Aunque todos tenemos la misma cantidad de núcleos, la computadora de Marinés corrió en una cantidad de tiempo menor. 

### Cuál tipo de scheduling funciono mejor? Por qué creen?
El schedule dinámico funcionó mejor porque el costo de probar cada número no es constante y con dinamic cada hilo pide un chunk de 100 números a la vez, y en cuanto termina, pide el siguiente chunk disponible. Cada chunck es más "barato" y piden los piden más seguido en vez de agarrar más grandes.

## Ejercicio 3
### Cuántos nucleos funcionaron mejor y por qué?
| Integrante  | T serial    | T con sections| Speedup    |
| ----------- | ----------- | -----------   | -----------| 
| Camila      | 0.834404    | 0.372379      | 2.2138     |
| Marinés     | 0.211270    | 0.160535      | 1.316037   |
| Carlos      | 0.263889    | 0.074457      | 3.54       |

### Qué pueden argumentar de la cantidad de threds teóricos contra los reales a usar dado que tenemos sections definidas?
El número de hilos útiles está acotado por min, no por omp_get_num_procs(). Pedir más hilos que secciones es un desperdicio, y si quisieran aprovechar más cores en este problema, la solución sería paralelizar cada reducción internamente con parallel for en vez de depender solo de sections, ya que eso sí escala con el hardware disponible.

## Ejercicio 4
### Qué le pasa al speedup?
| Integrante  | T Serial    | T paralelo  | Speedup | Eficiencia |
| ----------- | ----------- | ----------- | ------- | -----------|
| Camila      | 1.049057    | 0.188219    | 5.57    | 55.7%      |
| Marinés     | 1.894006    | 0.182827    | 10.36   | 103.6%     |
| Carlos      | 0.505338    | 0.209372    | 2.41    | 24.1%      |

### Por qué es peligroso usar funciones que no sean thread-safe en paralelo?
Es peligroso porque puede crear race conditions sobre un estado global oculto. Esto causa que los resultados sean estadísticamente inválidos o que tengan un comportamiento indefinido.  
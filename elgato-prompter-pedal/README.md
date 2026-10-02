# Pedal improvisado para Elgato Prompter

Script de **AutoHotkey v2** que convierte los botones laterales del ratón en un
pedal para el Elgato Prompter mientras reparan el original.

La diferencia con asignar una tecla de "línea anterior" es que aquí se envía
**rueda del ratón**: el texto se desplaza de forma continua y suave mientras
mantienes pulsado el botón, y va acelerando poco a poco, como el pedal.

## Instalación

1. Instala [AutoHotkey v2](https://www.autohotkey.com/).
2. Descarga `teleprompter.ahk` de esta carpeta.
3. Haz doble clic en el archivo. Aparece un icono verde en la bandeja del sistema.
4. Abre Elgato Camera Hub / Prompter y deja el puntero del ratón **encima del texto**.
5. Mantén pulsado el botón lateral trasero para retroceder y el delantero para avanzar.

Para que arranque con Windows, crea un atajo del `.ahk` y pégalo en la carpeta
que abre `Win + R` → `shell:startup`.

## Controles

| Acción                          | Efecto                              |
|---------------------------------|-------------------------------------|
| Botón lateral atrás (XButton1)  | Texto hacia arriba, continuo        |
| Botón lateral adelante (XButton2)| Texto hacia abajo, continuo        |
| Tecla `Pausa`                   | Activa / desactiva el script        |

## Ajustes

Edita el bloque **CONFIGURACION** al inicio del script:

| Variable           | Qué hace                                                  | Por defecto |
|--------------------|-----------------------------------------------------------|-------------|
| `RetardoInicialMs` | Velocidad al empezar a pulsar. Más alto = más lento.      | 90          |
| `RetardoMinimoMs`  | Velocidad máxima tras acelerar. Más bajo = más rápido.    | 25          |
| `AceleracionMs`    | Cuánto acelera en cada paso. `0` = velocidad constante.   | 6           |
| `PasosPorTick`     | Saltos de rueda por paso. Súbelo si se mueve muy poco.    | 1           |
| `SoloEnPrompter`   | `true` para que los botones solo actúen en Camera Hub.    | false       |

Después de cambiar algo, guarda y haz clic derecho en el icono de la bandeja →
**Reload Script**.

## Sin botones laterales

Al final del script hay dos líneas comentadas para usar `Numpad4` / `Numpad6`
con el mismo comportamiento de desplazamiento continuo. Quita el `;` para activarlas.

## Si Windows no desplaza el Prompter

El desplazamiento con rueda llega a la ventana que está bajo el cursor. Si no
funciona, comprueba en *Configuración → Bluetooth y dispositivos → Mouse* que
esté activado **"Desplazar ventanas inactivas al mantener el puntero sobre ellas"**.

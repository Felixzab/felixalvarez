; =====================================================================
;  teleprompter.ahk  -  Pedal improvisado para Elgato Prompter
;  Requiere AutoHotkey v2  (https://www.autohotkey.com)
;
;  Convierte los botones laterales del raton en DESPLAZAMIENTO CONTINUO
;  del texto (rueda del raton), no en "linea anterior / siguiente".
;  Mientras mantienes pulsado el boton, el texto sigue moviendose y va
;  acelerando poco a poco, parecido al pedal original.
;
;    Boton lateral "atras"    (XButton1) -> texto hacia arriba  (retroceder)
;    Boton lateral "adelante" (XButton2) -> texto hacia abajo   (avanzar)
;    Tecla Pausa                         -> activa / desactiva el script
;
;  IMPORTANTE: Windows manda la rueda a la ventana que esta debajo del
;  cursor. Deja el puntero encima del texto del Prompter / Camera Hub.
; =====================================================================

#Requires AutoHotkey v2.0
#SingleInstance Force

; ------------------------- CONFIGURACION -----------------------------

BotonAtras    := "XButton1"   ; boton lateral trasero del raton
BotonAdelante := "XButton2"   ; boton lateral delantero del raton

RetardoInicialMs := 90        ; pausa entre "pasos" al empezar (mas alto = mas lento)
RetardoMinimoMs  := 25        ; pausa minima al acelerar     (mas bajo  = mas rapido)
AceleracionMs    := 6         ; cuanto se reduce la pausa en cada paso (0 = sin aceleracion)
PasosPorTick     := 1         ; cuantos "clicks" de rueda se envian en cada paso

; true  -> los botones solo actuan cuando Camera Hub / Prompter esta activo
; false -> actuan en cualquier ventana
SoloEnPrompter := false
ProcesoPrompter := "Camera Hub.exe"

; ---------------------------------------------------------------------

TrayTip "Pedal de teleprompter activo", "Pausa = activar/desactivar", 1

Desplazar(boton, direccion) {
    global RetardoInicialMs, RetardoMinimoMs, AceleracionMs, PasosPorTick
    retardo := RetardoInicialMs
    while GetKeyState(boton, "P") {
        Send "{" direccion " " PasosPorTick "}"
        Sleep retardo
        if (retardo > RetardoMinimoMs)
            retardo := Max(RetardoMinimoMs, retardo - AceleracionMs)
    }
}

#HotIf !SoloEnPrompter || WinActive("ahk_exe " ProcesoPrompter)

Hotkey "*" BotonAtras,    (*) => Desplazar(BotonAtras,    "WheelUp")
Hotkey "*" BotonAdelante, (*) => Desplazar(BotonAdelante, "WheelDown")

#HotIf

; Tecla Pausa: suspende o reanuda el script sin cerrarlo
Pause::{
    Suspend -1
    TrayTip "Pedal de teleprompter", (A_IsSuspended ? "DESACTIVADO" : "ACTIVADO"), 1
}

; ----------------- ALTERNATIVA: sin botones laterales ----------------
; Si tu raton no tiene botones laterales, borra el ";" de las lineas de
; abajo para usar dos teclas del teclado numerico con el mismo efecto.
;
; *Numpad4::Desplazar("Numpad4", "WheelUp")
; *Numpad6::Desplazar("Numpad6", "WheelDown")

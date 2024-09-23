#Requires AutoHotkey v2.0

IMC_GETOPENSTATUS := 0x005
WM_IME_CONTROL := 0x283

GetInputLocaleIndex() {
    hWnd := WinActive("A")
    ImmGetDefaultIMEWnd(hWnd) => DllCall("imm32\ImmGetDefaultIMEWnd", "UInt", hWnd)
    hIME := ImmGetDefaultIMEWnd(hWnd)
    status := DllCall("user32\SendMessage", "UInt", hIME, "UInt", WM_IME_CONTROL, "UInt", IMC_GETOPENSTATUS, "UInt", 0)
    lang := (status ? "Korean" : "English")

    ; Using VSCode Extension: AutoHotKey Plus Plus v5.0.7
    OutputDebug mm . " : ", status + 1
    
    ; 1: English, 2: Korean
    return status + 1
}

;; References
;1. https://stackoverflow.com/questions/64280975/immgetcontext-returns-zero-alwayshttps://stackoverflow.com/questions/64280975/immgetcontext-returns-zero-always
;2. WM_IME_CONTROL value from Claude.ai

; Hotkey to check
^+l::GetInputLocaleIndex()

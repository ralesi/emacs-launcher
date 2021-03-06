#NoTrayIcon
#NoEnv
#SingleInstance ignore
SetWorkingDir %A_ScriptDir%
Gui, +OwnDialogs

App = %A_ScriptDir%\el.exe
Title = Emacs
; """" A_AhkPath """ """ A_ScriptFullPath """ ""``%1"""

RegRead, ExistingEntry, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\Edit

; MsgBox %ExistingEntry%

If not ErrorLevel {
    RegDelete, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%
    RegDelete, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%
    MsgBox, 0x40, %Title%, Emacs context entry removed.

} Else {
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%, SubCommands , "" 
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%, Icon, %App%

    ; File Context Menu
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\Edit, ,&Edit with Emacs
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\Edit\command, ,"%App%" "`%1"
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\Diff, , &Diff Files
    ; RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\Diff\command, ,"%App%" -d "`%1" "`%2"
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\NewTab, , Edit with Emacs (New &Tab)
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\NewTab\command, , "%App%" -t "`%1"
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\vsplit, , Edit with Emacs (&Vertical Split)
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\vsplit\command, , "%App%" -v "`%1"
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\split, , Edit with Emacs (Horizontal &Split)
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\*\shell\%Title%\shell\split\command, , "%App%" -o "`%1"

    ; Directory Context Menu
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%, SubCommands,""
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%, Icon, %App%

    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\Edit,,&Browse Directory with Emacs
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\Edit\command, ,"%App%" "`%1"
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\NewTab, ,Browse Directory with Emacs (New &Tab)
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\NewTab\command, ,"%App%" -t "`%1"
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\vsplit, ,Browse Directory with Emacs (&VSplit)
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\vsplit\command, ,"%App%" -v "`%1"
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\split, ,Browse Directory with Emacs (&Split)
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Classes\Directory\shell\%Title%\shell\split\command, ,"%App%" -o "`%1"

    MsgBox, 0x40, %Title%, Emacs context entry added.
}

; TODO create method to DIFF files

FileCreateShortcut, %App%, %A_StartMenu%\Programs\Emacs.lnk

ExitApp

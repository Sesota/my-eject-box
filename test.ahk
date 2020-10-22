#SingleInstance force
SetWinDelay, 5

starting_win_title := "Ubuntu"
win_PID := 0
run_command := "wt.exe"
win_height := A_ScreenHeight * 0.8
win_width := A_ScreenWidth
win_step := 100
win_transparency := 200

previousWindow := 0

F2::
IfWinExist, ahk_pid %win_PID% 
{
    if !WinActive("ahk_pid " win_PID){
        previousWindow := WinActive("A")
        WinActivate, ahk_pid %win_PID%
        Down(win_PID, win_width, win_height, win_step)
    }
    else{
        Up(win_PID, win_width, win_height, win_step)
        WinActivate, ahk_id %previousWindow%
    }
}
else{
    previousWindow := WinActive("A")
    Run, % run_command
    WinWait, % starting_win_title
    Sleep 200
    WinGet, win_PID, PID, % starting_win_title
    WinSet, Transparent, % win_transparency, ahk_pid %win_PID%
    WinActivate, ahk_pid %win_PID%
    WinMove, ahk_pid %win_PID%,, 0, 0, % win_width, % win_height
}
return

Up(pid, width, height, step)
{
    Loop, % height//step
    {
        WinMove, ahk_pid %pid%,, 0, % (-40-step*A_Index), % width, % height
    }
    return
}

Down(pid, width, height, step)
{
    Loop, % height//step
    {
        WinMove, ahk_pid %pid%,, 0, % (40-height+step*A_Index), % width, % height
    }
    return
}


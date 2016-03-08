#SingleInstance force

TemplateDir = C:\Users\Roscoe\Desktop\Cue2Cue\cues
TemplateNumber := 0

Gui, Add, Button, x123 y171 w160 h-80 , Button
Gui, Add, Button, x13 y61 w100 h30 , Prev
Gui, Add, Button, x153 y61 w100 h30 , Next
Gui, Add, Button, x83 y21 w100 h30 , Go to
Gui, Add, Button, x83 y101 w100 h30 , Convert CSV
; Generated using SmartGUI Creator for SciTE
Gui, Show, w278 h157, Untitled GUI
return

GuiClose:
ExitApp

ButtonGoto:
^+Up::
InputBox, TemplateNumber, Go to template, Which template number?
SwitchTemplate(TemplateNumber)
return

ButtonConvertCSV:
^+Down::
FileSelectFile, CsvFile
SplitPath, CsvFile,, OutDir
OutDir = %OutDir%\cues
if (CsvFile = ) {
	MsgBox, Nothing selected
} else {
	FileDelete, %OutDir%\*.RTrackTemplate
	Loop, Read, %CsvFile%
	{
		TemplateFile = %OutDir%\Cue %A_Index%.RTrackTemplate
		
		
		Loop, parse, A_LoopReadLine, CSV
		{
			FileAppend, <TRACK`n  NAME %A_LoopField%`n>`n, %TemplateFile%
		}
	}
}
return

ButtonPrev:
^+Left::
if (TemplateNumber <= 1) {
	TemplateNumber = 1
} else {
	TemplateNumber := TemplateNumber - 1
}
SwitchTemplate(TemplateNumber)
return

ButtonNext:
^+Right::
TemplateNumber := TemplateNumber + 1
SwitchTemplate(TemplateNumber)
return

SwitchTemplate(TemplateNumber)
{
	global TemplateDir
	MsgBox, , , Template - %TemplateNumber%, 0.5
	TemplateFile = %TemplateDir%\Cue %TemplateNumber%.RTrackTemplate
	WinMenuSelectItem, ahk_class REAPRwnd, , Edit, Select all items/tracks/envelope points
	SendInput, {Del}
	Run, %TemplateFile%
	return
}
;Programmed by hXR16F
;hXR16F.ar@gmail.com

#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ###
$APC = GUICreate("", 422, 292, 389, 126)
GUISetIcon("C:\Windows\System32\shell32.dll", -51)
$Group1 = GUICtrlCreateGroup("File", 8, 4, 405, 79)
$Input1 = GUICtrlCreateInput("Example.rar", 24, 46, 373, 21)
$Label1 = GUICtrlCreateLabel("Filename of archive:", 24, 26, 99, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)

$Button1 = GUICtrlCreateButton("Crack", 8, 232, 405, 25)
$StatusBar1 = _GUICtrlStatusBar_Create($APC)
Dim $StatusBar1_PartsWidth[1] = [-1]
_GUICtrlStatusBar_SetParts($StatusBar1, $StatusBar1_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar1, @TAB & "Archive Password Cracker by hXR16F", 0)

$Group3 = GUICtrlCreateGroup("Configurations", 8, 86, 405, 137)
$Label3 = GUICtrlCreateLabel("Filename of wordlist:", 24, 108, 99, 17)
$Input2 = GUICtrlCreateInput("Wordlists/Top_1000.txt", 24, 128, 373, 21)
$Label4 = GUICtrlCreateLabel("Number of digits:", 218, 164, 83, 17)
$Input3 = GUICtrlCreateInput("4", 218, 184, 31, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_LOWERCASE,$ES_NUMBER))
GUICtrlSetLimit(-1, 2)
$Label5 = GUICtrlCreateLabel("Method:", 24, 164, 43, 17)
$Combo1 = GUICtrlCreateCombo("", 24, 184, 127, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Wordlist|Brute-Force|Random Brute-Force", "Wordlist")
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Button1
			Local $ArchiveData = GUICtrlRead($Input1)
			Local $Method = GUICtrlRead($Combo1)
			Local $WordlistData = GUICtrlRead($Input2)
			Local $DigitsData = GUICtrlRead($Input3)

			If $Method = "Wordlist" Then
				$MethodData = 1
			ElseIf $Method = "Brute-Force" Then
				$MethodData = 2
			ElseIf	$Method = "Random Brute-Force" Then
				$MethodData = 3
			EndIf

			FileWrite(@ScriptDir & "\input.ini", $ArchiveData & @CRLF & $MethodData & @CRLF & $WordlistData & @CRLF & $DigitsData)
			ShellExecute(@ScriptDir & "\APC.bat")

	EndSwitch
WEnd















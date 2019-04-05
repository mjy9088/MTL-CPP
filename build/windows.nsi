!include "MUI2.nsh"
!include "x64.nsh"

Unicode true

!define ProductVersion "0.0.1"
!define ProductName "MTL-CPP"

Name "${ProductName} ${ProductVersion} installer"
OutFile "output\${ProductName}_${ProductVersion}.exe"
Caption "${ProductName} ${ProductVersion} installer"
LicenseData "../LICENSE.txt"
InstallDir "$PROGRAMFILES\MTL\cpp"

ShowInstDetails show
AutoCloseWindow false
SilentInstall normal
CRCCheck on
SetCompressor /SOLID /FINAL lzma
SetDatablockOptimize on
SetOverwrite try
XPStyle on

InstType "Recommended"
InstType "Full"
InstType "Minimal"
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SectionMain} "${ProductName} minimal"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionSource} "${ProductName} original source code"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionAssocs} "Use ${ProductName} as the default application for opening these types of files"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcuts} "Create shortcuts to ${ProductName} in various folders"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

RequestExecutionLevel admin

!define MUI_ICON "favicon.ico"
!define MUI_UNICON "favicon.ico"
!define MUI_ABORTWARNING
;!define MUI_LANGDLL_ALLLANGUAGES
!define MUI_COMPONENTSPAGE_SMALLDESC

!define MUI_FINISHPAGE_TITLE "Install ${ProductName} ${ProductVersion} successfully completed!$\r$\n$\r$\nYou can launch ${ProductName} and/or see README.txt"
!define MUI_FINISHPAGE_TITLE_3LINES

!define MUI_FINISHPAGE_NOREBOOTSUPPORT

!define MUI_FINISHPAGE_RUN "$INSTDIR\MTL.exe"
!define MUI_FINISHPAGE_RUN_CHECKED
!define MUI_FINISHPAGE_RUN_TEXT "Run ${ProductName}"

Function FinishpageAction
  ExecWait "notepad $INSTDIR\README.txt"
FunctionEnd
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_CHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show README.txt"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION FinishpageAction

!define MUI_FINISHPAGE_LINK "You can visit ${ProductName} repository on GitHub"
!define MUI_FINISHPAGE_LINK_LOCATION "https://github.com/mjy9088/${ProductName}"
!define MUI_FINISHPAGE_LINK_COLOR 0000C0

!insertmacro MUI_LANGUAGE "English"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "../LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_LICENSE "../LICENSE.txt"
!insertmacro MUI_UNPAGE_COMPONENTS
!insertmacro MUI_UNPAGE_DIRECTORY
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

Function .onInit

  ReadRegStr $R0 HKLM \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${ProductName}" \
  "UninstallString"
  StrCmp $R0 "" done
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION \
  "${ProductName} is already installed. $\n$\nClick `OK` to remove the \
  previous version or `Cancel` to cancel this upgrade." \
  IDOK uninst
  Abort

 uninst:
  ClearErrors
  ExecWait '$R0 _?=$INSTDIR'
  IfErrors no_remove_uninstaller done
  no_remove_uninstaller:

 done:

FunctionEnd

Section "MTL program files (required)" SectionMain
  SectionIn 1 2 3 RO
  SetOutPath $INSTDIR
  WriteUninstaller "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "DisplayName" "${ProductName}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "DisplayVersion" "0.0.1"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "DisplayIcon" "$INSTDIR\MTL.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "Publisher" "mjy9088"
  File "favicon.ico"
  File "..\LICENSE.txt"
  File /oname=MTL.exe ..\mtl\main.exe
SectionEnd

Section "MTL original source" SectionSource
  SectionIn 2
  SetOutPath "$INSTDIR"
  File /r "..\original"
SectionEnd

SubSection "Shortcuts" SectionShortcuts

 Section "Create Start Menu shortcuts" SectionMenuLaunch
  SectionIn 1 2 3
  SetShellVarContext all 
  StrCpy $0 $SMPROGRAMS
  CreateDirectory "$0\MTL"
  CreateShortCut "$0\MTL\${ProductName}.lnk" "$INSTDIR\MTL.exe"
  CreateShortCut "$0\MTL\Uninstall ${ProductName}.lnk" "$INSTDIR\uninstall.exe"
 SectionEnd

 Section "Create Desktop shortcut" SectionDesktopLaunch
  SectionIn 1 2
  SetShellVarContext current
  CreateShortCut "$DESKTOP\${ProductName}.lnk" "$INSTDIR\MTL.exe"
 SectionEnd

SubSectionEnd

SubSection "Associate ${ProductName} related files to ${ProductName}" SectionAssocs

 Section "Associate .${ProductName} files to ${ProductName}"
  SectionIn 1 2 3
  WriteRegStr HKCR ".${ProductName}" "" "${ProductName}"
  WriteRegStr HKCR "${ProductName}" "" "${ProductName} Source File"
  WriteRegStr HKCR "${ProductName}\DefaultIcon" "" "$INSTDIR\MTL.exe,1"
  WriteRegStr HKCR "${ProductName}\shell\open\command" "" '"$INSTDIR\MTL.exe" "%1"'
 SectionEnd

SubSectionEnd

ShowUninstDetails show

Section Uninstall
SectionEnd

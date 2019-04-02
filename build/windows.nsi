!include "MUI2.nsh"
!include "x64.nsh"

Unicode true

Name "MTL-CPP installer"
OutFile "output\x64.exe"
Caption "MTL-CPP installer"
; LicenseData "LICENSE.txt"
InstallDir $PROGRAMFILES\MTL\cpp

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

RequestExecutionLevel admin

!define ProductVersion "0.0.1"

!define MUI_ICON "favicon.ico"
!define MUI_UNICON "favicon.ico"
!define MUI_ABORTWARNING
!define MUI_LANGDLL_ALLLANGUAGES
!define MUI_FINISHPAGE_RUN "$INSTDIR\MTL.exe"
!define MUI_FINISHPAGE_RUN_CHECKED
!define MUI_FINISHPAGE_RUN_TEXT "Run MTL-CPP"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_COMPONENTSPAGE_SMALLDESC

Function finishpageaction
  ExecWait 'notepad $INSTDIR\README.txt'
FunctionEnd
!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_CHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "ReadMe"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION finishpageaction
;!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

Page directory
Page instfiles

Section "MTL program files (required)" SectionMain
  SectionIn 1 2 3 RO
  SetOutPath $INSTDIR
  WriteUninstaller "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "DisplayName" "MTL-CPP"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "DisplayVersion" "0.0.1"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "DisplayIcon" "$INSTDIR\MTL.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP" "Publisher" "mjy9088"
  File "favicon.ico"
  ;File "LICENSE.txt"
  File /oname=MTL.exe ..\mtl\main.exe
SectionEnd

Section "MTL original source" SectionSource
  SectionIn 2
  SetOutPath $INSTDIR
  File /r ..\original
SectionEnd

SubSection "Shortcuts" SectionShortcuts

 Section "Create Start Menu shortcuts" SectionMenuLaunch
  SectionIn 1 2 3
  SetShellVarContext all 
  StrCpy $0 $SMPROGRAMS
  CreateDirectory "$0\MTL"
  CreateShortCut "$0\MTL\MTL-CPP.lnk" "$INSTDIR\MTL.exe"
  CreateShortCut "$0\MTL\Uninstall MTL-CPP.lnk" "$INSTDIR\uninstall.exe"
 SectionEnd

 Section "Create Desktop shortcut" SectionDesktopLaunch
  SectionIn 1 2
  SetShellVarContext current
  CreateShortCut "$DESKTOP\MTL-CPP.lnk" "$INSTDIR\MTL.exe"
 SectionEnd

SubSectionEnd

SubSection "Associate MTL files to MTL-CPP" SectionAssocs

 Section "Associate .mtl-cpp files to MTL-CPP"
  SectionIn 1 2 3
  StrCpy $0 ".mtl-cpp"
  Call BackupAssoc
  WriteRegStr HKCR ".mtl-cpp" "" "MTL-CPP"
  WriteRegStr HKCR "MTL-CPP" "" "MTP-CPP Source File"
 SectionEnd

SubSectionEnd

UninstallText "This program will uninstall MTL-CPP, continue?"
ShowUninstDetails show

Section Uninstall
SectionEnd

Function BackupAssoc
  ReadRegStr $1 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP\Backup" "$0"
  StrCmp $1 "" 0 no_assoc
  ReadRegStr $1 HKCR "$0" ""
  StrCmp $1 "MTL-CPP$0" no_assoc
  StrCmp $1 "" no_assoc
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\MTL-CPP\Backup" "$0" "$1"
  no_assoc:
FunctionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SectionMain} "MTL-CPP minimum"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionSource} "MTL-CPP original source code"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionAssocs} "Use MTL-CPP as the default application for opening these types of files"
!insertmacro MUI_DESCRIPTION_TEXT ${SectionShortcuts} "Create shortcuts to MTL-CPP in various folders"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

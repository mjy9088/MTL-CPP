!include "MUI2.nsh"

Name "MTL-CPP installer"
OutFile output\installer.exe
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

InstType "Full"

RequestExecutionLevel admin

!define MUI_ICON "favicon.ico"
!define MUI_UNICON "favicon.ico"
!define MUI_ABORTWARNING
!define MUI_LANGDLL_ALLLANGUAGES
!define MUI_FINISHPAGE_RUN "$INSTDIR\mtl.exe"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_COMPONENTSPAGE_SMALLDESC

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

Section "MTL original source"
  SectionIn 1 2
  SetOutPath $INSTDIR
  File /r ..\original
SectionEnd

SubSection "Associate MTL files to MTL-CPP" SectionAssocs

 Section "Associate .mtl-cpp files to MTL-CPP"
  SectionIn 1
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

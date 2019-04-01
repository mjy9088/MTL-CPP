Name "MTL-CPP installer"
OutFile output\installer.exe
InstallDir $PROGRAMFILES\MTL\cpp
ShowInstDetails show

RequestExecutionLevel admin

Page directory
Page instfiles

Section ""

  SetOutPath $INSTDIR
  File ..\mtl\main.exe

SectionEnd

VERSION 5.00
Begin VB.Form frmKeepNotes 
   BorderStyle     =   0  'None
   Caption         =   "Player Notes"
   ClientHeight    =   5235
   ClientLeft      =   45
   ClientTop       =   0
   ClientWidth     =   4260
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   Picture         =   "frmKeepNotes.frx":0000
   ScaleHeight     =   5235
   ScaleWidth      =   4260
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Close 
      Appearance      =   0  'Flat
      Caption         =   "Cerrar Notas"
      Height          =   210
      Left            =   2760
      TabIndex        =   2
      Top             =   4920
      Width           =   1335
   End
   Begin VB.CommandButton Save 
      Appearance      =   0  'Flat
      BackColor       =   &H00789298&
      Caption         =   "Guardar Notas"
      Height          =   210
      Left            =   120
      MaskColor       =   &H00789298&
      TabIndex        =   1
      Top             =   4920
      Width           =   1335
   End
   Begin VB.TextBox Notetext 
      Appearance      =   0  'Flat
      Height          =   3975
      Left            =   120
      TabIndex        =   0
      Top             =   840
      Width           =   3960
   End
End
Attribute VB_Name = "frmKeepNotes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Close_Click()
frmKeepNotes.Visible = False
End Sub

Private Sub Form_Load()
Dim i As Long
Dim Ending As String
    For i = 1 To 3
        If i = 1 Then Ending = ".gif"
        If i = 2 Then Ending = ".jpg"
        If i = 3 Then Ending = ".png"
 
        If FileExist("GUI\Notes" & Ending) Then frmKeepNotes.Picture = LoadPicture(App.Path & "\GUI\Notes" & Ending)
    Next i
End Sub

Private Sub Save_Click()
Dim iFileNum As Integer

'Get a free file handle
iFileNum = FreeFile

'If the file is not there, one will be created
'If the file does exist, this one will
'overwrite it.
Open App.Path & "\notes.txt" For Output As iFileNum

Print #iFileNum, Notetext.Text

Close iFileNum

End Sub


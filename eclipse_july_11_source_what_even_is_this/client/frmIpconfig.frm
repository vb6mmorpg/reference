VERSION 5.00
Begin VB.Form frmIpconfig 
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Configure Server IP"
   ClientHeight    =   5895
   ClientLeft      =   165
   ClientTop       =   405
   ClientWidth     =   5940
   ControlBox      =   0   'False
   Icon            =   "frmIpconfig.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmIpconfig.frx":0FC2
   ScaleHeight     =   5895
   ScaleWidth      =   5940
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox TxtPort 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   480
      TabIndex        =   1
      Top             =   3120
      Width           =   3375
   End
   Begin VB.TextBox TxtIP 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   480
      TabIndex        =   0
      Top             =   2280
      Width           =   3375
   End
   Begin VB.Label PicCancel 
      BackStyle       =   0  'Transparent
      Caption         =   "Cancel"
      ForeColor       =   &H0080FF80&
      Height          =   255
      Left            =   5040
      TabIndex        =   5
      Top             =   5160
      Width           =   615
   End
   Begin VB.Label PicConfirm 
      BackStyle       =   0  'Transparent
      Caption         =   "Confirm"
      ForeColor       =   &H0080FF80&
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   5160
      Width           =   615
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Enter Server IP"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080FF80&
      Height          =   255
      Left            =   600
      TabIndex        =   3
      Top             =   2040
      Width           =   1095
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Enter Server Port"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080FF80&
      Height          =   255
      Left            =   600
      TabIndex        =   2
      Top             =   2880
      Width           =   1095
   End
End
Attribute VB_Name = "frmIpconfig"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
Dim i As Long
Dim Ending As String
    For i = 1 To 3
        If i = 1 Then Ending = ".gif"
        If i = 2 Then Ending = ".jpg"
        If i = 3 Then Ending = ".png"
 
        If FileExist("GUI\IPConfig" & Ending) Then frmIpconfig.Picture = LoadPicture(App.Path & "\GUI\IPConfig" & Ending)
    Next i
    
    Dim FileName As String
    FileName = App.Path & "\config.ini"
    TxtIP = ReadINI("IPCONFIG", "IP", FileName)
    TxtPort = ReadINI("IPCONFIG", "PORT", FileName)
    TxtIP.Text = ReadINI("IPCONFIG", "IP", FileName)
    TxtPort.Text = ReadINI("IPCONFIG", "PORT", FileName)
End Sub

Private Sub picCancel_Click()
    frmMainMenu.Visible = True
    frmIpconfig.Visible = False
End Sub

Private Sub picConfirm_Click()
    Dim IP, Port As String
    Dim fErr As Integer
    Dim Texto As String
        
    IP = TxtIP
    Port = Val#(TxtPort)

    fErr = 0
    If fErr = 0 And Len(Trim$(IP)) = 0 Then
        fErr = 1
        Call MsgBox("Please Fix The IP!", vbCritical, GAME_NAME)
        Exit Sub
    End If
    If fErr = 0 And Port <= 0 Then
        fErr = 1
        Call MsgBox("Please Fix The Port!", vbCritical, GAME_NAME)
        Exit Sub
    End If
    If fErr = 0 Then
        ' Gravar IP e Porta
        Call WriteINI("IPCONFIG", "IP", TxtIP.Text, (App.Path & "\config.ini"))
        Call WriteINI("IPCONFIG", "PORT", TxtPort.Text, (App.Path & "\config.ini"))
        'Call MenuState(MENU_STATE_IPCONFIG)
    End If
    frmMirage.Socket.Close
    frmMirage.Socket.RemoteHost = TxtIP.Text
    frmMirage.Socket.RemotePort = TxtPort.Text
    frmMainMenu.Visible = True
    frmIpconfig.Visible = False
End Sub

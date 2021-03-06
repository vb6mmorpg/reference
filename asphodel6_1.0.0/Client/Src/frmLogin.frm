VERSION 5.00
Begin VB.Form frmLogin 
   BackColor       =   &H00404040&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Asphodel Source (Login)"
   ClientHeight    =   4515
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7515
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmLogin.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4515
   ScaleWidth      =   7515
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkRemember 
      Height          =   240
      Left            =   4320
      TabIndex        =   8
      Top             =   2400
      Width           =   200
   End
   Begin VB.TextBox txtPassword 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   270
      IMEMode         =   3  'DISABLE
      Left            =   4320
      MaxLength       =   20
      PasswordChar    =   "*"
      TabIndex        =   5
      Top             =   2040
      Width           =   2895
   End
   Begin VB.TextBox txtName 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   270
      Left            =   4320
      MaxLength       =   20
      TabIndex        =   1
      Top             =   1680
      Width           =   2895
   End
   Begin VB.Label lblRemember 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Remember"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   4500
      TabIndex        =   9
      Top             =   2420
      UseMnemonic     =   0   'False
      Width           =   915
   End
   Begin VB.Label lblConnect 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Connect"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   5160
      TabIndex        =   7
      Top             =   2760
      UseMnemonic     =   0   'False
      Width           =   915
   End
   Begin VB.Label lblCancel 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   6360
      TabIndex        =   6
      Top             =   4080
      Width           =   915
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Login"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3960
      TabIndex        =   0
      Top             =   240
      UseMnemonic     =   0   'False
      Width           =   2535
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Name : "
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3360
      TabIndex        =   4
      Top             =   1680
      UseMnemonic     =   0   'False
      Width           =   855
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Enter a account name and password.  "
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   3360
      TabIndex        =   3
      Top             =   1080
      Width           =   3255
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Password : "
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   3000
      TabIndex        =   2
      Top             =   2040
      Width           =   1215
   End
End
Attribute VB_Name = "frmLogin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' ------------------------------------------
' --               Asphodel               --
' ------------------------------------------

Private Sub Form_Load()
    Me.Picture = LoadPicture(App.Path & GFX_PATH & "interface\Menu.bmp")
End Sub

Private Sub lblConnect_Click()
Dim FileName As String

    FileName = App.Path & "/info.ini"
    
    If Remember Then
        If GetVar(FileName, "BASIC", "Account") <> txtName.Text Then PutVar FileName, "BASIC", "Account", txtName.Text
        If GetVar(FileName, "BASIC", "Password") <> txtPassword.Text Then PutVar FileName, "BASIC", "Password", txtPassword.Text
    End If
    
    If isLoginLegal(txtName.Text, txtPassword.Text) Then
        
        ' checking if server is online block
        Me.Visible = False
        
        SetStatus "Connecting to server..."
        
        If Not ConnectToServer Then
            MsgBox "The server appears to be down." & vbNewLine & _
                   "Please check back later!", , "Error"
            Me.Visible = True
            frmStatus.Visible = False
            Exit Sub
        End If
        
        frmStatus.Visible = False
        Me.Visible = True
        
        Check_Password
        
        Do Until Config_Received
            DoEvents
            Sleep 1
        Loop
        ' end of checking if server is online
        
        MenuState Menu_State.Login_
        
    End If
    
End Sub

Private Sub lblCancel_Click()
Dim FileName As String

    FileName = App.Path & "/info.ini"

    If Remember Then
        If GetVar(FileName, "BASIC", "Account") <> txtName.Text Then PutVar FileName, "BASIC", "Account", txtName.Text
        If GetVar(FileName, "BASIC", "Password") <> txtPassword.Text Then PutVar FileName, "BASIC", "Password", txtPassword.Text
    End If
    
    CurrentWindow = Window_State.Main_Menu
    
    frmMainMenu.Visible = True
    frmLogin.Visible = False
    
End Sub

Private Sub chkRemember_Click()
Dim FileName As String

    If LenB(txtName.Text) > 0 Then
        If LenB(txtPassword.Text) > 0 Then
            
            FileName = App.Path & "/info.ini"
            
            If chkRemember.Value = 1 Then
                PutVar FileName, "BASIC", "Account", txtName.Text
                PutVar FileName, "BASIC", "Password", txtPassword.Text
                PutVar FileName, "BASIC", "Remember", CStr(1)
                Remember = True
            Else
                PutVar FileName, "BASIC", "Account", vbNullString
                PutVar FileName, "BASIC", "Password", vbNullString
                PutVar FileName, "BASIC", "Remember", CStr(0)
                Remember = False
            End If
            Exit Sub
        
        End If
    End If
    
    chkRemember.Value = 0
    PutVar FileName, "BASIC", "Remember", CStr(0)
    Remember = False
    
End Sub

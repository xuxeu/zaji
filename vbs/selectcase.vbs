Dim color,myavar
Sub changebackgroud(color)
myvar = LCase(color)
Select Case myvar          
Case "red" document.bgcolor = "red"
Case "green" document.bgcolor = "green"
Case "blue" document.bgcolor = "blue"
Case Else MsgBox "oher"
End Select
End Sub
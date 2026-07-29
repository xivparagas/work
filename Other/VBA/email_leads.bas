Sub SendReminders()

Dim ChosenRange As Range
Dim ChosenRow As Range

Dim OutlookApp As Object
Dim CreatedEmail As Object

Dim EmailAddress As String
Dim EmailSubject As String
Dim EmailBody As String
Dim CurrentDate As String
Dim FollowUpDate As String

Set ChosenRange = Range("C:E")
    For Each ChosenRow In ChosenRange.Rows
        CurrentDate = Date
        FollowUpDate = Range("E" & ChosenRow.Row)
        EmailAddress = Range("C" & ChosenRow.Row)
        EmailSubject = "Lead Follow Up Reminder"
        EmailBody = "Lead Information Below: " & vbCrLf & vbCrLf & Range("D" & ChosenRow.Row)
        
        If CurrentDate = FollowUpDate Then
            Set OutlookApp = CreateObject("Outlook.Application")
            Set CreatedEmail = OutlookApp.CreateItem(0)
            With CreatedEmail
            .To = EmailAddress
            .Subject = EmailSubject
            .Body = EmailBody
            .Send
            End With
        End If
        
    Next ChosenRow
End Sub

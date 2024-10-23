<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<script language="javascript"></script>
<%
Sub backend()
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
        name = Request.Form("name")
        Dim maxNumber, randomNumber, guessNumber
        maxNumber = CInt(Request.Form("numberInput")) ' Ensure valid conversion

        If (maxNumber <= 1) Then
            Response.Write("Invalid input!")
        Else
            Response.Write("Hi " & name & ", ready to guess the random number!<br>")
        End If

        Dim min
        min = 1
        Randomize ' Correct placement of Randomize
        randomNumber = Int((maxNumber - min + 1) * Rnd + min)

        ' Store values in cookies
        Response.Cookies("randomNumber") = randomNumber
        Response.Cookies("min") = min
        Response.Cookies("max") = maxNumber
        Response.Cookies("name") = name

        ' Handle guesses
        If Request.Form("guessNumber") <> "" Then
            randomNumber = CInt(Response.Cookies("randomNumber"))
            min = CInt(Response.Cookies("min"))
            max = CInt(Response.Cookies("max"))
            name = Response.Cookies("name")
            guessNumber = CInt(Request.Form("guessNumber")) ' Assign correctly

            ' Validate and compare guess
            If guessNumber < min Or guessNumber > max Then
                Response.Write("<h2>Error: Your guess is out of range!</h2>")
            ElseIf guessNumber < randomNumber Then
                Response.Write("<h2>Your guess of " & guessNumber & " is too low!</h2>")
                min = guessNumber ' Update the minimum range
            ElseIf guessNumber > randomNumber Then
                Response.Write("<h2>Your guess of " & guessNumber & " is too high!</h2>")
                max = guessNumber ' Update the maximum range
            Else
                Response.Write("<h2>Congratulations! You guessed the number: " & randomNumber & "!</h2>")
                ' Clear cookies for a new game
                Response.Cookies("randomNumber") = ""
                Response.Cookies("min") = ""
                Response.Cookies("max") = ""
                Response.Cookies("name") = ""
            End If

            ' Update cookies with new min/max range
            Response.Cookies("min") = min
            Response.Cookies("max") = max
            Response.Write("<p>Your current guessing range is: " & min & " to " & max & "</p>")
        End If
    End If
    Exit Sub ' Ensure Sub ends properly
End Sub

' Call the backend function
backend()
%>

<!-- HTML Form -->
<form action="asp.asp" method="POST" name="guessForm">
    <h2>Hi <%= name %></h2>
    <p>Enter the number that you want to guess:</p>
    <input type="text" name="guessNumber" value="" size="20" autofocus />
    <input type="submit" value="Submit" />
</form>
</body>
</html>

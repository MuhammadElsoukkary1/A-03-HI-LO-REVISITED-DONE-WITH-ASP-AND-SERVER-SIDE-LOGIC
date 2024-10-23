<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>After Guess</title>
</head>
<body>
<%
Sub processGuess()
    ' Declare all variables properly
    Dim randomNumber, maxNumber, min, name, guessNumber

    ' Retrieve cookies
    randomNumber = CInt(Request.Cookies("randomNumber"))
    min = CInt(Request.Cookies("min"))
    maxNumber = CInt(Request.Cookies("max"))
    name = Request.Cookies("name")

    If maxNumber <= 1 Then
        Response.Write("Invalid input!")
    Else
        Response.Write("Hi " & name & ", ready to guess the random number!<br>")

        ' Handle guesses
        If Request.Form("guessNumber") <> "" Then
            guessNumber = CInt(Request.Form("guessNumber"))

            ' Validate the guess
            If guessNumber < min Or guessNumber > maxNumber Then
                Response.Write("<h2>Error: Your guess is out of range!</h2>")
            ElseIf guessNumber < randomNumber Then
                Response.Write("<h2>Your guess of " & guessNumber & " is too low!</h2>")
                min = guessNumber ' Update minimum range
            ElseIf guessNumber > randomNumber Then
                Response.Write("<h2>Your guess of " & guessNumber & " is too high!</h2>")
                maxNumber = guessNumber ' Update maximum range
            Else
                Response.Write("<h2>Congratulations! You guessed the number: " & randomNumber & "!</h2>")

                ' Clear cookies for a new game
                Response.Cookies("randomNumber").Expires = Date - 1
                Response.Cookies("min").Expires = Date - 1
                Response.Cookies("max").Expires = Date - 1
                

            End If

            ' Update cookies with new range
            Response.Cookies("min") = min
            Response.Cookies("max") = maxNumber

            Response.Write("<p>Your current guessing range is: " & min & " to " & maxNumber & "</p>")
        End If
    End If
End Sub

' Call the function to process the guess
processGuess()
%>


we have to find some way to post the name the way we could do it is through an asp page right 
so what we need to do is create an asp page that will get the max number and will also get the name using asp 
no duh right which we can then use the hi code u created before to display in html we will need to make sure that this page
is only used when the user clicks play again not all the time beacuse it is a big pain in the ass to try and create if statments that would 


<!-- HTML Form -->
<form action="processGuess.asp" method="POST" name="guessForm">
    <p>Enter the number that you want to guess:</p>
    <input type="text" name="guessNumber" value="" size="20" autofocus />
    <input type="submit" value="Submit" />
<form action="hiloStart.html" method="POST" name="playAgain">
    <input type="text" name="guessNumber" value="" size="20" autofocus />
    <input type="submit" value="Submit" />
</form>
</body>
</html>

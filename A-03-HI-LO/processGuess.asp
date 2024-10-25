<%
'==============================================================================
' FILE: processGuess.asp
' DESCRIPTION: 
'   This ASP page handles the logic for a number guessing game. 
'   It retrieves session variables and validates user guesses. 
'   If the user wins, it redirects them to the play-again page.
'   AUTHOR    : Muhammad Elsoukkary
'   STUDENT # : 8826383
'   AUTHOR    : Quang Minh Vu
'   STUDENT # : 8905836
'   DATE      : 2024-10-18
'==============================================================================
' Ensure that session state is enabled
Session.LCID = 1033 ' Optional: set the locale
Session.Timeout = 20 ' Optional: session timeout in minutes


' FUNCTION      : processGuess
' DESCRIPTION   : 
'   This function manages the backend logic for the number guessing game.
'   It checks for session variables to greet the user, processes guesses,
'   and handles the start of a new game based on the user's input.
' PARAMETERS    : 
'   None
' RETURNS       : 
'   N/A : nothing
Sub processGuess()
' Declare all variables properly
Dim randomNumber, maxNumber, min, name, guessNumber

' Retrieve session variables
randomNumber = CInt(Session("randomNumber"))
min = CInt(Session("min"))
maxNumber = CInt(Session("max"))
name = Session("name")

If (maxNumber <= 1) Then
    Response.Write("Invalid input!")
Else
    Response.Write("Hi " & name & ", ready to guess the random number!<br>")

    ' Handle guesses
    If (Request.Form("guessNumber") <> "") Then
        guessNumber = CInt(Request.Form("guessNumber"))

        ' Validate the guess
        If (guessNumber < min Or guessNumber > maxNumber) Then
            Response.Write("<h2>Error: Your guess is out of range!</h2>")
        ElseIf guessNumber < randomNumber Then
            Response.Write("<h2>Your guess of " & guessNumber & " is too low!</h2>")
            min = guessNumber ' Update minimum range
        ElseIf guessNumber > randomNumber Then
            Response.Write("<h2>Your guess of " & guessNumber & " is too high!</h2>")
            maxNumber = guessNumber ' Update maximum range
        Else
            Response.Write("<h2>Congratulations! You guessed the number: " & randomNumber & "!</h2>")

            ' Clear session variables for a new game
            Session("randomNumber") = Null
            Session("min") = Null
            Session("max") = Null
            Response.Redirect "playAgainPage.html" 
        End If

        ' Update session with new range
        Session("min") = min
        Session("max") = maxNumber

        Response.Write("<p>Your current guessing range is: " & min & " to " & maxNumber & "</p>")
    End If
End If
End Sub

processGuess()
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Style\asp.css"> <!-- Link CSS correctly -->
    <title>After Guess</title>
</head>
<body>

<script language="javascript">
    //
    // FUNCTION      : numberChecker
    // DESCRIPTION   :
    //   Validates the user’s input from the guess number form. It ensures that 
    //   the input is a non-empty, integer number greater than 1.
    // PARAMETERS    : None
    // RETURNS       : Boolean - true if valid, false otherwise
    //
    function numberChecker() {
        const numberStr = document.getElementById("guessNumber").value.trim();
        let isGood = false;
        const number = Number(numberStr);

        if (numberStr.length === 0) {
            clearInputs();
            document.getElementById("numberMsg").innerHTML = 
                "<p>Error: Please enter a number; you entered nothing.</p>";
            document.getElementById("numberMsg").style.color = "red";
        } else if (isNaN(number)) {
            clearInputs();
            document.getElementById("numberMsg").innerHTML = 
                "<p>Error: You entered something that is not a number; please enter a number greater than 1.</p>";
            document.getElementById("numberMsg").style.color = "red";
        } else if (!Number.isInteger(number)) {
            clearInputs();
            document.getElementById("numberMsg").innerHTML = 
                "<p>Error: You entered something that is not an integer; please enter a number greater than 1.</p>";
            document.getElementById("numberMsg").style.color = "red";
        } else {
            document.getElementById("numberMsg").innerHTML = ""; // Clear previous error
            isGood = true;
        }

        return isGood;
    }

    //
    // FUNCTION      : clearInputs
    // DESCRIPTION   :
    //   Clears the content of the input container.
    // PARAMETERS    : None
    // RETURNS       : None
    //
    function clearInputs() {
        const container = document.getElementById("inputContainer");
        container.innerHTML = "";  
    }
</script>

 <div class="container">
<form action="processGuess.asp" method="POST" name="guessForm" onsubmit="return numberChecker()">
    <p>Enter the number that you want to guess:</p>
    <input type="text" name="guessNumber" value="" size="20" id="guessNumber" autofocus />
    <input type="submit" value="Submit" />
    <h2 id="numberMsg"></h2>
    <h2 id="nameError" style="color: red;"></h2>
    <div id="inputContainer"></div>
</form>
 </div>

</body>
</html>

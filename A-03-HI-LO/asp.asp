<%
' Ensure that session state is enabled at the top of your ASP page
Session.LCID = 1033 ' Optional: set the locale
Session.Timeout = 20 ' Optional: session timeout in minutes

' Function to handle the backend logic
Sub backend()
    Dim name, maxNumber, randomNumber, guessNumber, min

    ' Check if session variables exist
    If (Not IsEmpty(Session("name"))) Then
        name = Session("name")
        Response.Write("Hi " & name & ", ready to guess the random number!<br>")
    End If

    ' Handle new game or guessing based on POST request
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
        ' Validate and prevent overwriting the session with blank data
        If Trim(Request.Form("name")) <> "" Then
            name = Request.Form("name")
            Session("name") = name
        End If

        If Request.Form("guessNumber") <> "" Then
            ' Handle the guess
            randomNumber = CInt(Session("randomNumber"))
            min = CInt(Session("min"))
            max = CInt(Session("max"))
            guessNumber = CInt(Request.Form("guessNumber"))

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
                ' Clear session variables for a new game
                Session("randomNumber") = Null
                Session("min") = Null
                Session("max") = Null
                Response.Redirect "playAgainageP.html"
            End If

            ' Update session variables with new min/max range
            Session("min") = min
            Session("max") = max
            Response.Write("<p>Your current guessing range is: " & min & " to " & max & "</p>")
        Else
            ' Process starting a new game
            If Trim(name) = "" Then
                name = Request.Form("name")
            End If

            maxNumber = CInt(Request.Form("numberInput")) ' Ensure valid conversion

            If (maxNumber <= 1) Then
                Response.Write("<h2>Invalid input!</h2>")
            Else
                ' Set up the game with new values
                min = 1
                Randomize
                randomNumber = Int((maxNumber - min + 1) * Rnd + min)

                ' Store values in session
                Session("randomNumber") = randomNumber
                Session("min") = min
                Session("max") = maxNumber

                Response.Write("Hi " & name & ", ready to guess the random number!<br>")
            End If
        End If
    End If
End Sub

' Call the backend function
backend()
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Number Guessing Game</title>
</head>
<body onload="pageLoad()">
<script language="javascript">
    function pageLoad() {
        document.getElementById("playAgain").style.visibility = "hidden";
    }

    function numberChecker() {
        const numberStr = document.getElementById("guessNumber").value.trim();
        const numberMsg = document.getElementById("numberMsg");
        let isGood = false;
        const number = Number(numberStr);

        if (numberStr.length === 0) {
            clearInputs();
            numberMsg.innerHTML = "<p>Error: Please enter a number you entered nothing</p>";
            numberMsg.style.color = "red";
        } else if (isNaN(number)) {
            clearInputs();
            numberMsg.innerHTML = "<p>Error: You entered something that is not a number, please enter a number greater than 1</p>";
            numberMsg.style.color = "red";
        } else if (!Number.isInteger(number)) {
            clearInputs();
            numberMsg.innerHTML = "<p>Error: You entered something that is not an integer, please enter a whole number</p>";
            numberMsg.style.color = "red";
        } else {
            numberMsg.innerHTML = ""; // Clear previous error
            isGood = true;
            return true; // Allow the form to be submitted
        }

        return false; // Prevent the form submission
    }

    function clearInputs() {
        const container = document.getElementById("inputContainer");
        container.innerHTML = "";  // Clear the container for new inputs
    }
</script>

<form action="processGuess.asp" method="POST" name="guessForm" onsubmit="return numberChecker()">
    <p>Enter the number that you want to guess:</p>
    <input type="text" name="guessNumber" value="" size="20" id="guessNumber" autofocus />
    <input type="submit" value="Submit" />
</form>

<form action="hiloStart.html" method="POST" name="playAgain">
    <input type="submit" value="Play Again" id="playAgain" />
</form>

<h2 id="numberMsg"></h2>
<h2 id="nameError" style="color: red;"></h2>
<div id="inputContainer"></div>
</body>
</html>
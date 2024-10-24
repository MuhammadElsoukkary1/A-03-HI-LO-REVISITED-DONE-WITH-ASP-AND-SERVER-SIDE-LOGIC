<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>After Guess</title>
</head>
<body onload="pageLoad()">

<script language="javascript">

    function numberChecker()
    {
        
        const numberStr = document.getElementById("guessNumber").value.trim(); 
        var isGood = false;
        const number = Number(numberStr);
        
        if (number.length === 0 ) 
        {
            clearInputs();
            numberMsg.innerHTML = "<p>Error: Please enter a number you entered nothing</p>";
            numberMsg.style.color = "red";
            
        }
           
        else if (isNaN(number))
        {
            clearInputs();
            numberMsg.innerHTML = "<p>Error: You entered something that is not a number please enter a number greater than 1</p>";
            numberMsg.style.color = "red";
        
        }
        else if (!Number.isInteger(number))
        {
         clearInputs();
          numberMsg.innerHTML = "<p>Error: You entered something that is not a int please enter a number greater than 1</p>";
         numberMsg.style.color = "red";
        }
        else
         {
            numberMsg.innerHTML = "";
            isGood = true;
        }

        return isGood;

    }
    function clearInputs() 
    {
        const container = document.getElementById("inputContainer");
        container.innerHTML = "";  
    }
</script>
<%
Sub processGuess()
    ' Declare all variables properly
    Dim randomNumber, maxNumber, min, name, guessNumber

    ' Retrieve cookies
    randomNumber = CInt(Request.Cookies("randomNumber"))
    min = CInt(Request.Cookies("min"))
    maxNumber = CInt(Request.Cookies("max"))
    name = Request.Cookies("name")

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

                ' Clear cookies for a new game
                Response.Cookies("randomNumber").Expires = Date - 1
                Response.Cookies("min").Expires = Date - 1
                Response.Cookies("max").Expires = Date - 1
                
                Response.Redirect "playAgainPage.html" 
                

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
<form action="processGuess.asp" method="POST" name="guessForm"onsubmit="return numberChecker()">
    <p>Enter the number that you want to guess:</p>
    <input type="text" name="guessNumber" value="" size="20" id="guessNumber" autofocus />
    <input type="submit" value="Submit" onclick="numberChecker()" />
    <h2 id="numberMsg"></h2>
    <h2 id="nameError" style="color: red;"></h2>
    <div id="inputContainer"></div>
</body>
</html>

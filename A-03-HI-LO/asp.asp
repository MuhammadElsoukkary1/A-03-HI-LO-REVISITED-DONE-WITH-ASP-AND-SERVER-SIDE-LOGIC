<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body onload="pageLoad()">
<script language="javascript">
    function pageLoad() {
            document.getElementById("playAgain").style.visibility = "hidden";
        }
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
            numberMsg.innerHTML = ""; // Clear previous error
            isGood = true;
            sucesss();
        }
    }
    function clearInputs() 
    {
        const container = document.getElementById("inputContainer");
        container.innerHTML = "";  // Clear the container for new inputs
    }
</script>
<%
Sub backend()
dim name
    If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
        
        name = Request.Form("name")
        Dim maxNumber, randomNumber, guessNumber
        maxNumber = CInt(Request.Form("numberInput")) ' Ensure valid conversion
    Else Request.Cookies("name") <> ""
     name = Request.Cookies("name")
    maxNumber = CInt(Request.Form("numberInput")) ' Ensure valid conversion
    End If
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
                 Response.Cookies("randomNumber").Expires = Date - 1
                Response.Cookies("min").Expires = Date - 1
                Response.Cookies("max").Expires = Date - 1
                Response.Redirect "playAgainPage.html" 
            End If

            ' Update cookies with new min/max range
            Response.Cookies("min") = min
            Response.Cookies("max") = max
            Response.Write("<p>Your current guessing range is: " & min & " to " & max & "</p>")
        End If
    Exit Sub ' Ensure Sub ends properly
End Sub

' Call the backend function
backend()
%>



<form action="processGuess.asp" method="POST" name="guessForm"onsubmit="return numberChecker()">
    <p>Enter the number that you want to guess:</p>
    <input type="text" name="guessNumber" value="" size="20" id="guessNumber" autofocus />
    <input type="submit" value="Submit" onclick="numberChecker()" />
<form action="hiloStart.html" method="POST" name="playAgain">
    <input type="submit" value="Play Again" id="playAgain"/>
</form>

    <h2 id="numberMsg"></h2>
    <h2 id="nameError" style="color: red;"></h2>
    <div id="inputContainer"></div>
</body>
</html>
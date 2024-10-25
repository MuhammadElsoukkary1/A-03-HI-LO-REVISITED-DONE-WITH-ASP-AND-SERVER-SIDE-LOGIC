<%
' ==========================================
'   File Name: playAgain.asp
'   Description: 
'   This ASP page checks if the user's name is stored in the session. 
'   If the name is present, it allows the user to proceed. 
'   Otherwise, it redirects the user to the name input page.
'   AUTHOR    : Muhammad Elsoukkary
'   STUDENT # : 8826383
'   AUTHOR    : Quang Minh Vu
'   STUDENT # : 8905836
'   DATE      : 2024-10-18
' ==========================================

' Ensure that session state is enabled at the top of your ASP page
Session.LCID = 1033 ' Optional: set the locale
Session.Timeout = 20 ' Optional: session timeout in minutes

Dim name

' Check if the name is stored in the session
If Not IsEmpty(Session("name")) Then
     ' Output JavaScript to set the inner HTML of the h2 element
    name = Session("name")
     Response.Write "<script>"
    Response.Write "document.addEventListener('DOMContentLoaded', function() {"
    Response.Write "document.getElementById('numberMsg').innerHTML = 'Hi " & name & ", ready to guess the random number!';"
    Response.Write "});"
    Response.Write "</script>"

Else
    Response.Write("No name provided. Please enter your name.")
    Response.Redirect "hiloStart.html" 
    Response.End ' Ensure no further processing happens after redirect
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Play Again</title>
    <link rel="stylesheet" type="text/css" href="Style\playAgain.css"> <!-- Link to your CSS file -->
</head>
<body onload="userPromptForNumber()" id="body">
    <div class="container"> <!-- Box/container for the content -->
        <script>
            function userPromptForNumber() {
                document.getElementById("body").style.backgroundColor = "lightgrey";
                clearInputs();
                document.getElementById("submit").style.visibility = "visible";
                document.getElementById("numberInput").style.visibility = "visible";
                document.getElementById("submit").value = "Generate random number";
            }

            function numberChecker() {
                const numberStr = document.getElementById("numberInput").value.trim();
                const numberMsg = document.getElementById("numberMsg");
                let isGood = false;
                const number = Number(numberStr);

                if (numberStr.length === 0) {
                    clearInputs();
                    numberMsg.innerHTML = "<p>Error: Please enter a number; you entered nothing.</p>";
                    numberMsg.style.color = "red";
                } else if (isNaN(number)) {
                    clearInputs();
                    numberMsg.innerHTML = "<p>Error: You entered something that is not a number; please enter a valid number.</p>";
                    numberMsg.style.color = "red";
                } else if (!Number.isInteger(number)) {
                    clearInputs();
                    numberMsg.innerHTML = "<p>Error: Please enter a whole number.</p>";
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
                container.innerHTML = ""; // Clear the container for new inputs
            }
        </script>

        <!-- Form to get the number input -->
        <form action="asp.asp" method="POST" onsubmit="return numberChecker()" id="form">
            <input type="text" id="numberInput" name="numberInput" placeholder="Enter a number">
            <input type="submit" id="submit" value="Submit" style="visibility: hidden;">
        </form>

        <h2 id="numberMsg"></h2>
        <div id="inputContainer"></div>
    </div> <!-- End of container -->
</body>
</html>

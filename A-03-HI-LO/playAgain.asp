<%
' Ensure that session state is enabled at the top of your ASP page
Session.LCID = 1033 ' Optional: set the locale
Session.Timeout = 20 ' Optional: session timeout in minutes

Dim name

' Check if the name is stored in the session
If Not IsEmpty(Session("name")) Then
    name = Session("name")
    Response.Write("Hi " & name & ", ready to guess the random number!<br>")
Else
    Response.Write("No name provided. Please enter your name.")
    Response.Redirect "hiloStart.html" 
End If
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>hiloStart</title>
</head>
<body onload="userPromptForNumber()" id="body">
    <script>
    function userPromptForNumber() {
        // Change the background color to show a new page
        document.getElementById("body").style.backgroundColor = "blue";
        
        // Clear previous inputs
        clearInputs();
        document.getElementById("submit").style.visibility = "visible";
        document.getElementById("numberInput").style.visibility = "visible";
        document.getElementById("submit").value = "Generate random number";
    }

    function numberChecker() 
    {
        const numberStr = document.getElementById("numberInput").value.trim();
        const numberMsg = document.getElementById("numberMsg");
        let isGood = false;
        const number = Number(numberStr);

        if (numberStr.length === 0) {
            clearInputs();
            numberMsg.innerHTML = "<p>Error: Please enter a number you entered nothing</p>";
            numberMsg.style.color = "red";
        } else if (isNaN(numberStr)) {
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

    <!-- Form that gets the number input -->
    <form action="asp.asp" method="POST" onsubmit="return numberChecker()" id="form">
        <input type="text" id="numberInput" name="numberInput" placeholder="Enter a number greater than 1">
        <!-- Button to submit the number -->
        <input type="submit" id="submit" value="Submit">
    </form>

    <h2 id="numberMsg"></h2>
    <div id="inputContainer"></div>
</body>
</html>

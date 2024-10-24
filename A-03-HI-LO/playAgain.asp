<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>hiloStart</title>
</head>
<body onload="userPromptForNumber()" id="body">
    <script>
    function userPromptForNumber()
         {
            //change the background colour just to show that you are in a new page
            document.getElementById("body").style.backgroundColor = "blue";
            //hide the old prompts 
            //ask the user by name to enter a number over 1 
            // Clear previous inputs
            clearInputs();
            document.getElementById("submit").style.visibility = "visible";
            document.getElementById("numberInput").style.visibility = "visible";
            document.getElementById("submit").value = "Generate random number";
            //Create a texbox
            
        }
    function numberChecker()
    {
        const numberMsg = document.getElementById("numberMsg");
        const number = document.getElementById("numberInput").value.trim();
        var isGood = false;
        
        if (number.length === 0 ) 
        {
            numberMsg.innerHTML = "<p>Error: Please enter a number you entered nothing</p>";
            numberMsg.style.color = "red";
        }
            // check if the user entered something that is not a number if yes give them an error
        else if (isNaN(number))
        {
            numberMsg.innerHTML = "<p>Error: You entered something that is not a number please enter a number greater than 1</p>";
            numberMsg.style.color = "red";
        
        }
        else
         {
            numberMsg.innerHTML = ""; // Clear previous error
            isGood = true;
        }

        return isGood;

    }

    function clearInputs() 
    {
        const container = document.getElementById("inputContainer");
        container.innerHTML = "";  // Clear the container for new inputs
    }
    </script>
     <%
      If (Request.Cookies("name") <> "") Then
     name = Request.Cookies("name")
     Response.Write("Hi " & name & ", ready to guess the random number!<br>")
    Else
    Response.Write("No name man ")
End If
%>
    <!--form that gets the name-->
    <form action="asp.asp" method="POST" onsubmit="return numberChecker()" id="form">
        <input type="text" id="numberInput" name="numberInput">
         <!--button to submit the name-->
        <input type="submit" id="submit" value="Submit"></button>
    </form>

    
    <h2 id="numberMsg"></h2>
    
    <div id="inputContainer"></div>
</body>
</html>
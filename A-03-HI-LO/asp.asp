<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<script language="javascript">

</script>
<%

If (Request.ServerVariables("REQUEST_METHOD") = "POST") Then
    name = Request.Form("name")
    Dim maxNumber
    Dim randomNumber
    Dim guessNumber
    maxNumber = Request.Form("numberInput")
    If (maxNumber <= 1) Then 
    Response.Write("fuck u")
    else
    Response.Write("Hi " & name&" ready to guess a the random number!!!")
    Response.Write("You entered: " & maxNumber)
    end if 
    

    Dim min
    min=1
    randomNumber=Int((maxNumber - min + 1)*Rnd+min)
    Randomize
    Response.Cookies("randomNumber") = randomNumber
    Response.Cookies("min") = 1
    Response.Cookies("max") = maxNumber
    Response.Cookies("name") = name
    Response.Write("random num is " &randomNumber )
    

    if(Request.Form("guessNumber") <> "")  Then
    randomNumber = CInt(Request.Cookies("randomNumber"))
    min = CInt(Request.Cookies("min"))
    max = CInt(Request.Cookies("max"))
    name = Request.Cookies("name")

    guessNumber = CInt(guessNumber)

    If guessNumber < min Or guessNumber > max Then
        Response.Write("<h2>Error: Your guess is out of range!</h2>")
    ElseIf guessNumber < randomNumber Then
        Response.Write("<h2>Your guess of " & guess & " is too low!</h2>")
        min = guessNumber ' Update the minimum range
    ElseIf guessNumber > randomNumber Then
        Response.Write("<h2>Your guess of " & guess & " is too high!</h2>")
        max = guessNumber ' Update the maximum range
    Else
            Response.Write("<h2>Congratulations! You guessed the number: " & randomNumber & "!</h2>")
            Response.Cookies("randomNumber") = "" ' Clear cookies for a new game
            Response.Cookies("min") = ""
            Response.Cookies("max") = ""
            Response.Cookies("name") = ""
            Exit Sub
    End If
    Response.Cookies("min") = min
    Response.Cookies("max") = max
    Response.Write("<p>Your current guessing range is: " & min & " to " & max & "</p>")

  
    <form action="asp.asp" method="post" name="guessForm">
      <h2>Hi <%= name %>, ready to guess the random number!</h2>
      <p>Enter the number that you want to guess</p>
		  <input type="text" name="guessNumber" value="" size="20" autofocus />
	    <input type="button" value="Submit" />
    </form>
End If
%>

</body>
</html>

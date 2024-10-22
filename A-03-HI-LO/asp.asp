<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

<%

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    name = Request.Form("name")
    Dim maxNumber
    Dim randomNumber
    Dim guessNumber
    maxNumber = Request.Form("numberInput")
    Response.Write("You entered: " & name)
    Response.Write("You entered: " & maxNumber)
    

    Dim min
    min=1
    Randomize
    Response.Write(Int((maxNumber - min + 1)*Rnd+min))

End If
%>

</body>
</html>

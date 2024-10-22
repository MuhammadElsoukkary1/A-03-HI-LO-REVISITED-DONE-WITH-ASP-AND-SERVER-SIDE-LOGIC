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
    Dim maxNumber
    Dim randomNumber
    Dim guessNumber

    'If Request.Form <> "" Then
      'if(UCase(str) = "numberInput") then numberInputt = CInt(Request.Form(str).Item)
      numberInputt = Request.Form("numberInput")
        Response.Write(numberInputt)
    'End If

    Dim min
    min = 1
    Randomize
    Response.Write(Int((maxNumber - min + 1) * Rnd + min))

End If
%>

</body>
</html>

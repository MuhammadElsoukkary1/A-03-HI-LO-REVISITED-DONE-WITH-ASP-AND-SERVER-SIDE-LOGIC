<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%
if Request.SeverVariables("REQUEST_METHOD") = "POST" then
dim maxNumber
dim randomNumber
dim guessNumber

Response.Write maxNumber

if Request.Form("maxNumber") <> "" then
maxNumber=Request
%>
</body>
</html>
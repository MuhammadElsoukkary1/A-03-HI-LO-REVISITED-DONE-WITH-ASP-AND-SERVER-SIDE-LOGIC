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

Dim max,min
max=100
min=1
Randomize
response.write(Int((max-min+1)*Rnd+min))

Response.Write maxNumber

if Request.Form("maxNumber") <> "" then
maxNumber=Request.Form("numberInput")
Response.Cookies("maxNumber")=maxNumber
Response.Cookies("maxNumber").Expires=60%

end if
 <script type="text/javascript">
function random(maxiumNumber){
        randomNumber= ((new Date().getTime())% maxiumNumber)+1;
        return randomNumber;
      }
 </script>
%>
</body>
</html>
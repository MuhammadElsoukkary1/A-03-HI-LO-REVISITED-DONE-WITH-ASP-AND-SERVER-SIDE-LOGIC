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

    Dim max, min
    max = 100
    min = 1
    Randomize
    Response.Write(Int((max - min + 1) * Rnd + min))

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
    If Request.Form("maxNumber") <> "" Then
        maxNumber = Request.Form("maxNumber")
        Response.Write maxNumber
    End If
End If
%>

</body>
</html>

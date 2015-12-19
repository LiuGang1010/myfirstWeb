
<html>
<head>
    <title>成功页面</title>
</head>
<body>
<#if user??>
    欢迎:${user.username}
<#else>
    没有该用户
</#if>
</body>
</html>
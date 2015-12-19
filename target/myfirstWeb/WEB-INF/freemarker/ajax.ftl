<html>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<head>
    <title>测试Ajax</title>
    <script type="text/javascript" src="/js/jquery-1.8.2.min.js"></script>
    <script type="text/javascript" src="/js/verify.js"></script>
</head>
<body>
    <#--
        使用Ajax异步提交方式实现用户名校验
    -->
    <input type="text" id="username"/>
    <input type="button" value="校验" onclick="verify()"/>

    <div id="result"></div>

</body>
</html>
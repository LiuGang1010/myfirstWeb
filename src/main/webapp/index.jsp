<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
</head>

<body>
    <a href="/testdelete?id=4">删除用户</a><br>
    <a href="/testfind?id=2">返回指定用户</a><br>
    <a href="/testfindall">返回所有用户</a><br><br>

    <form action="/testadd" method="post">
        <div>
            用户名:<input type="text" name="username"/><br>
            年龄:<input type="text" name="age"/><br>
            email:<input type="text" name="email"/><br>
            生日:<input type="text" name="birthday"><br>
            <input type="submit" value="提交"/>
        </div>
    </form>

    <br><br>

    <form action="/testupdate" method="post">
        <div>
            用户名:<input type="text" name="username"/><br>
            年龄:<input type="text" name="age"/><br>
            email:<input type="text" name="email"/><br>
            生日:<input type="text" name="birthday"><br>
            <input type="submit" value="提交"/>
        </div>
    </form>
</body>
</html>

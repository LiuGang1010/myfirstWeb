//定义用户名校验方法
function verify1() {
    //alert("ok");
//    1.获取文本框中内容
//    jquery查找节点的方式是：$("#id")返回一个jquery节点对象，可以在上面继续执行其他的jquery方法
    var jqueryobj = $("#username");
    var username = jqueryobj.val();
    //alert(username);
//    2.将文本框中得数据发送给服务端的controller
//    使用jquery的XMLHTTPRequest对象get请求的封装
    $.get("myserver?username=" + username, null, callback);

}

//定义回调函数
function callback(data) {

    //alert("服务端数据返回");
//    3.接受服务器端返回的数据
//        alert(data);
//    4.将服务端返回的数据动态的显示在页面上
//    找到保存结果信息的节点,并动态的改变页面div节点中的内容
    $("#result").html(data);
}

//精简写法
function verify() {
    $.get("myserver?username=" + $("#username").val(), null, function (data) {
        $("#result").html(data);
    });
}
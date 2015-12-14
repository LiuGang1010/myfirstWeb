var xmlHttpReq;
function sendRequest(){
    xmlHttpReq=init();
    var catalogId=encodeURIComponent(document.getElementById("catalogId").value);
    xmlHttpReq.open("GET","validateForm?catalogId=" + catalogId,true);
    xmlHttpReq.onreadystatechange=processRequest;
    xmlHttpReq.send(null);
}
function init() {
    if (window.XMLHttpRequest) {
        return new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
        return new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function processRequest(){
    if(xmlHttpReq.readyState==4){
        if(xmlHttpReq.status==200){
            var msg=xmlHttpReq.responseText;
            document.getElementById("validationMessage").innerHTML=msg;
        }
    }
}
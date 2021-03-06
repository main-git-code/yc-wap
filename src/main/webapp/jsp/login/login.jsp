<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2016/11/8
  Time: 下午4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String path = request.getContextPath();
    String ToUrl = (String) session.getAttribute("ToUrl");

    System.out.println("LoginToUrl: " + ToUrl);
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title><spring:message code="login.login.title"/></title>
    <script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/global.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/frame.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/eject.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/spin.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/modular/loading.js"></script>
    <link href="<%=path%>/ui/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/ui/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/modular.css" rel="stylesheet" type="text/css"/>
    <link href="<%=path%>/ui/css/modular/frame.css" rel="stylesheet" type="text/css"/>
    <%@ include file="../common/timezone.jsp" %>
</head>
<body>
    <c:if test="${to == 'login'}">
        <div class="loading-bj" id="_loading" style="opacity: 0">
    </c:if>
    <c:if test="${to != 'login'}">
        <div class="loading-bj" id="_loading" style="opacity: 1">
    </c:if>

    <section class="loading-wrapper">
        <p class="img1"><img src="<%=path%>/ui/images/loading-logo.png"/></p>
        <p class="img2">
        <div id="foo" style="margin-top:1rem;"></div>
        <p class="img3"><spring:message code="loading.loadingtitle"/></p>
    </section>
</div>

<div class="wrapper-big">
    <%--登录界面--%>
    <c:if test="${to == 'login'}">
        <div id="loginDiv"><!--包含除底部外的所有层-->
    </c:if>

    <c:if test="${to != 'login'}">
        <div id="loginDiv" hidden><!--包含除底部外的所有层-->
    </c:if>
        <!--登录-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:void(0)" onclick="leftBtn()"><i class="icon iconfont left">&#xe626;</i></a>
                <li><spring:message code="login.login.title"/></li>
                <a href="javascript:void(0)" class="btn login-btn right1" onclick="registJump()"><spring:message code="login.login.zhuce"/></a>
            </ul>
        </nav>


        <!--tab-->
        <section class="login-tab">
         <ul>
             <li><a href="javascript:void(0)" class="current"><spring:message code="login.login.fastLogin"/></a></li>
             <li><a href="javascript:void(0)"><spring:message code="login.login.norLogin"/></a></li>
         </ul>
        </section>
        <!--tab1-->
        <section id="tab1">
            <section class="login-prompt"><spring:message code="login.login.fastTip"/></section>
            <section class="form-big">
                <div class="set-password">
                    <div class="set-int">
                        <ul>
                            <li>
                                <p>
                                    <select class="select testing-select-big" id="selectid1">
                                    </select>
                                    <span>|</span>
                                </p>
                                <label id="selectLabel1"></label>
                            </li>
                            <li>
                                <p><input id="fastphoneid" type="text" class="input input-large" placeholder="<spring:message code="login.login.phone"/>"></p>
                                <label id="fastphoneidLabel"></label>
                            </li>
                            <li>
                                <p><input id="fastcodeid" type="text" class="input input-small" placeholder="<spring:message code="login.register.entercode"/>"></p>
                                <p class="yzm"><a id="fastgetnumber" href="javascript:void(0)" onclick="fastGetCode()" class="btn bnt-yzm"><spring:message code="login.register.getcode"/></a></p>
                                <label id="fastCodetips"></label>
                            </li>
                            <li class="small-height" id="loginBtn1"><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="fastlogin()"><spring:message code="login.login.lijidenglu"/></a></li>
                            <img src="<%=path%>/ui/images/载入中.gif" id="translateGif1" style="width: 5.29rem;height: 1.13rem; display:block;margin:0 auto">
                            <li class="right"><a href="javascript:void(0)" onclick="forgetpsd()"><spring:message code="login.login.wangjimima"/> </a></li>
                        </ul>
                    </div>
                </div>
            </section>
        </section>
        <%--普通登录--%>
        <section id="tab2" style="display:none;">
            <section class="form-big">
                <div class="set-password">
                    <div class="set-int">
                        <ul>
                            <li>
                                <p><input id="phoneid" type="text" class="input input-large" placeholder="<spring:message code="login.login.phonepliceholder"/>"></p>
                                <label id="phoneLabel"></label>
                            </li>
                            <li>
                                <p><input id="psdid" type="password" class="input input-large" placeholder="<spring:message code="login.login.mima"/>" autocomplete="off">
                                </p>
                                <label id="psdLabel"></label>
                            </li>
                            <li class="int-border" id="checkCodeIsHiden" hidden>
                                <p><input id="codeInput" type="text" class="input input-yzm" placeholder="<spring:message code="login.login.yanzhengma"/>" autocomplete="off"></p>
                                <img id="checkCodeId" src="<%=path%>/safe/getpiccode" onclick="createCode()"/>
                                <p class="right"><a href="javascript:void(0)" onclick="createCode()"><i class="icon iconfont">&#xe66c;</i></a></p>
                                <label id="codeLabel"></label>
                            </li>
                            <li class="small-height" id="loginBtn"><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="login()"><spring:message code="login.login.lijidenglu"/></a></li>
                            <img src="<%=path%>/ui/images/载入中.gif" id="translateGif" style="width: 5.29rem;height: 1.13rem; display:block;margin:0 auto">
                            <li class="right">
                                <a href="javascript:void(0)" onclick="forgetpsd()">
                                    <spring:message code="login.login.wangjimima"/>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>
        </section>
        <!--其他登录-->
        <section class="other-big">
            <div class="other-login">
                <p class="line"></p>
                <p class="word"><spring:message code="login.login.otherLogin"/></p>
                <p class="line"></p>
            </div>
            <div class="other-login-icon">
                <ul>
                    <li class="none-ml"><a href="javascript:window.location.href = '<%=path%>/login/kingchecklogin'"><img src="<%=path%>/ui/images/iocn-4.png" /></a></li>
                    <li><a href="javascript:window.location.href = '<%=path%>/login/baiduchecklogin'"><img src="<%=path%>/ui/images/iocn-5.png" /></a></li>
                    <li><a href="javascript:window.location.href = '<%=path%>/login/qqchecklogin'"><img src="<%=path%>/ui/images/iocn-6.png" /></a></li>
                    <li><a href="javascript:window.location.href = '<%=path%>/login/weibochecklogin'"><img src="<%=path%>/ui/images/iocn-7.png" /></a></li>
                    <li><a href="javascript:void(0)"><img src="<%=path%>/ui/images/iocn-8.png" /></a></li>
                </ul>
            </div>
        </section>
    </div>

    <%--注册界面--%>
        <c:if test="${to == 'register'}">
            <div id="registerDiv"><!--包含除底部外的所有层-->
        </c:if>
        <c:if test="${to != 'register'}">
            <div id="registerDiv" hidden> <!--包含除底部外的所有层-->
        </c:if>
        <!--注册-->
        <nav class="wap-second-nav">
            <ul>
                <a href="javascript:" onclick="leftA()"><i class="icon iconfont left">&#xe626;</i></a>
                <li><spring:message code="login.login.zhuce"/></li>
                <a href="javascript:void(0)" class="btn login-btn right1" onclick="jumpLogin()"><spring:message code="login.login.title"/></a>
            </ul>
        </nav>

        <section class="form-big">
            <div class="set-password">
                <div class="set-int">
                    <ul>
                        <li>
                            <p>
                                <select class="select testing-select-big" id="selectid">
                                </select>
                                <span>|</span>
                            </p>
                            <label id="selectLabel"></label>
                        </li>
                        <li>
                            <p><input id="phone" type="text" class="input input-large int-color" placeholder="<spring:message code="login.register.enterphone"/>"></p>
                            <label id="phoneLabel1"></label>
                        </li>
                        <li>
                            <p><input id="codeid" type="text" class="input input-small" placeholder="<spring:message code="login.register.entercode"/>" autocomplete="off"></p>
                            <p class="yzm"><a id="getnumber" href="javascript:void(0)" class="btn bnt-yzm" onclick="getnumberonclick()"><spring:message code="login.register.getcode"/></a></p>
                            <label id="codeLabel1"></label>
                        </li>
                        <li>
                            <p><input id="psdids" type="password" class="input input-large" placeholder="<spring:message code="login.login.enterpsd"/>" autocomplete="off">
                            </p>
                            <label id="psdLabel1"></label>
                        </li>
                        <li class="pass-smint">
                            <p ><input id="confimid" type="password" class="input input-large" placeholder="<spring:message code="login.register.enterpsdagain"/>" autocomplete="off"></p>
                            <label id="confimPsd"></label>
                        </li>
                        <li class="left">
                            <p>
                                <img src="<%=path%>/ui/images/checkbox1.png" class="imgcheckbox" onclick="checkImgAction()" id="checkImg">
                            </p>
                            <spring:message code="login.register.agree"/>
                            <a href="javascript:void(0)" onclick="look()"><spring:message code="login.register.look"/></a>
                            <label id="agreeLabel"></label>
                        </li>
                        <li class="small-height"><a href="javascript:void(0)" class="submit-btn btn-blue" onclick="confirmAction()"><spring:message code="login.register.lijizhuce"/></a></li>
                    </ul>
                </div>
            </div>
        </section>
    </div>
</div>
<%--底部視圖--%>
<div id="bottomDiv">
    <jsp:include page="/jsp/common/bottom.jsp" flush="true"/>
</div>

</body>
</html>
<script>
    var isAgree = 1;    //协议那块
    var isHiden = 1;    //验证码隐藏
    var hidenFlag;      //验证码隐藏标识
    var isLoaded = false;   //登录加载
    var blurCheck = 0;  //注册界面手机号失去焦点判断
    var isDoCheck = 0;  //是否调用失去焦点事件
    $(function () {

        $("#translateGif").hide();
        $("#translateGif1").hide();
        $("#phone").attr("disabled", false);
        loadCountry();
        if ("${to}" == "login") {
            Loading.HideLoading();

//            $("#loginDiv").show();
//            $("#registerDiv").hide();
            $("#bottomDiv").hide();
            setTimeout(function(){
                $("#bottomDiv").show();
            },100);
        } else {

//            $("#loginDiv").hide();
//            $("#registerDiv").show();
            $("#bottomDiv").hide();
            setTimeout(function(){
                $("#bottomDiv").show();
            },100);

        }
        showCode();
    });
    var blurTime;
    $(document).ready(function () {
        clearText();


        Loading.SetNoneOpacity();
        $("#phone").blur(function() {

//            clearTimeout(blurTime);
//            blurTime = setTimeout(checkRegisterPhone, 200);
            //校验注册界面手机号的方法
            checkRegisterPhone();
        });
    });

    var Loading = {
        ShowLoading: function () {
            $("#_loading").css("display", "block");
        },
        HideLoading: function () {
            $("#_loading").css("display", "none");
        },
        SetOpacity: function () {
            $("#_loading").css("opacity", 0);
        },
        SetNoneOpacity: function () {
            $("#_loading").css("opacity", 1);
        }
    };

    //——————————————————————登录——————————————————————
    function showCode(){
        hidenFlag = localStorage.getItem("isHiden");
        if (hidenFlag != null && hidenFlag != ""){
            if (hidenFlag >= 3){
                $("#checkCodeIsHiden").show();
                isHiden = 0;
                return;
            }
        }
        isHiden = 1;
        $("#checkCodeIsHiden").hide();
    }
    /*------------------------------------普通登录------------------------------------*/
    function login() {
        var phone = $("#phoneid").val();
        var psd = $("#psdid").val();
        var code = $("#codeInput").val();
        if (phone == "" || phone == null) {
            $("#phoneLabel").html("<spring:message code="login.login.enterphone"/>");
            $("#phoneLabel").css("display", "block");
            return;
        } else {
            $("#phoneLabel").css("display", "none");
        }

        if (psd == "" || psd == null) {
            $("#psdLabel").html("<spring:message code="login.login.enterpsd"/>");
            $("#psdLabel").css("display", "block");
            return;
        } else {
            $("#psdLabel").css("display", "none");
        }
//        var t = /^[0-9a-zA-Z]{6,16}$/;
        <%--var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/--%>
        <%--if (!t.test(psd)) {--%>
            <%--$("#psdLabel").html("<spring:message code="safe.changepsd.alert_newLength"/>");--%>
            <%--$("#psdLabel").css("display", "block");--%>
            <%--return;--%>
        <%--} else {--%>
            <%--$("#psdLabel").css("display", "none");--%>
        <%--}--%>
        if (isHiden == 0){
            if (code == "" || code == null) {
                $("#codeLabel").html("<spring:message code="login.login.entercode"/>");
                $("#codeLabel").css("display", "block");
                return;
            } else {
                $("#codeLabel").css("display", "none");
            }
        }
        $("#translateGif").show();
        $("#loginBtn").hide();
        toJump(phone, psd, code);
    }
    function toJump(phone, psd, code) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/login/checklogin",
            modal: true,
            timeout: 30000,
            data: {
                username: phone,
                password: psd,
                code: code
            },
            success: function (data) {
                $("#translateGif").hide();
                $("#loginBtn").show();
                if (data.status == 1) {
                    localStorage.setItem("isHiden",0);
                    if (${ToUrl==null || ToUrl==""}) {
                        window.location.href = "<%=path%>" + "/";
                    } else {
                        window.location.href = "<%=path%>" + "<%=ToUrl%>";
                    }
                } else {
                    createCode();
                    if (isHiden == 1){
                        $("#psdLabel").html(data.msg);
                        $("#psdLabel").css("display", "block");
                    }else {
                        $("#codeLabel").html(data.msg);
                        $("#codeLabel").css("display", "block");
                    }
                    hidenFlag ++;
                    localStorage.setItem("isHiden",hidenFlag);
                    showCode();
                }

            },
            error: function () {
                $("#translateGif").hide();
                $("#loginBtn").show();
                createCode();
                hidenFlag ++;
                localStorage.setItem("isHiden",hidenFlag);
                if (isHiden == 1){
                    $("#psdLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                    $("#psdLabel").css("display", "block");
                }else {
                    $("#codeLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                    $("#codeLabel").css("display", "block");
                }
                showCode();
            }
        });
    }

    function forgetpsd() {
        clearText();
        var tourl = "<%=path%>/login/findpsd";
        window.location.href = tourl;
    }

    function registJump() {
        $("#loginDiv").hide();
        $("#registerDiv").show();
        $("#bottomDiv").hide();
        setTimeout(function(){
            $("#bottomDiv").show();
        },100);

//        if (!isLoaded) {
//            loadCountry();
//        }
        clearText();
    }
    function leftBtn() {
        if ("${success}" == "success") {
            window.history.go(-3);
        } else {
            window.history.go(-1);
        }

    }
    function clearText() {
        $("#phoneid").val("");
        $("#psdid").val("");
        $("#codeInput").val("");
        $("#phone").val("");
        $("#codeid").val("");
        $("#psdids").val("");
        $("#confimid").val("");
        $("#phoneLabel").css("display", "none");
        $("#phoneLabel1").css("display", "none");
        $("#codeLabel1").css("display", "none");
        $("#psdLabel1").css("display", "none");
        $("#confimPsd").css("display", "none");
        $("#agreeLabel").css("display", "none");
        $("#psdLabel").css("display", "none");
        $("#codeLabel").css("display", "none");
        $("#phone").attr("disabled", false);
        isAgree = 1;
        $("#checkImg").attr("src", "<%=path%>/ui/images/checkbox1.png");
    }
    //验证码代码
    function createCode() {
        var d = new Date();
        $("#checkCodeId").attr("src", "<%=path%>/safe/getpiccode?time=" + d.getTime());
    }

    /*------------------------------------快速登录------------------------------------*/
    function fastGetCode(){
        var fastPhoneVal = $("#fastphoneid").val();
        if (fastPhoneVal == "" || fastPhoneVal == null) {
            $("#fastphoneidLabel").html("<spring:message code="login.register.enterphone"/>");
            $("#fastphoneidLabel").css("display", "block");
            return;
        } else {
            $("#fastphoneidLabel").css("display", "none");
        }
        var selectValue = $('#selectid1').val();
        var code = localStorage.getItem(selectValue + "1");
        var reg = localStorage.getItem(selectValue);
        var t = new RegExp(reg);
        if (!t.test(code + fastPhoneVal)) {
            $("#fastphoneidLabel").html("<spring:message code="login.register.enterRightphone"/>");
            $("#fastphoneidLabel").css("display", "block");
            return;
        } else {
            $("#fastphoneidLabel").css("display", "none");
        }
        getFastCode(fastPhoneVal,selectValue);
    }
    function getFastCode(fastPhoneVal,selectValue){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 1,
                info: fastPhoneVal,
                domain: selectValue,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#fastphoneidLabel").css("display", "none");
                    fastwait = 120;
                    fastCuntDown();
                } else {
                    $("#fastphoneidLabel").html(data.msg);
                    $("#fastphoneidLabel").css("display", "block");
                }
            },
            error: function () {
                $("#fastphoneidLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#fastphoneidLabel").css("display", "block");
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }
    var fastwait = 120;
    function fastCuntDown() {
        if (fastwait == 0) {
            $("#fastgetnumber").removeAttr("disabled");
            $("#fastgetnumber").attr("onclick", "fastCuntDown()");
            $("#fastgetnumber").html("<spring:message code="login.register.getcode"/>");//改变按钮中value的值

            $("#fastgetnumber").attr("class", "btn bnt-yzm");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            fastwait = 120;
        } else {
            var txtStr = fastwait + '<spring:message code="login.login.chongxinhuoqu"/>';
            $("#fastgetnumber").html(txtStr);
            $("#fastgetnumber").attr("class", "btn bnt-yzm-gray");
            // 按钮里面的内容呈现倒计时状态
            $("#fastgetnumber").attr("disabled", "block");
            $("#fastgetnumber").attr("onclick", "javascript:void(0)");
            fastwait--;
            setTimeout(function () {
                fastCuntDown();
            }, 1000);
        }
    }
    function fastlogin(){
        var fastPhoneVal = $("#fastphoneid").val();
        var fastcodeVal = $("#fastcodeid").val();
        if (fastPhoneVal == "" || fastPhoneVal == null) {
            $("#fastphoneidLabel").html("<spring:message code="login.register.enterphone"/>");
            $("#fastphoneidLabel").css("display", "block");
            return;
        } else {
            $("#fastphoneidLabel").css("display", "none");
        }
        var selectValue = $('#selectid1').val();
        var code = localStorage.getItem(selectValue + "1");
        var reg = localStorage.getItem(selectValue);
        var t = new RegExp(reg);
        if (!t.test(code + fastPhoneVal)) {
            $("#fastphoneidLabel").html("<spring:message code="login.register.enterRightphone"/>");
            $("#fastphoneidLabel").css("display", "block");
            return;
        } else {
            $("#fastphoneidLabel").css("display", "none");
        }
        if (fastcodeVal == "" || fastcodeVal == null) {
            $("#fastCodetips").html("<spring:message code="login.login.entercode"/>");
            $("#fastCodetips").css("display", "block");
            return;
        } else {
            $("#fastCodetips").css("display", "none");
        }
    }
    //------------------------------注册界面-------------------------
    //加载国家的数据
    var personUid;
    function loadCountry() {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/countryid",
            modal: true,
            showBusi: false,
            timeout: 30000,
            data: {},
            success: function (data) {
                if (data.status == 1) {
                    isLoaded = true;
                    $("#selectLabel").css("display", "none");
                    $("#selectLabel1").css("display", "none");
                    var list = data.list;
                    $.each(list, function (index, value) {
                        if ("${pageContext.response.locale}".toUpperCase() == "ZH_CN") {
                            $('#selectid').append("<option value='" + value.countryValue + "'>" + value.countryNameCn + " +" + value.countryCode + "</option>");
                            $('#selectid1').append("<option value='" + value.countryValue + "'>" + value.countryNameCn + " +" + value.countryCode + "</option>");
                        } else {
                            $('#selectid').append("<option value='" + value.countryValue + "'>" + value.countryNameEn + " +" + value.countryCode + "</option>");
                            $('#selectid1').append("<option value='" + value.countryValue + "'>" + value.countryNameEn + " +" + value.countryCode + "</option>");
                        }
                        localStorage.setItem(value.countryValue, value.regularExpression);
                        localStorage.setItem(value.countryValue + "1", value.countryCode);
                    })
                } else {
                    $("#selectLabel").html("<spring:message code="login.register.countryCode"/>");
                    $("#selectLabel").css("display", "block");

                    $("#selectLabel1").html("<spring:message code="login.register.countryCode"/>");
                    $("#selectLabel1").css("display", "block");
                }
            },
            error: function () {
                $("#selectLabel").html("<spring:message code="login.register.countryCode"/>");
                $("#selectLabel").css("display", "block");

                $("#selectLabel1").html("<spring:message code="login.register.countryCode"/>");
                $("#selectLabel1").css("display", "block");
            },
            beforeSend: function () {
//                Loading.ShowLoading();
            },
            complete: function () {
//                Loading.HideLoading();
            }
        });
    }
    function leftA() {
        if ("${to}" == "login") {
            $("#loginDiv").show();
            $("#registerDiv").hide();
            $("#bottomDiv").hide();
            setTimeout(function(){
                $("#bottomDiv").show();
            },100);

            clearText();
            wait = 0;
        }
        else {
            window.history.go(-1);
        }
    }
    function jumpLogin() {
        $("#loginDiv").show();
        $("#registerDiv").hide();
        $("#bottomDiv").hide();
        setTimeout(function(){
            $("#bottomDiv").show();
        },100);

        clearText();
        wait = 0;
    }
    //同意协议
    function checkImgAction() {
        if (isAgree == 1) {
            isAgree = 0;
            $("#checkImg").attr("src", "<%=path%>/ui/images/checkbox.png");
        } else {
            isAgree = 1;
            $("#checkImg").attr("src", "<%=path%>/ui/images/checkbox1.png");
        }
    }

    //校验注册界面手机号的方法
    function checkRegisterPhone(){
        isDoCheck = 1;
        var phone = $("#phone").val();
        if (phone == "" || phone == null) {
            $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
            $("#phoneLabel1").css("display", "block");
            blurCheck = 0;
            return;
        } else {
            $("#phoneLabel1").css("display", "none");
        }
        var selectValue = $('#selectid').val();
        var code = localStorage.getItem(selectValue + "1");
        var reg = localStorage.getItem(selectValue);
        var t = new RegExp(reg);
        if (!t.test(code + phone)) {
            $("#phoneLabel1").html("<spring:message code="login.register.enterRightphone"/>");
            $("#phoneLabel1").css("display", "block");
            blurCheck = 0;
            return;
        } else {
            $("#phoneLabel1").css("display", "none");
        }
        checkAvailable(phone)
    }
    //检测是否可用
    function checkAvailable(phone){
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/checkPhoneOrEmail",
            modal: true,
            timeout: 30000,
            data: {
                checkType: "register",
                checkVal:phone,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phoneLabel1").css("display", "block");
                    $("#phoneLabel1").html("<spring:message code="login.login.phoneAble"/>");
                    blurCheck = 1;
                } else {
                    $("#phoneLabel1").html(data.msg);
                    blurCheck = 0;
                    $("#phoneLabel1").css("display", "block");
                }
            },
            error: function () {
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }
    function confirmAction() {
        var phone = $("#phone").val();
        var codeid = $("#codeid").val();
        var psdid = $("#psdids").val();
        var confimid = $("#confimid").val();
        if (isDoCheck == 0){
            if (phone == "" || phone == null) {
                $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
                $("#phoneLabel1").css("display", "block");
                return;
            } else {
                $("#phoneLabel1").css("display", "none");
            }
        }
        if (blurCheck == 0){
            return;
        }
        /*
       if (phone == "" || phone == null) {
            $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
            $("#phoneLabel1").css("display", "block");
            return;
        } else {
            $("#phoneLabel1").css("display", "none");
        }
        var selectValue = $('#selectid').val();
        var code = localStorage.getItem(selectValue + "1");
        var reg = localStorage.getItem(selectValue);
        var t = new RegExp(reg);
        if (!t.test(code + phone)) {
            $("#phoneLabel1").html("<spring:message code="login.register.enterRightphone"/>");
            $("#phoneLabel1").css("display", "block");
            return;
        } else {
            $("#phoneLabel1").css("display", "none");
        }*/

        if (codeid == "" || codeid == null) {
            $("#codeLabel1").html("<spring:message code="login.login.entercode"/>");
            $("#codeLabel1").css("display", "block");
            return;
        } else {
            $("#codeLabel1").css("display", "none");
        }

        if (psdid == "" || psdid == null) {
            $("#psdLabel1").html("<spring:message code="login.login.enterpsd"/>");
            $("#psdLabel1").css("display", "block");
            return;
        } else {
            $("#psdLabel1").css("display", "none");
        }
//        var t = /^[0-9a-zA-Z]{6,16}$/;
        var t = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,16}$/
        if (!t.test(psdid)) {
            $("#psdLabel1").html("<spring:message code="login.login.alert_newLength"/>");
            $("#psdLabel1").css("display", "block");
            return;
        } else {
            $("#psdLabel1").css("display", "none");
        }

        if (confimid == "" || confimid == null) {
            $("#confimPsd").html("<spring:message code="login.login.enterpsd"/>");
            $("#confimPsd").css("display", "block");
            return;
        } else {
            $("#confimPsd").css("display", "none");
        }
//        判断新密码是否相同
        if (psdid != confimid) {
            $("#confimPsd").html("<spring:message code="login.login.tip_lable"/>");
            $("#confimPsd").css("display", "block");
            return;
        } else {
            $("#confimPsd").css("display", "none");
        }


        if (!isAgree) {
            $("#agreeLabel").html("<spring:message code="login.register.lookTip"/>");
            $("#agreeLabel").css("display", "block");
            return;
        } else {
            $("#agreeLabel").css("display", "none");
        }
//        登录验证
        checkPhoneWithJump(phone, codeid, psdid);

    }
    function checkPhoneWithJump(phone, codeid, psdid) {
        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/login/checkregister",
            modal: true,
            timeout: 30000,
            data: {
                uid: personUid,
                phone: phone,
                newpw: psdid,
                code: codeid,
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#agreeLabel").css("display", "none");
                    var tourl = "<%=path%>/login/registersuccess";
                    window.location.href = tourl;
                } else {
                    $("#agreeLabel").html(data.msg);
                    $("#agreeLabel").css("display", "block");
                    $("#phone").attr("disabled", false);
                }
            },
            error: function () {
                $("#agreeLabel").html("<spring:message code="safe.safesuccess.failNet"/>");
                $("#agreeLabel").css("display", "block");
                $("#phone").attr("disabled", false);
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });

    }


    function getnumberonclick() {

        var phone = $("#phone").val();
        if (isDoCheck == 0){
            if (phone == "" || phone == null) {
                $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
                $("#phoneLabel1").css("display", "block");
                return;
            } else {
                $("#phoneLabel1").css("display", "none");
            }
        }
       /* if (phone == "" || phone == null) {
            $("#phoneLabel1").html("<spring:message code="login.register.enterphone"/>");
            $("#phoneLabel1").css("display", "block");
            return;
        } else {
            $("#phoneLabel1").css("display", "none");
        }
        var selectValue = $('#selectid').val();
        var code = localStorage.getItem(selectValue + "1");
        var reg = localStorage.getItem(selectValue);
        var t = new RegExp(reg);
        if (!t.test(code + phone)) {
            $("#phoneLabel1").html("<spring:message code="login.register.enterRightphone"/>");
            $("#phoneLabel1").css("display", "block");
            return;
        } else {
            $("#phoneLabel1").css("display", "none");
        }*/
        if (blurCheck == 0){
            return;
        }
        var selectValue = $('#selectid').val();
        getTestCode(phone, selectValue);
    }
    //    发送验证码
    function getTestCode(phone, selectValue) {

        $.ajax({
            async: true,
            type: "POST",
            url: "<%=path%>/safe/sendTestCode",
            modal: true,
            timeout: 30000,
            data: {
                type: 1,
                info: phone,
                domain: selectValue,
                isRegister:0
            },
            success: function (data) {
                if (data.status == 1) {
                    $("#phoneLabel1").css("display", "none");
                    $("#phone").attr("disabled", "true");
                    personUid = data.uid;
                    wait = 120;
                    countDown();
                } else {
                    $("#phoneLabel1").html(data.msg);
                    $("#phoneLabel1").css("display", "block");
                }
            },
            error: function () {
                $("#phoneLabel1").html("<spring:message code="safe.safesuccess.failNet"/>");
//                $("#phone").removeAttrs("disabled");
                $("#phoneLabel1").css("display", "block");
            },
            beforeSend: function () {
                Loading.ShowLoading();
            },
            complete: function () {
                Loading.HideLoading();
            }
        });
    }
    //    倒计时
    var wait = 120;
    function countDown() {
        if (wait == 0) {
            $("#getnumber").removeAttr("disabled");
            $("#getnumber").attr("onclick", "getnumberonclick()");
            $("#getnumber").html("<spring:message code="login.register.getcode"/>");//改变按钮中value的值

            $("#getnumber").attr("class", "btn bnt-yzm");
            //p.html("如果您在1分钟内没有收到验证码，请检查您填写的手机号码是否正确或重新发送");
            wait = 120;
        } else {
            var txtStr = wait + '<spring:message code="login.login.chongxinhuoqu"/>';
            $("#getnumber").html(txtStr);
            $("#getnumber").attr("class", "btn bnt-yzm-gray");
            // 按钮里面的内容呈现倒计时状态
            $("#getnumber").attr("disabled", "block");
            $("#getnumber").attr("onclick", "javascript:void(0)");
            wait--;
            setTimeout(function () {
                countDown();
            }, 1000);
        }
    }
    function look() {
        clearText();
        var u = window.location.pathname;
        var href = "<%=path%>/agreement?Flag=" + u;
        window.location.href = href;
    }
</script>
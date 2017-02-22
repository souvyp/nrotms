var code = "";
var code1 = "";
//var v_center = "o2o.zld.com.cn";

function _createCode( srcObj )
{
    var _code = "";
    var codeLength = 4; //验证码的长度
    var checkCode = document.getElementById( srcObj );
    var codeChars = new Array( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
         'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
         'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ); //所有候选组成验证码的字符，当然也可以用中文的
    for ( var i = 0; i < codeLength; i++ )
    {
        var charNum = Math.floor( Math.random() * 52 );
        _code += codeChars[charNum];
    }

    if ( checkCode )
    {
        checkCode.className = "code";
        checkCode.innerHTML = _code;
    }

    return _code;
}

function createCode()
{
    code = _createCode( "checkCode" );

    return true;
}

function validateCode()
{
    var inputCode = document.getElementById( "inputCode" ).value;
    if ( inputCode.length <= 0 )
    {
        alert( "请输入验证码！" );

        return false;
    }
    else if ( inputCode.toUpperCase() != code.toUpperCase() )
    {
        alert( "验证码输入有误！" );
        createCode();

        return false;
    }
    else
    {
        return true;
    }
}

function createCode1()
{
    code1 = _createCode( "checkCode1" );

    return true;
}


function validateCode1()
{
    var inputCode = document.getElementById( "inputCode1" ).value;
    if ( inputCode.length <= 0 )
    {
        alert( "请输入验证码！" );

        return false;
    }
    else if ( inputCode.toUpperCase() != code1.toUpperCase() )
    {
        alert( "验证码输入有误！" );
        createCode1();

        return false;
    }
    else
    {
        return true;
    }
}

function GetLoginProtocol( username, password )
{
    var params = [{}];
    params[0].namespace = 'protocol';
    params[0].cmd = 'login';
    params[0].version = 1;
    params[0].id = 'tms_login_0001';

    var _p = [{}, {}];
    _p[0].name = "Username";
    _p[0].value = username;
    _p[1].name = "Password";
    _p[1].value = password;

    params[0].paras = _p;
    var _params_ToString = NSF.System.Json.ToString( params );
    return _params_ToString;
    //return "[{'namespace' : 'protocol', 'cmd' : 'login'}]";
}
//登录
function DoLogin( username, password, callback )
{
    NSF.System.Network.Ajax( '/SSOPortal.aspx',
        GetLoginProtocol( username, password ),
        'POST',
        false,
        callback );
}

//登出
function GetLoginPOut()
{

    var params = [{}];
    params[0].namespace = 'protocol';
    params[0].cmd = 'logout';
    params[0].version = 1;
    params[0].id = 'vml_login_0002';

    var _params_ToString = NSF.System.Json.ToString( params );
    return _params_ToString;
}

function DoLoginOut( callback )
{
    NSF.System.Network.Ajax( '/SSOPortal.aspx',
        GetLoginPOut(),
        'POST',
        false,
        callback
        );
}
//注册
function GetRegister( Name, Phone, Mail, Contact, Driver )
{
    var params = [{}];
    params[0].namespace = 'protocol';
    params[0].cmd = 'data';
    params[0].version = 1;
    params[0].id = 'tms_0056';

    var _Reg = [{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}];
    _Reg[0].name = 'Name';
    _Reg[0].value = Name;
    _Reg[1].name = 'Industry';
    _Reg[1].value = 0;
    _Reg[2].name = 'Logo';
    _Reg[2].value = '';
    _Reg[3].name = 'Web';
    _Reg[3].value = ''; 
    _Reg[4].name = 'ShortName';
    _Reg[4].value = ''; 
    _Reg[5].name = 'EnName';
    _Reg[5].value = ''; 
    _Reg[6].name = 'ShortEnName';
    _Reg[6].value = ''; 
    _Reg[7].name = 'Master';
    _Reg[7].value = ''; 
    _Reg[8].name = 'IsPersonal';
    _Reg[8].value = Driver;
    _Reg[9].name = 'Contact';
    _Reg[9].value = Contact;
    _Reg[10].name = 'Phone';
    _Reg[10].value = Phone;
    _Reg[11].name = 'Fax';
    _Reg[11].value = '';
    _Reg[12].name = 'Zip';
    _Reg[12].value = ''; 
    _Reg[13].name = 'Address';
    _Reg[13].value = ''; 
    _Reg[14].name = 'Mail';
    _Reg[14].value = Mail;
    _Reg[15].name = 'WeiXin';
    _Reg[15].value = '';
    _Reg[16].name = 'Bank';
    _Reg[16].value = ''; 
    _Reg[17].name = 'BankAccount';
    _Reg[17].value = ''; 
    _Reg[18].name = 'Description';
    _Reg[18].value = ''; 
     
    params[0].paras = _Reg;

    var Reg_ToString = NSF.System.Json.ToString( params );
    return Reg_ToString;
}

function DoRegister( Name, Phone, Mail, Contact, Driver, callback )
{
    NSF.System.Network.Ajax( '/Portal.aspx',
        GetRegister( Name, Phone, Mail, Contact, Driver ),
        'POST',
        false,
        callback
        );
}

//判断是否有登入注册,并给与相应的样式
$( function ()
{
    var user = $( '#userID' ).text();
    if ( user == 0 )
    {
        $( '.micro1' ).css( 'right', 160 + 'px' );
    }
    else
    {
        $( '.micro1' ).css( 'right', 100 + 'px' );
    }

    $( '.login' ).click( function ()
    {
        location.href = '/Login.aspx';
    } );

    //微信
    $( ".micro" ).mouseover( function ()
    {
        $( ".micro1" ).css( "display", "block" ).show( 10 );
    } )
    $( ".log-cont,.top_zld,.index_page" ).mouseout( function ()
    {
        $( ".micro1" ).css( "display", "none" );
    } );

    //login切换
    $( ".log1" ).click( function ()
    {
        $( "#log-sub2" ).css( "display", "block" );
        $( "#log-sub1,#log-sub3,#log-sub4" ).css( "display", "none" );
    } )//注册
    $( ".log2" ).click( function ()
    {
        $( "#log-sub1" ).css( "display", "block" );
        $( "#log-sub2,#log-sub3,#log-sub4" ).css( "display", "none" );
    } )//登录
    $( ".log3" ).click( function ()
    {
        $( "#log-sub3" ).css( "display", "block" );
        $( "#log-sub1,#log-sub2,#log-sub4" ).css( "display", "none" );
    } )//忘记密码

    createCode1();
} );
//返回前一页
function back()
{
    history.go( -1 );
}
//修改用户密码
function UpdatePwdSave()
{
    var Username = $( 'input[name="Username"]' ).val();
    var OldPwd = $( 'input[name="OldPwd"]' ).val();
    var NewPwd = $( 'input[name="NewPwd"]' ).val();
    var ReOldPwd = $( 'input[name="ReOldPwd"]' ).val();

    if ( NewPwd != ReOldPwd )
    {
        alert( "两次输入的密码不一致，请重新输入!" );
    }
    else
    {
        DoUserPwd( Username, OldPwd, NewPwd, _UserUpdatePwd );
    }

}
function GetUpdatePwd( Username, OldPwd, NewPwd )
{
    var params = [{}];
    params[0].namespace = 'protocol';
    params[0].cmd = 'data';
    params[0].version = 1;
    params[0].id = 'tms_0058';

    var _Reg = [{}, {}, {}];
    _Reg[0].name = 'Username';
    _Reg[0].value = Username;
    _Reg[1].name = 'OldPwd';
    _Reg[1].value = OldPwd;
    _Reg[2].name = 'NewPwd';
    _Reg[2].value = NewPwd;

    params[0].paras = _Reg;

    var Reg_ToString = NSF.System.Json.ToString( params );
    return Reg_ToString;
}

function DoUserPwd( Username, OldPwd, NewPwd, callback )
{
    NSF.System.Network.Ajax( '/Portal.aspx',
        GetUpdatePwd( Username, OldPwd, NewPwd ),
        'POST',
        false,
        callback
        );
}

function _UserUpdatePwd( result, data )
{
    if ( data[0].result )
    {
        if ( data[0].rs[0].rows[0].Pwd_Result == 0 )
        {
            alert( "修改成功！" );
        }
        else
        {
            alert( '错误代码：' + data[0].rs[0].rows[0].Pwd_Result );
        }
    }
    else
    {
        alert( data[0].msg);
    }
}

//记住用户名密码
 function SetLastUser(usr) {
        var id = "49BAC005-7D5B-4231-8CEA-16939BEACD67";
        var expdate = new Date();
        //当前时间加上两周的时间
        expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
        SetCookie(id, usr, expdate);
    }

    //写入到Cookie
    function SetCookie(name, value, expires) {
        var argv = SetCookie.arguments;
        //本例中length = 3
        var argc = SetCookie.arguments.length;
        var expires = (argc > 2) ? argv[2] : null;
        var path = (argc > 3) ? argv[3] : null;
        var domain = (argc > 4) ? argv[4] : null;
        var secure = (argc > 5) ? argv[5] : false;

        document.cookie = name + "=" + escape(value) + ((expires == null) ? "" : ("; expires=" + expires.toGMTString())) + ((path == null) ? "" : ("; path=" + path)) + ((domain == null) ? "" : ("; domain=" + domain)) + ((secure == true) ? "; secure" : "");

        if( typeof name == "undefined" ){
          document.cookie = "49BAC005-7D5B-4231-8CEA-16939BEACD67="; 
        }
    }

    function GetLastUser() {
        var id = "49BAC005-7D5B-4231-8CEA-16939BEACD67";//GUID标识符
        var usr = GetCookie(id);
        if (usr != null) {
            $('input[name="loginUsername"]').val( usr );
        } 
        GetPwdAndChk();
    }

    function getCookieVal(offset) {
        var endstr = document.cookie.indexOf(";", offset);
        if (endstr == -1) endstr = document.cookie.length;
        return unescape(document.cookie.substring(offset, endstr));
    }

    //取Cookie的值
    function GetCookie(name) {
        var arg = name + "=";
        var alen = arg.length;
        var clen = document.cookie.length;
        var i = 0;
        while (i < clen) {
            var j = i + alen;
            //alert(j);
            if (document.cookie.substring(i, j) == arg) return getCookieVal(j);
            i = document.cookie.indexOf(" ", i) + 1;
            if (i == 0) break;
        }
        return null;
    }

    //用户名失去焦点时调用该方法
    function GetPwdAndChk() {
        var usr = $('input[name="loginUsername"]').val();
        var pwd = GetCookie(usr);
        if (pwd != null) {
            $('input.userpwd')[0].checked = true;
            $('input[name="loginPassword"]').val( pwd );
        } else {
            $('input.userpwd')[0].checked = false;
            $('input[name="loginPassword"]').val( "" );
        }
    }


    //邮箱失去焦点时调用该方法
    function GetCompany() {
	    var params = [{}];
	    params[0].namespace = 'protocol';
	    params[0].cmd = 'data';
	    params[0].version = 1;
	    params[0].id = 'company_SiginCheck';
	
	    var _Reg = [];
        var _data;
	    
        $('input.data').each(function() {
            _data = {};

            _data.name = $(this).attr('name');
            _data.value = $(this).val();

            _Reg.push(_data);
        });
	 
	     
	    params[0].paras = _Reg;
	
	    var Reg_ToString = NSF.System.Json.ToString( params );
        NSF.System.Network.Ajax('/Portal.aspx',
            Reg_ToString,
            'POST',
            false,
            function(result, data)
            {
                if (data[0]) 
                {
                	if (data[0].rs[0].rows[0].check_Result == '-510001005') {
                        alert('手机号已存在！');
                    } else if (data[0].rs[0].rows[0].check_Result == '-510001002') {
                        alert('公司名称已经存在！');
                    } else if (data[0].rs[0].rows[0].check_Result == '-510001006') {
                        alert('邮箱地址已经存在！');
                    }
                } 
            });
	  
    }

    //删除cookie
    function ResetCookie( user, pwd ) {
      var expdate = new Date();
      SetCookie(user, pwd, expdate);
    }
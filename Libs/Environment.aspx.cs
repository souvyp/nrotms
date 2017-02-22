using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using NDS.Kits;
using NDS.Kits.Crypt;
using NDS.Kits.IO;
using NDS.NML.Handler;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace OTMS
{
    #region Environment TMS的统一界面代码处理类[Public]
    /// <summary>
    /// 统一界面代码处理类
    /// </summary>
    public partial class Environment : System.Web.UI.Page
    {
        #region 类的属性
        /// <summary>
        /// Url参数集对象
        /// </summary>
        public UrlEnvironment UrlEnv;
        #endregion

        #region 初始化
        /// <summary>
        /// 初始化
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load( object sender, EventArgs e )
        {
            //装载配置信息
            if ( !Config.Instance.IsInitialized )
            {
                Config.Instance.Load();
            }

            VerifyUserStatus();

            //特定页的处理代码
            string sUrl = Request.Url.ToString().ToLower();
            if ( sUrl.IndexOf( "register.aspx" ) != -1 )
            {
                //注册页面
                UrlEnv = new UrlEnvironment( "Para" );
            }
        }
        #endregion

        #region 类的私有函数
        #region IsUrlIgnoreSSOVerify 当前Url是否忽略SSO校验
        /// <summary>
        /// 当前Url是否忽略SSO校验
        /// </summary>
        /// <param name="sUrl">Url地址</param>
        /// <returns>是否忽略校验</returns>
        private bool IsUrlIgnoreSSOVerify( string sUrl )
        {
            if ( Config.Instance.sso.IgnoreUrl != null &&
                Config.Instance.sso.IgnoreUrl.Length > 0 )
            {
                string[] _ignore = Config.Instance.sso.IgnoreUrl.Split(",".ToCharArray());
                for ( int i = 0; i < _ignore.Length; i++ )
                {
                    string _name = _ignore[i].ToLower();
                    sUrl = sUrl.ToLower();

                    if ( sUrl.IndexOf( _name ) != -1 )
                    {
                        return true;
                    }
                }
            }

            return false;
        }
        #endregion

        #region GetUrlPara 获取Url中的参数
        /// <summary>
        /// 获取Url中的参数
        /// </summary>
        /// <param name="sName"></param>
        /// <returns></returns>
        private string GetUrlPara( string sName )
        {
            if ( UrlEnv != null )
            {
                return UrlEnv.Get( sName );
            }

            return "";
        }
        #endregion
        #endregion

        #region 类的方法
        #region MindMapMenu相关
        #region MindMapMenuUrl 根据模块的名称生成Url地址[Public]
        /// <summary>
        /// 根据模块的名称生成Url地址
        /// </summary>
        /// <param name="sModule">模块名</param>
        /// <returns>Url地址</returns>
        public string MindMapMenuUrl( string sModule )
        {
            StringBuilder sb = new StringBuilder();
            sb.Append( "/MMMenu.aspx?module=");
            sb.Append( sModule );
            sb.Append( "&role=" );
            sb.Append( GetUserInfo().RoleId.ToString() );
            sb.Append( "&ver=" );
            sb.Append( zMindMapMenu.CurrentVersion( sModule ).ToString() );

            return sb.ToString();
        }
        #endregion
        #endregion

        #region Minify相关
        #region MinifyUrl 根据Minify的名称生成Url地址[Public]
        /// <summary>
        /// 根据Minify的名称生成Url地址
        /// </summary>
        /// <param name="sName">名称</param>
        /// <returns>地址</returns>
        public string MinifyUrl( string sName )
        {
            StringBuilder sb = new StringBuilder();
            sb.Append( "/Minify.aspx?jcss=" );
            sb.Append( Config.Instance.MinifyParameters( sName ) );
            sb.Append( "&ver=" );
            sb.Append( zMinify.CurrentVersion() );
            
            return sb.ToString();
        }
        #endregion
        #endregion

        #region SSO相关
        #region VerifyUserStatus 登录校验
        /// <summary>
        /// 登录校验
        /// </summary>
        public void VerifyUserStatus( )
        {
            string sUrl = Request.Url.AbsolutePath.ToLower();

            if ( !SSOWrapper.IsSignedIn() )
            {
                if ( !IsUrlIgnoreSSOVerify( sUrl ) )
                {
                    zLogger.Instance.OperateLog( sUrl, Request.UserHostAddress, "Enviroment::VerifyUserStatus", "redirect", true );

                    Response.Redirect( "/Login.aspx" );
                }
            }
            else
            {
                zUser _user = SSOWrapper.GetUserInfo();

                //首次登录显示Splash页面
                if ( _user.IsFirstLogin == 1 )
                {
                    _user.IsFirstLogin = 0;
                    SSOWrapper.SetUserInfo( ref _user, Config.Instance.WebsiteParameters( "SSODomain" ) );

                    Response.Redirect( "/Splash.aspx" );
                }
                else
                {
                    //Splash页手动跳转
                    if ( sUrl.IndexOf( "splash.aspx" ) != -1 )
                    {
                        return;
                    }

                    //管理员、财务人员、业务员不允许登录TMS模块
                    if ( UserRole.Equal( _user.RoleId, UserRole.Administrator ) )
                    {
                        //管理员
                        if ( sUrl.IndexOf( "/login.aspx" ) != -1 || sUrl == "/index.aspx" )
                        {
                            Response.Redirect( "/AMS/Index.aspx" );
                        }
                        else if ( sUrl.IndexOf( "/ams/" ) == -1 && !IsUrlIgnoreSSOVerify( sUrl ) )
                        {
                            //注销并重新登录
                            SSOWrapper.Signout( Config.Instance.WebsiteParameters( "SSODomain" ) );

                            Response.Redirect( "/Login.aspx" );
                        }
                    }
                    else if ( UserRole.Equal( _user.RoleId, UserRole.Financial ) )
                    {
                        //财务人员
                        if ( sUrl.IndexOf( "/login.aspx" ) != -1 || sUrl == "/index.aspx" )
                        {
                            Response.Redirect( "/FMS/Index.aspx" );
                        }
                        else if ( sUrl.IndexOf( "/fms/" ) == -1 && !IsUrlIgnoreSSOVerify( sUrl ) )
                        {
                            //注销并重新登录
                            SSOWrapper.Signout( Config.Instance.WebsiteParameters( "SSODomain" ) );

                            Response.Redirect( "/Login.aspx" );
                        }
                    }
                    else if ( UserRole.Equal( _user.RoleId, UserRole.Sales ) ||
                        UserRole.Equal( _user.RoleId, UserRole.Buyer ) )
                    {
                        //业务员
                        if ( sUrl.IndexOf( "/login.aspx" ) != -1 || sUrl == "/index.aspx" )
                        {
                            if (UserRole.Equal( _user.RoleId, UserRole.Sales) )
                            {
                                Response.Redirect( "/PMS/Index.aspx" );
                            }
                            else if (UserRole.Equal( _user.RoleId, UserRole.Buyer) )
                            {
                                Response.Redirect( "PMS/VerifingDoc.aspx" );
                            }
                        }
                        else if ( sUrl.IndexOf( "/pms/" ) == -1 && !IsUrlIgnoreSSOVerify( sUrl ) )
                        {
                            //注销并重新登录
                            SSOWrapper.Signout( Config.Instance.WebsiteParameters( "SSODomain" ) );

                            Response.Redirect( "/Login.aspx" );
                        }
                    }
                    else if ( UserRole.Equal( _user.RoleId, UserRole.Boss ) )
                    {
                        //老板
                        if ( sUrl.IndexOf( "/login.aspx" ) != -1 || sUrl == "/index.aspx" )
                        {
                            Response.Redirect( "/RMS/Index.aspx" );
                        }
                        else if ( sUrl.IndexOf( "/rms/" ) == -1 && 
                            !IsUrlIgnoreSSOVerify( sUrl ) )
                        {
                            //注销并重新登录
                            SSOWrapper.Signout( Config.Instance.WebsiteParameters( "SSODomain" ) );

                            Response.Redirect( "/Login.aspx" );
                        }
                    }
                    else if ( UserRole.Equal( _user.RoleId, UserRole.Manager ) )
                    {
                        //注销并重新登录
                        SSOWrapper.Signout( Config.Instance.WebsiteParameters( "SSODomain" ) );

                        Response.Redirect( "/Login.aspx" );
                    }
                    else
                    {
                        //其他

                        if ( sUrl.IndexOf( "/login.aspx" ) != -1 || sUrl == "/index.aspx" )
                        {
                            Response.Redirect( "/TMS/Index.aspx" );
                        }
                        else if ( sUrl.IndexOf( "/tms/" ) == -1 && !IsUrlIgnoreSSOVerify( sUrl ) )
                        {
                            //注销并重新登录
                            SSOWrapper.Signout( Config.Instance.WebsiteParameters( "SSODomain" ) );

                            Response.Redirect( "/Login.aspx" );
                        }
                    }
                }
            }
        }
        #endregion

        #region Now 获取当前时间[Public]
        /// <summary>
        /// 获取当前时间
        /// </summary>
        /// <returns></returns>
        public string Now( )
        {
            return zDate.Format( DateTime.Now, DateFormatStyle.Style( true, true, true, true ) );
        }
        #endregion

        #region IsSignedIn 是否已经登录[Public]
        /// <summary>
        /// 是否已经登录
        /// </summary>
        /// <returns></returns>
        public bool IsSignedIn( )
        {
            string sUrl = Request.Url.AbsolutePath.ToLower();
            zLogger.Instance.OperateLog( sUrl, Request.UserHostAddress, "Enviroment", "IsSignedIn", true );

            return SSOWrapper.IsSignedIn( );
        }
        #endregion

        #region GetUserInfo 获取当前登录的用户信息[Public]
        /// <summary>
        /// 获取当前登录的用户信息
        /// </summary>
        /// <returns>用户对象</returns>
        public zUser GetUserInfo( )
        {
            try
            {
                return SSOWrapper.GetUserInfo();
            }
            catch
            {
                return new zUser();
            }
        }
        #endregion

        #region GetTruename 获取当前登录用户的真实姓名[Public]
        /// <summary>
        /// 获取当前登录用户的真实姓名
        /// </summary>
        /// <returns>姓名</returns>
        public string GetTruename( )
        {
            try
            {
                return GetUserInfo().Truename;
            }
            catch
            {
                return "";
            }
        }
        #endregion

        #region GetUsername 获取当前登录用户的账号名[Public]
        /// <summary>
        /// 获取当前登录用户的账号名
        /// </summary>
        /// <returns>账号名</returns>
        public string GetUsername( )
        {
            try
            {
                return GetUserInfo().Username;
            }
            catch
            {
                return "";
            }
        }
        #endregion

        #region GetUserID 获取当前登录用户的编号[Public]
        /// <summary>
        /// 获取当前登录用户的编号
        /// </summary>
        /// <returns>用户编号</returns>
        public string GetUserID( )
        {
            try
            {
                return GetUserInfo().Id.ToString();
            }
            catch
            {
                return "";
            }
        }
        #endregion
        #endregion

        #region 网址加解密
        #region GetUrlDstCompanyName 解密网址并获取目标公司名参数[Public]
        /// <summary>
        /// 解密网址并获取目标公司名参数
        /// </summary>
        /// <returns>公司名</returns>
        public string GetUrlDstCompanyName( )
        {
            return GetUrlPara( "DstName" );
        }
        #endregion

        #region GetUrlSrcCompanyID 解密网址并获取邀请者的公司编号[Public]
        /// <summary>
        /// 解密网址并获取邀请者的公司编号
        /// </summary>
        /// <returns>公司编号</returns>
        public string GetUrlSrcCompanyID( )
        {
            return GetUrlPara( "SrcID" );
        }
        #endregion
        #endregion
        #endregion
    }
    #endregion
}
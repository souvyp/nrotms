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
    public partial class CompanyInvite : System.Web.UI.Page
    {
        /// <summary>
        /// 注册网址
        /// </summary>
        public string RegisterUrl = "";

        protected void Page_Load( object sender, EventArgs e )
        {
            //装载配置信息
            if ( !Config.Instance.IsInitialized )
            {
                Config.Instance.Load();
            }

            VerifyUserStatus();

            if ( Request.Form.Count > 0 )
            {
                string sId = Request.Form[ "SrcID" ].Trim();
                string sName = Request.Form[ "SrcName" ].Trim();
                string sDstName = Request.Form[ "DstName" ].Trim();
                string sDstMail = Request.Form[ "DstMail" ].Trim();
                string sInviteMode = Request.Form[ "InviteMode" ].Trim();

                UrlEnvironment UrlEnv = new UrlEnvironment();
                UrlEnv.Set( "SrcID", sId );
                UrlEnv.Set( "DstName", sDstName );

                RegisterUrl = "http://";
                RegisterUrl += Config.Instance.WebsiteParameters( "SSODomain" );
                RegisterUrl += "/Register.aspx?Para=";
                RegisterUrl += UrlEnv.Encode();

                if ( sInviteMode == "1" )
                {
                    //邮件

                    Panel2.Visible = false;
                    Panel1.Visible = false;
                    Panel3.Visible = true;

                    //邮件模板
                    byte[] _template = zFile.BinaryReading( Server.MapPath( "Resources/Mail/CompanyInvite.html" ) );
                    if ( _template.Length > 0 )
                    {
                        string sTemplate = Encoding.UTF8.GetString( _template );

                        //替换模板内容
                        sTemplate = sTemplate.Replace( "<%=DstName%>", sDstName );
                        sTemplate = sTemplate.Replace( "<%=NOW%>", zDate.Format( DateTime.Now, DateFormatStyle.Style( true, false, false, true)) );
                        sTemplate = sTemplate.Replace( "<%=RegisterURL%>", RegisterUrl );
                        sTemplate = sTemplate.Replace( "<%=SrcName%>", sName );

                        zMail mail = new zMail( sDstMail, sDstName + "的OTMS邀请", sTemplate );
                        mail.Send();
                        mail.Close();
                    }
                }
                else
                {
                    //微信

                    Panel3.Visible = false;
                    Panel1.Visible = false;
                    Panel2.Visible = true;

                    //do nothing
                    //generate the qrcode with javascript library
                }
            }
            else
            {
                Panel2.Visible = false;
                Panel3.Visible = false;
                Panel1.Visible = true;
            }
        }

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
                string[] _ignore = Config.Instance.sso.IgnoreUrl.Split( ",".ToCharArray() );
                for ( int i = 0; i < _ignore.Length; i++ )
                {
                    string _name = _ignore[ i ].ToLower();
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
        #endregion

        #region 类的方法
        #region SSO相关
        #region VerifyUserStatus 登录校验
        /// <summary>
        /// 登录校验
        /// </summary>
        public void VerifyUserStatus( )
        {
            string sUrl = Request.Url.AbsolutePath.ToLower();

            if ( !SSOWrapper.IsSignedIn() &&
                !IsUrlIgnoreSSOVerify( sUrl ) )
            {
                zLogger.Instance.OperateLog( sUrl, Request.UserHostAddress, "Enviroment::VerifyUserStatus", "redirect", true );

                Response.Redirect( "/Login.aspx" );
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

            return SSOWrapper.IsSignedIn();
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
        #endregion
    }
}
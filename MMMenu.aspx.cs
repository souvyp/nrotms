using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NDS.Kits;
using NDS.Kits.IO;
using NDS.NML.Handler;

namespace OTMS
{
    public partial class MMMenu : System.Web.UI.Page
    {
        protected void Page_Load( object sender, EventArgs e )
        {
            //装载配置信息
            if ( !Config.Instance.IsInitialized )
            {
                Config.Instance.Load();
            }

            if ( !IsSignedIn() )
            {
                Response.Write( "{}" );
            }
            else
            {
                string sMode = Request.QueryString[ "module" ];
                string sVer = Request.QueryString[ "ver" ];
                
                //role参数需要上传，用于做反向代理
                //为防止URL欺骗，此处直接读取用户状态
                int nRoleID = ( int )GetUserInfo().RoleId;

                if ( sMode.Length > 0 )
                {
                    int nVer = 0;
                    try
                    {
                        nVer = Convert.ToInt32( sVer );
                    }
                    catch
                    {
                        nVer = 0;
                    }
                    zMindMapMenu.Process( sMode, nRoleID, nVer );
                }
            }
        }

        #region IsSignedIn 是否已经登录[Public]
        /// <summary>
        /// 是否已经登录
        /// </summary>
        /// <returns></returns>
        public bool IsSignedIn( )
        {
            string sUrl = Request.Url.AbsolutePath.ToLower();
            zLogger.Instance.OperateLog( sUrl, Request.UserHostAddress, "MMMenu", "IsSignedIn", true );

            return SSOWrapper.IsSignedIn();
        }
        #endregion

        #region GetUserInfo 获取当前登录的用户信息
        /// <summary>
        /// 获取当前登录的用户信息
        /// </summary>
        /// <returns>用户对象</returns>
        private zUser GetUserInfo( )
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
    }
}
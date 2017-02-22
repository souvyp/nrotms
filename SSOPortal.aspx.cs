using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using NDS.Kits;
using NDS.SSO;
using NDS.SSO.Handler;

namespace OTMS
{
    public partial class SSOPortal : System.Web.UI.Page
    {
        protected void Page_Load( object sender, EventArgs e )
        {
            //装载配置信息
            if ( !Config.Instance.IsInitialized )
            {
                Config.Instance.Load();
            }

            //调用Plug-in处理PML请求
            PMLSSO.Process();
        }
    }
}
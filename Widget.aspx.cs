using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NDS.Kits;
using NDS.Kits.IO;
using NDS.Widgets.Grid;

namespace OTMS
{
    public partial class Widget : System.Web.UI.Page
    {
        protected void Page_Load( object sender, EventArgs e )
        {
            //装载配置信息
            if ( !Config.Instance.IsInitialized )
            {
                Config.Instance.Load();
            }

            //调用Plug-in处理PML请求
            GridPortal.Process();
        }
    }
}
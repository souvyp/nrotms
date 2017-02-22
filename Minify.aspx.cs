﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NDS.Kits;
using NDS.Kits.IO;

namespace OTMS
{
    public partial class Minify : System.Web.UI.Page
    {
        protected void Page_Load( object sender, EventArgs e )
        {
            //装载配置信息
            if ( !Config.Instance.IsInitialized )
            {
                Config.Instance.Load();
            }

            string sMinify = Request.QueryString["jcss"];

            if ( sMinify.Length > 0 )
            {
                zMinify.Process( sMinify );
            }
        }
    }
}
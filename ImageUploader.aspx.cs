using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NDS.Kits;
using NDS.Kits.IO;
using NDS.NML.Handler;
using System.Reflection;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace OTMS
{
    public partial class ImageUploader : System.Web.UI.Page
    {
        protected void Page_Load( object sender, EventArgs e )
        {
            JObject res = new JObject();

            string sMode = Request.QueryString[ "mode" ];
            if ( sMode == null )
            {
                sMode = "";
            }
            else
            {
                sMode = sMode.Trim();
            }

            if ( !SSOWrapper.IsSignedIn() )
            {
                _DoError( ref res, -10001001, "Please sign in first!", sMode );
            }
            else
            {
                if ( Request.Files.Count > 0 )
                {
                    string sPath = "";

                    try
                    {
                        string sExt = zUrl.Type( Request.Files[ 0 ].FileName );
                        string sName = zDate.Format( DateTime.Now, DateFormatStyle.Style( true, true, true, true, "", "", "", "" ) );
                        sName += zString.RadonString( 4, RandomStrDictionary.AZ09 );
                        sName += "." + sExt;

                        sPath = Server.MapPath( "/UploadFiles/" + sName );
                        Request.Files[ 0 ].SaveAs( sPath );

                        string url = "/UploadFiles/" + sName;

                        if ( IsDroparea( sMode ) )
                        {
                            res.Add( "path", "/UploadFiles/" );
                            res.Add( "filename", sName );
                        }
                        else
                        {
                            res.Add( "error", 0 );
                            res.Add( "url", url );
                        }
                    }
                    catch ( Exception ex )
                    {
                        zLogger.Instance.DebugLog( MethodBase.GetCurrentMethod().DeclaringType.FullName, MethodBase.GetCurrentMethod().Name, sPath + "\r\n" + ex.ToString(), ex.StackTrace );

                        _DoError( ref res, -10001002, "Failed to upload the files!", sMode );
                    }
                }
                else
                {
                    _DoError( ref res, -10001003, "The http body is empty!", sMode );
                }
            }

            Response.Write( res.ToString() );
        }

        private void _DoError( ref JObject res, int _err, string _msg, string _mode )
        {
            if ( IsDroparea( _mode ) )
            {
                res.Add( "path", "" );
                res.Add( "filename", "" );
            }
            else
            {
                res.Add( "error", _err );
                res.Add( "message", _msg );
            }

            return;
        }

        private bool IsDroparea( string _mode )
        {
            if ( _mode.ToLower() == "droparea" )
            {
                return true;
            }

            return false;
        }
    }
}
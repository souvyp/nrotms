using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using NDS.Kits;
using NDS.Kits.Crypt;
using NDS.Kits.IO;
using NDS.NML.Handler;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace OTMS
{
    #region UrlEnvironment 从加密的Url串中获取指定名字的参数[Public]
    /// <summary>
    /// 从加密的Url串中获取指定名字的参数
    /// </summary>
    public class UrlEnvironment
    {
        #region 类的成员变量
        private string encParas = "";
        private JObject paras;
        #endregion

        #region 初始化
        /// <summary>
        /// 初始化[写入模式]
        /// </summary>
        public UrlEnvironment( )
        {
            paras = new JObject();
        }

        /// <summary>
        /// 初始化[读取模式]
        /// </summary>
        /// <param name="name">Url串的名字</param>
        public UrlEnvironment( string name )
        {
            zWebRequest req = new zWebRequest();
            req.DataSource = HttpContext.Current.Request.QueryString;

            encParas = req.getString( name, 0 );
            if ( encParas.Length > 0 &&
                Config.Instance.aes.UrlParas.Length >= 32 )
            {
                AES aes = new AES( AES.KeySize.Bits256, Encoding.UTF8.GetBytes( Config.Instance.aes.UrlParas ) );

                byte[] bParas = aes.Decrypt( encParas );
                if ( bParas.Length > 0 )
                {
                    try
                    {
                        paras = JObject.Parse( Encoding.UTF8.GetString( bParas ) );
                    }
                    catch
                    {
                        paras = null;
                    }
                }
            }
        }
        #endregion

        #region 类的方法
        #region Encode 将参数加密[Public]
        /// <summary>
        /// 将参数加密
        /// </summary>
        /// <returns></returns>
        public string Encode( )
        {
            AES aes = new AES( AES.KeySize.Bits256, Encoding.UTF8.GetBytes( Config.Instance.aes.UrlParas ) );

            byte[] _para = Encoding.UTF8.GetBytes( paras.ToString() );

            return aes.Encrypt( ref _para );
        }
        #endregion

        #region Set 添加参数[Public]
        /// <summary>
        /// 添加参数
        /// </summary>
        /// <param name="name">参数名</param>
        /// <param name="value">参数值</param>
        /// <returns>操作是否成功</returns>
        public bool Set( string name, string value )
        {
            paras.Add( name, value );

            return true;
        }
        #endregion

        #region Get 读取参数[Public]
        /// <summary>
        /// 读取参数
        /// </summary>
        /// <param name="name">参数名</param>
        /// <returns>参数值</returns>
        public string Get( string name )
        {
            if ( paras != null )
            {
                return paras[ name ].ToString();
            }

            return "";
        }
        #endregion
        #endregion
    }
    #endregion
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OTMS
{
    #region UserRole 用户角色枚举值[Public]
    /// <summary>
    /// 用户角色枚举值
    /// </summary>
    public class UserRole
    {
        #region Equal 判断角色是否和配置值相同[Public]
        /// <summary>
        /// 判断角色是否和配置值相同
        /// </summary>
        /// <param name="config">配置值</param>
        /// <param name="role">角色值</param>
        /// <returns>是否相同</returns>
        public static bool Equal( UInt64 config, UInt64 role )
        {
            if ( config == role )
            {
                return true;
            }
            else if ( (config & role) == role )
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        #endregion

        #region 类的静态属性
        /// <summary>
        /// 下单员
        /// </summary>
        public static UInt64 OrderCreator = 1;
        /// <summary>
        /// 收单员
        /// </summary>
        public static UInt64 OrderReceiver = 2;
        /// <summary>
        /// 司机
        /// </summary>
        public static UInt64 Driver = 4;
        /// <summary>
        /// 财务
        /// </summary>
        public static UInt64 Financial = 8;
        /// <summary>
        /// 调度
        /// </summary>
        public static UInt64 Planner = 16;
        /// <summary>
        /// 采购
        /// </summary>
        public static UInt64 Buyer = 32;
        /// <summary>
        /// 管理人员
        /// </summary>
        public static UInt64 Manager = 64;
        /// <summary>
        /// 老板
        /// </summary>
        public static UInt64 Boss = 128;
        /// <summary>
        /// 管理员
        /// </summary>
        public static UInt64 Administrator = 256;
        /// <summary>
        /// 业务员
        /// </summary>
        public static UInt64 Sales = 512;
        #endregion
    }
    #endregion
}
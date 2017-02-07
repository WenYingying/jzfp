using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
   public class PovertyArchivesChangeLog
    {
        /// <summary>
		/// 贫困信息修改日志ID
		/// </summary>
		public long ID { set; get; }
        /// <summary>
        /// 贫困信息Id
        /// </summary>
        public long PovertyArchivesId { set; get; }
        /// <summary>
        /// 操作人员ID
        /// </summary>
        public long UserId { set; get; }
        /// <summary>
        /// 修改内容
        /// </summary>
        public string ChangeText { set; get; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string PostTime { set; get; }
    }
}

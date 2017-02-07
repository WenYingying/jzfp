using System;
namespace Model{

	/// <summary>
	/// 适龄未入学原因
	/// </summary>
	public class OutPreschoolReason{
		/// <summary>
		/// </summary>
		public long ID{set;get;}
		/// <summary>
		/// 名称
		/// </summary>
		public string Name{set;get;}
		/// <summary>
		/// 简介
		/// </summary>
		public string Detail{set;get;}
        /// <summary>
        /// 是否启用
        /// </summary>
        public bool IsEnable { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string PostTime{set;get;}
	}
}

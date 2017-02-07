using System;
namespace Model{

	/// <summary>
	/// 帮扶政策表
	/// </summary>
	public class Policy{
		/// <summary>
		/// 帮扶政策Id
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
        /// 教育阶段
        /// </summary>
        public string EduLevels { get; set; }
        /// <summary>
        /// 创建用户Id
        /// </summary>
        public long UserId { get; set; }
        /// <summary>
        /// 城市ID
        /// </summary>
        public long CityID { get; set; }
        /// <summary>
        /// 县/区ID
        /// </summary>
        public long CountyID { get; set; }
        /// <summary>
        /// 省ID
        /// </summary>
        public long ProvinceID { get; set; }
        /// <summary>
        /// 是否启用
        /// </summary>
        public bool IsEnable { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string PostTime{set;get;}
        /// <summary>
        /// 城市名称
        /// </summary>
        public string CityName { get; set; }
        /// <summary>
        /// 县名称
        /// </summary>
        public string CountyName { get; set; }
        /// <summary>
        /// 省名称
        /// </summary>
        public string ProvinceName { get; set; }
        /// <summary>
        /// 金额
        /// </summary>
        public string Amount { get; set; }
        /// <summary>
        /// 等级
        /// </summary>
        public int Grade { get; set; }
    }
}

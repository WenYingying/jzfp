using System;
namespace Model
{

    /// <summary>
    /// 公告
    /// </summary>
    public class Notice
    {
        /// <summary>
        /// 公告ID
        /// </summary>
        public long ID { set; get; }
        /// <summary>
        /// 用户Id
        /// </summary>
        public long UserId { set; get; }
        /// <summary>
        /// 公告名称
        /// </summary>
        public string Name { set; get; }
        /// <summary>
        /// 公告详情
        /// </summary>
        public string Detail { set; get; }
        /// <summary>
        /// 省id
        /// </summary>
        public long ProvinceID { set; get; }
        /// <summary>
        /// 市id
        /// </summary>
        public long CityID { set; get; }
        /// <summary>
        /// 县id
        /// </summary>
        public long CountyID { set; get; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string PostTime { set; get; }
        /// <summary>
        /// 省名称
        /// </summary>
        public string ProvinceName { set; get; }
        /// <summary>
		/// 市/州名称
		/// </summary>
		public string CityName { set; get; }
        /// <summary>
		/// 县/区名称
		/// </summary>
		public string CountyName { set; get; }
        /// <summary>
        /// 省名称拼音
        /// </summary>
        public string ProvincePinYin { set; get; }
        /// <summary>
        /// 市/州名称拼音
        /// </summary>
        public string CityPinYin { set; get; }
        /// <summary>
        /// 县/区名称拼音
        /// </summary>
        public string CountyPinYin { set; get; }
    }
}


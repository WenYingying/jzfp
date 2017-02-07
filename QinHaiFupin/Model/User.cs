using System;
namespace Model{

	/// <summary>
	/// 用户信息表
	/// </summary>
	public class User{
		/// <summary>
		/// 用户Id
		/// </summary>
		public long ID{set;get;}
		/// <summary>
		/// 登录名
		/// </summary>
		public string LoginName{set;get;}
		/// <summary>
		/// 密码
		/// </summary>
		public string Password{set;get;}
		/// <summary>
		/// 手机号
		/// </summary>
		public string Phone{set;get;}
		/// <summary>
		/// 姓名
		/// </summary>
		public string Name{set;get;}
		/// <summary>
		/// 省份ID
		/// </summary>
		public long ProvinceId{set;get;}
		/// <summary>
		/// 城市ID
		/// </summary>
		public long CityId{set;get;}
		/// <summary>
		/// 县Id
		/// </summary>
        /// 
		public long CountyId{set;get;}
		/// <summary>
		/// 乡Id
		/// </summary>
		public long CountrySideId{set;get;}
		/// <summary>
		/// 村（居委会）ID
		/// </summary>
		public long VillageId{set;get;}
		/// <summary>
		/// 最后登录时间
		/// </summary>
		public string LastLoginTime{set;get;}
		/// <summary>
		/// 最后登录Ip
		/// </summary>
		public string LastLoginIp{set;get;}
		/// <summary>
		/// 创建时间
		/// </summary>
		public string PostTime{set;get;}
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
		/// 乡/镇名称
		/// </summary>
		public string CountrySideName { set; get; }
        /// <summary>
        /// 村/居委会名称
        /// </summary>
        public string VillageName { set; get; }
        /// <summary>
        ///录入开始时间
        /// </summary>
        public string InputBeginTime { set; get; }
        /// <summary>
        ///录入结束时间
        /// </summary>
        public string InputEndTime { set; get; }
        /// <summary>
        ///经度
        /// </summary>
        public string Lng { set; get; }
        /// <summary>
        ///纬度
        /// </summary>
        public string Lat { set; get; }
        /// <summary>
        /// 是否允许删除添加数据
        /// </summary>
        public bool IsModify { set; get; }
    }
}

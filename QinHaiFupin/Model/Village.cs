using System;
namespace Model{

	/// <summary>
	/// </summary>
	public class Village{
		/// <summary>
		/// </summary>
		public long ID{set;get;}
		/// <summary>
		/// </summary>
		public string Name{set;get;}
		/// <summary>
		/// </summary>
		public int ProvinceID{set;get;}
		/// <summary>
		/// </summary>
		public int CityID{set;get;}
		/// <summary>
		/// </summary>
		public int CountyID{set;get;}
		/// <summary>
		/// </summary>
		public int CountrysideID{set;get;}
		/// <summary>
		/// </summary>
		public string PinYin{set;get;}
        /// <summary>
        ///  乡/镇名称
        /// </summary>
        public string CountrysideName { set; get; }
        /// <summary>
        /// 乡/镇名称拼音
        /// </summary>
        public string CountrysidePinYin { set; get; }
        /// <summary>
        /// 县/区名称
        /// </summary>
        public string CountyName { set; get; }
        /// <summary>
        ///县/区名称拼音
        /// </summary>
        public string CountyPinYin { set; get; }
        /// <summary>
        /// 市名称
        /// </summary>
        public string CityName { set; get; }
        /// <summary>
        /// 市名称拼音
        /// </summary>
        public string CityPinYin { set; get; }
    }
}

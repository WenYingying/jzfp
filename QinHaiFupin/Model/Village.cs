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
        ///  ��/������
        /// </summary>
        public string CountrysideName { set; get; }
        /// <summary>
        /// ��/������ƴ��
        /// </summary>
        public string CountrysidePinYin { set; get; }
        /// <summary>
        /// ��/������
        /// </summary>
        public string CountyName { set; get; }
        /// <summary>
        ///��/������ƴ��
        /// </summary>
        public string CountyPinYin { set; get; }
        /// <summary>
        /// ������
        /// </summary>
        public string CityName { set; get; }
        /// <summary>
        /// ������ƴ��
        /// </summary>
        public string CityPinYin { set; get; }
    }
}
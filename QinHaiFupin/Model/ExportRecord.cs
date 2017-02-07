using System;
namespace Model
{

    /// <summary>
    /// 导出记录表
    /// </summary>
    public class ExportRecord
    {
        /// <summary>
        /// 导出记录ID
        /// </summary>
        public long ID { set; get; }
        /// <summary>
        /// 批号
        /// </summary>
        public string BatchNumber { set; get; }
        /// <summary>
        /// 用户Id
        /// </summary>
        public long UserId { set; get; }
        /// <summary>
        /// 排序id
        /// </summary>
        public long SortId { set; get; }
        /// <summary>
        /// 户主ID
        /// </summary>
        public long HouseholderId { set; get; }

        /// <summary>
        /// 文件名称
        /// </summary>
        public string FileName { set; get; }
        /// <summary>
        /// 城市ID
        /// </summary>
        public long CityId { set; get; }
        /// <summary>
        /// 县Id
        /// </summary>
        public long CountyId { set; get; }
        /// <summary>
        /// 乡Id
        /// </summary>
        public long CountrySideId { set; get; }
        /// <summary>
        /// 村（居委会）ID
        /// </summary>
        public long VillageId { set; get; }
        /// <summary>
        /// 村名称
        /// </summary>
        public string VillageName { set; get; }
        /// <summary>
        /// 村名称拼音
        /// </summary>
        public string VillagePinYin { set; get; }
        /// <summary>
        ///  乡/镇名称
        /// </summary>
        public string CountrySideName { set; get; }
        /// <summary>
        /// 乡/镇名称拼音
        /// </summary>
        public string CountrySidePinYin { set; get; }
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
        /// <summary>
        /// 导出时间
        /// </summary>
        public string PostTime { set; get; }
        /// <summary>
        /// 家庭人数
        /// </summary>
        public int FamilySize { get; set; }
        /// <summary>
        /// 在校人数
        /// </summary>
        public int InSchoolCount { get; set; }
        /// <summary>
        /// 户主姓名
        /// </summary>
        public string HouseholderName { get; set; }
        /// <summary>
        /// 户主证件号
        /// </summary>
        public string HouseholderIdCardNo { get; set; }
    }
}


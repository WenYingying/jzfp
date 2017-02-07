using System;
namespace Model
{

    /// <summary>
    /// 人员档案
    /// </summary>
    public class PovertyArchives
    {
        /// <summary>
        /// 人员档案Id
        /// </summary>
        public long ID { set; get; }
        /// <summary>
        /// 姓名
        /// </summary>
        public string Name { set; get; }
        /// <summary>
        /// 性别
        /// </summary>
        public bool Gender { set; get; }
        /// <summary>
        /// 出生日期
        /// </summary>
        public string BirthDay { set; get; }
        /// <summary>
        /// 身份证号
        /// </summary>
        public string IdCardNo { set; get; }
        /// <summary>
        /// 民族
        /// </summary>
        public string Nation { set; get; }
        /// <summary>
        /// 家庭人数
        /// </summary>
        public int FamilySize { set; get; }
        /// <summary>
        /// 村/街道/社区Id
        /// </summary>
        public long VillageId { set; get; }
        /// <summary>
        /// 详细地址
        /// </summary>
        public string Address { set; get; }
        /// <summary>
        /// 与户主关系
        /// </summary>
        public string HouseholderRelation { set; get; }
        /// <summary>
        /// 文化程度
        /// </summary>
        public string EduLevels { set; get; }
        /// <summary>
        /// 在校状况
        /// </summary>
        public string StudentStatus { set; get; }
        /// <summary>
        /// 识别标准
        /// </summary>
        public string DiscerningStandards { set; get; }
        /// <summary>
        /// 贫困属性
        /// </summary>
        public string PovertyProperties { set; get; }
        /// <summary>
        /// 贫困原因
        /// </summary>
        public string PovertyReason { set; get; }
        /// <summary>
        /// 联系电话
        /// </summary>
        public string Phone { set; get; }
        /// <summary>
        /// 户主ID
        /// </summary>
        public long HouseholderId { get; set; }
        /// <summary>
        /// 是否为户主
        /// </summary>
        public bool IsHouseHolder { get; set; }

        /// <summary>
        /// 学生教育信息ID
        /// </summary>
        public long studentArchivesID { set; get; }
        /// <summary>
        /// 录入用户ID
        /// </summary>
        public long UserID { set; get; }
        /// <summary>
        /// 学号
        /// </summary>
        public string StudentNo { get; set; }
        /// <summary>
        /// 学校名称
        /// </summary>
        public string SchoolName { set; get; }
        /// <summary>
        /// 帮扶政策
        /// </summary>
        public string PolicyID { set; get; }
        /// <summary>
        /// 是否为两后生
        /// </summary>
        public bool IsLHS { get; set; }
        /// <summary>
        /// 两后生培训id
        /// </summary>
        public long LHSWorkId { set; get; }
        /// <summary>
        /// 适龄未入学原因id,用|分隔
        /// </summary>
        public string OutpreschoolReason { set; get; }
        /// <summary>
        /// 是否省内就读
        /// </summary>
        public bool IsProvinceStudy { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { set; get; }
        /// <summary>
        /// 学校性质：true 公办,false 民办
        /// </summary>
        public bool SchoolNature { set; get; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string PostTime { set; get; }
        /// <summary>
        /// 村名称
        /// </summary>
        public string VillageName { set; get; }
        /// <summary>
        /// 村名称拼音
        /// </summary>
        public string VillagePinYin { set; get; }
        /// <summary>
        /// 乡/镇ID
        /// </summary>
        public int CountrySideID { set; get; }
        /// <summary>
        ///  乡/镇名称
        /// </summary>
        public string CountrySideName { set; get; }
        /// <summary>
        /// 乡/镇名称拼音
        /// </summary>
        public string CountrySidePinYin { set; get; }
        /// <summary>
        ///县/区ID
        /// </summary>
        public int CountyID { set; get; }
        /// <summary>
        /// 县/区名称
        /// </summary>
        public string CountyName { set; get; }
        /// <summary>
        ///县/区名称拼音
        /// </summary>
        public string CountyPinYin { set; get; }
        /// <summary>
        ///市ID
        /// </summary>
        public int CityID { set; get; }
        /// <summary>
        /// 市名称
        /// </summary>
        public string CityName { set; get; }
        /// <summary>
        /// 市名称拼音
        /// </summary>
        public string CityPinYin { set; get; }
        /// <summary>
        ///省ID
        /// </summary>
        public int ProvinceID { set; get; }
        /// <summary>
        /// 省名称
        /// </summary>
        public string ProvinceName { set; get; }
        /// <summary>
        /// 省名称拼音
        /// </summary>
        public string ProvincePinYin { set; get; }
        /// <summary>
        /// 需求状态
        /// </summary>
        public int PovertyStates { set; get; }
        /// <summary>
        /// 扶贫局需求状态
        /// </summary>
        public bool HouseStates { get; set; }
        /// <summary>
        /// 在校生人数
        /// </summary>
        public int InSchoolCount { set; get; }
        /// <summary>
        /// 月份
        /// </summary>
        public int iMonth { set; get; }
        /// <summary>
        /// 辍学学段
        /// </summary>
        public string DropoutSchool { get; set; }
        /// <summary>
        /// 劝返情况（true为已返校，false为未返校）
        /// </summary>
        public bool ReturnSchool { get; set; }
        /// <summary>
        /// 教育脱贫状态
        /// </summary>
        public bool State { get; set; }
        /// <summary>
        /// 教育脱贫时间
        /// </summary>
        public string OffPovertyTime { get; set; }

    }
}


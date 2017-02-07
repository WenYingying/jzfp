using System;
namespace Model
{

    /// <summary>
    /// 学校信息表
    /// </summary>
    public class School
    {
        /// <summary>
        /// 学校编号
        /// </summary>
        public long ID { set; get; }
        /// <summary>
        /// 学校名称
        /// </summary>
        public string Name { set; get; }
        /// <summary>
        /// 学校详情
        /// </summary>
        public string Detail { set; get; }
        /// <summary>
        /// 学校性质（1 公办 0 民办）
        /// </summary>
        public bool SchoolNature { set; get; }
        /// <summary>
        /// 针对教育阶段，多个用|分隔
        /// </summary>
        public string EduLevels { set; get; }
        /// <summary>
        /// 省id
        /// </summary>
        public long ProvinceId { set; get; }
        /// <summary>
        /// 市id
        /// </summary>
        public long CityId { set; get; }
        /// <summary>
        /// 县/区id
        /// </summary>
        public long CountyId { set; get; }
        /// <summary>
        /// 乡/镇id
        /// </summary>
        public long CountrysideId { set; get; }
        /// <summary>
        /// 村id
        /// </summary>
        public long VillageId { set; get; }
        /// <summary>
        /// 详细地址
        /// </summary>
        public string Address { set; get; }
        /// <summary>
        /// 班级规模
        /// </summary>
        public int ClassSize { set; get; }
        /// <summary>
        /// 在校学生人数
        /// </summary>
        public int StuEnrollment { set; get; }
        /// <summary>
        /// 教师人数
        /// </summary>
        public int TchEnrollment { set; get; }
        /// <summary>
        /// 成立时间
        /// </summary>
        public string SetupTime { set; get; }
        /// <summary>
        /// 记录创建用户
        /// </summary>
        public long UserId { set; get; }
        /// <summary>
        /// 最后修改时间
        /// </summary>
        public string LastModifyTime { set; get; }
        /// <summary>
        /// 最后修改用户
        /// </summary>
        public long LastModifyUserId { set; get; }
        /// <summary>
        /// 记录创建时间
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
		/// 乡/镇名称
		/// </summary>
		public string CountrySideName { set; get; }
        /// <summary>
        /// 村/居委会名称
        /// </summary>
        public string VillageName { set; get; }

    }
}


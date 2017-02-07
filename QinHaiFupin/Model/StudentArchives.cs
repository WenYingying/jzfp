using System;
namespace Model
{

    /// <summary>
    /// 学生档案信息表
    /// </summary>
    public class StudentArchives
    {
        /// <summary>
        /// 学生档案信息Id
        /// </summary>
        public long ID { set; get; }
        /// <summary>
        /// </summary>
        public long UserID { set; get; }
        /// <summary>
        /// 扶贫档案ID
        /// </summary>
        public long PovertyArchivesID { set; get; }
        /// <summary>
        /// 学号
        /// </summary>
        public string StudentNo { get; set; }
        /// <summary>
        /// 学校名称
        /// </summary>
        public string SchoolName { set; get; }
        /// <summary>
        /// 帮扶政策，多个用|分隔
        /// </summary>
        public string PolicyID { set; get; }
        /// <summary>
        /// 教育阶段
        /// </summary>
        public string EduLevels { set; get; }
        /// <summary>
        /// 在校状况
        /// </summary>
        public string StudentStatus { set; get; }
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
        /// 辍学学段
        /// </summary>
        public string DropoutSchool { get; set; }
        /// <summary>
        /// 劝返情况（true为已返校，false为未返校）
        /// </summary>
        public bool ReturnSchool { get; set; }
    }
}


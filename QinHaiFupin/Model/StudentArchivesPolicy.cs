using System;
namespace Model
{

    /// <summary>
    /// 教育信息对应政策
    /// </summary>
    public class StudentArchivesPolicy
    {
        /// <summary>
        /// 教育信息对应政策id
        /// </summary>
        public long ID { set; get; }
        /// <summary>
        /// 教育信息id
        /// </summary>
        public long StudentArchivesID { set; get; }
        /// <summary>
        /// 政策id
        /// </summary>
        public long PolicyID { set; get; }
        /// <summary>
        /// 金额
        /// </summary>
        public string Amount { set; get; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public string PostTime { set; get; }
        /// <summary>
        /// 名称
        /// </summary>
        public string Name { set; get; }
        /// <summary>
        /// 简介
        /// </summary>
        public string Detail { set; get; }
        /// <summary>
        /// 教育阶段
        /// </summary>
        public string EduLevels { get; set; }
        /// <summary>
        /// 是否启用
        /// </summary>
        public bool IsEnable { get; set; }
    }
}


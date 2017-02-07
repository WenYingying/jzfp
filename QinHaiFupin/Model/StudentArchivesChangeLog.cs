using System;
namespace Model{

	/// <summary>
	/// 学生档案修改日志
	/// </summary>
	public class StudentArchivesChangeLog{
		/// <summary>
		/// 学生档案修改日志ID
		/// </summary>
		public long ID{set;get;}
		/// <summary>
		/// 学生档案Id
		/// </summary>
		public long StudentArchivesId{set;get;}
		/// <summary>
		/// 操作人员ID
		/// </summary>
		public long UserId{set;get;}
		/// <summary>
		/// 修改内容
		/// </summary>
		public string ChangeText{set;get;}
		/// <summary>
		/// 创建时间
		/// </summary>
		public string PostTime{set;get;}
	}
}

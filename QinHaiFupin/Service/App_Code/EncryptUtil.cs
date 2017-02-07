using System;
using System.Security;
using System.Security.Cryptography;
using System.Threading;
using System.IO;
using System.Text;
using System.Runtime.Serialization.Formatters.Binary;
using System.Collections;

	/// <summary>
	/// DES 的摘要说明。
	/// </summary>
public class EncryptUtil
{
    private EncryptUtil()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    /// <summary>
    /// DEC加密算法
    /// </summary>
    /// <param name="pToEncrypt"></param>
    /// <param name="sKey"></param>
    /// <returns></returns>
    private static string Encrypt(string pToEncrypt, string sKey)
    {
        DESCryptoServiceProvider des = new DESCryptoServiceProvider();  //把字符串放到byte数组中  
        byte[] inputByteArray = Encoding.Default.GetBytes(pToEncrypt);
        //byte[]  inputByteArray=Encoding.Unicode.GetBytes(pToEncrypt);  
        des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);  //建立加密对象的密钥和偏移量
        des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);   //原文使用ASCIIEncoding.ASCII方法的GetBytes方法 
        MemoryStream ms = new MemoryStream();     //使得输入密码必须输入英文文本
        CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write);
        cs.Write(inputByteArray, 0, inputByteArray.Length);
        cs.FlushFinalBlock();
        StringBuilder ret = new StringBuilder();
        foreach (byte b in ms.ToArray())
        {
            ret.AppendFormat("{0:X2}", b);
        }
        ret.ToString();
        return ret.ToString();
    }

    /// <summary>
    /// DEC 解密过程
    /// </summary>
    /// <param name="pToDecrypt"></param>
    /// <param name="sKey"></param>
    /// <returns></returns>
    private static string Decrypt(string pToDecrypt, string sKey)
    {
        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
        byte[] inputByteArray = new byte[pToDecrypt.Length / 2];
        for (int x = 0; x < pToDecrypt.Length / 2; x++)
        {
            int i = (Convert.ToInt32(pToDecrypt.Substring(x * 2, 2), 16));
            inputByteArray[x] = (byte)i;
        }
        des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);  //建立加密对象的密钥和偏移量，此值重要，不能修改  
        des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
        MemoryStream ms = new MemoryStream();
        CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write);
        cs.Write(inputByteArray, 0, inputByteArray.Length);
        cs.FlushFinalBlock();
        StringBuilder ret = new StringBuilder();  //建立StringBuild对象，CreateDecrypt使用的是流对象，必须把解密后的文本变成流对象     
        return System.Text.Encoding.Default.GetString(ms.ToArray());
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="obj"></param>
    /// <returns>token string</returns>
    public static string DesEncode(object obj, string skey)
    {
        BinaryFormatter ser = new BinaryFormatter();
        MemoryStream stream = new MemoryStream();
        ser.Serialize(stream, obj);
        byte[] binaryData = stream.GetBuffer();

        string rs = Encoding.Default.GetString(binaryData);
        return Encrypt(rs, skey);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="obj"></param>
    /// <returns>token string</returns>
    public static string DesEncode(string obj, string skey)
    {
        return Encrypt(obj, skey);
    }

    /// <summary>
    /// parse to object
    /// </summary>
    /// <param name="str">token string</param>
    /// <returns></returns>
    public static object DesDecodeObject(string str, string skey)
    {
        string rs = Decrypt(str, skey);
        byte[] binaryData = Encoding.Default.GetBytes(rs);

        BinaryFormatter ser = new BinaryFormatter();
        MemoryStream stream = new MemoryStream(binaryData);
        object obj = ser.Deserialize(stream);
        return obj;
    }

    /// <summary>
    /// parse to string
    /// </summary>
    /// <param name="str">token string</param>
    /// <returns></returns>
    public static string DesDecodeString(string str, string skey)
    {
        string rs = Decrypt(str, skey);
        return rs;
    }

    public static string Md5Encode(string str)
    {
        MD5 md5 = MD5.Create();
        byte[] data = Encoding.ASCII.GetBytes(str);
        byte[] result = md5.ComputeHash(data);
        string rs = BitConverter.ToString(result);
        return rs.Replace("-", "");
    }

    public static string ExchangeBit(string str)
    {
        byte[] s = Encoding.Default.GetBytes(str.ToCharArray());
        for (int i = 0; i < s.Length; i++)
        {
            s[i] = (byte)(((s[i] & 0x0F) << 4) + ((s[i] & 0xF0) >> 4));
        }
        return Encoding.Default.GetString(s);
    }
}

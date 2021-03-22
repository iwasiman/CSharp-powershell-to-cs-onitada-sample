using System;

namespace OnitadaSample
{
    /// <summary>
    /// PowerShellから起動されるサンプルアプリの処理スタートのクラス。
    /// </summary>
    public class Program
    {
        static void Main(string[] args)
        {
            // PowerShellから呼ぶと引数の配列が正常に渡せない場合があるので、
            // 念のためひとつの引数に結合して渡しています。
            string[] argsArray = args[0].Split(',');
            // 引数0番目：文字列
            string arg0 = argsArray[0];
            // 引数1番目：真偽値の文字列
            string arg1 = argsArray[1].ToLower();
            if (String.IsNullOrEmpty(arg0) || String.IsNullOrEmpty(arg1))
            {
                Console.WriteLine("引数不正!");
                Environment.Exit(1);
                // Mainメソッドの戻り値をvoidからintに変更、戻り値で示してもOK
                // return 1;
            }

            // リファクタリングすると C# 8.0 の switch 式に変換! (普通のswitch文でもok)
            string onitadaMsg = arg1 switch
            {
                "true" => "引数2は真で鬼のように正しい。つまり、おにただ！",
                "false" => "引数2は偽。",
                _ => "引数2は想定外。",
            };
            Console.WriteLine("引数1: " + arg0 + " " + onitadaMsg);
            Environment.Exit(0);
            // Mainメソッドの戻り値をvoidからintに変更、戻り値で示してもOK
            // return 0;
        }
    }
}
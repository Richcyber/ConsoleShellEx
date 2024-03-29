﻿#region Usings

using System.Collections.Generic;
using System.Linq;
using System.Text;

#endregion

namespace ConsoleShell.Internal
{
    internal static class ShellCommandTokenizer
    {
        public static List<List<string>> Tokenize(string commandLine)
        {
            var ret = new List<List<string>>();
            var cmd = new List<string>();
            var arg = new StringBuilder();

            var t = commandLine.Length;

            for (var i = 0; i < t; i++)
            {
                var c = commandLine[i];

                switch (c)
                {
                    case '"':
                    case '\'':
                        var end = c;

                        for (i++; i < t; i++)
                        {
                            c = commandLine[i];

                            if (c == end)
                                break;
                            arg.Append(c);
                        }
                        break;
                    case ' ':
                        if (arg.Length > 0)
                        {
                            cmd.Add(arg.ToString());                            
                            arg.Length = 0;
                        }
                        break;
                    case ';':
                        if (arg.Length > 0)
                        {
                            cmd.Add(arg.ToString());                            
                            arg.Length = 0;
                        }
                        ret.Add(cmd.ToList());
                        cmd.Clear();
                        break;
                    default:
                        arg.Append(c);
                        break;
                }
            }

            if (arg.Length > 0)
            {
                cmd.Add(arg.ToString());                
                arg.Length = 0;
            }

            if (cmd.Count > 0)
                ret.Add(cmd);

            return ret;
        }        
    }
}
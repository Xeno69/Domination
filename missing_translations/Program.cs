using Microsoft.VisualBasic;
using System;
using System.Collections.Generic;
using System.Xml.Linq;

namespace StNotTranslated {
    class Program {
        static void Main(string[] args) {
            Console.WriteLine("Not translated strings - 2020 by Xeno");
            Console.WriteLine();
            List<string> languages = new List<string>(new String[] { "Russian", "French", "Chinese", "Chinesesimp", "Japanese", "Korean", "Portuguese", "Spanish" });
            foreach (string language in languages) {
                Console.WriteLine(language);
                List<string> lines = new List<string>();

                try {
                    XDocument xdoc = XDocument.Load("..\\co30_Domination.Altis\\stringtable.xml");
                    foreach (XElement element in xdoc.Descendants("Key")) {
                        string langstr = "";
                        foreach (XElement ee in element.Descendants(language)) {
                            langstr = ee.Value;
                        }
                        string origstr = "";
                        foreach (XElement ee in element.Descendants("Original")) {
                            origstr = ee.Value;
                        }

                        if (langstr == origstr || langstr.Length == 0) {
                            lines.Add(element.Attribute("ID").Value);
                        }
                    }

                    using (System.IO.StreamWriter file = new System.IO.StreamWriter(language + ".txt")) {
                        foreach (string line in lines) {
                            file.WriteLine(line);
                        }
                    }
                } catch (Exception) {
                    Console.WriteLine("Couldn't find stringtable.xml");
                }
            }
            Console.WriteLine("Done");
        }
    }
}

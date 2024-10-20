#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
from rich import print
from rich.console import Console
from rich.syntax import Syntax

#read config file and place settings
def cat(user_input):
    file = user_input.replace("cat ", "")
    if os.path.exists(file):
        with open(file, 'r') as f:
            extension = file.split(".")[-1].lower()
            language = {
                "py": "python",
                "java": "java",
                "cpp": "cpp",
                "c": "c",
                "js": "javascript",
                "html": "html",
                "css": "css",
                "php": "php",
                "rb": "ruby",
                "swift": "swift",
                "sql": "sql",
                "json": "json",
                "xml": "xml",
                "yaml": "yaml",
                "md": "markdown",
                "sh": "bash",
                "perl": "perl",
                "lua": "lua",
                "scala": "scala",
                "r": "r",
                "matlab": "matlab",
                "powershell": "powershell",
                "vbscript": "vbscript",
                "dart": "dart",
                "groovy": "groovy",
                "objc": "objectivec",
                "erlang": "erlang",
                "haskell": "haskell",
                "lisp": "lisp",
                "prolog": "prolog",
                "tcl": "tcl",
                "vhdl": "vhdl",
                "verilog": "verilog",
                "csv": "csv",
                "ini": "ini",
                "toml": "toml",
                "dockerfile": "dockerfile",
                "graphql": "graphql",
                "apache": "apache",
                "nginx": "nginx",
                "rs": "rust",  
                "go": "go",    
            }.get(extension, None)

            if language:
                syntax = Syntax(f.read(), language, theme="monokai", line_numbers=True, background_color="default")
                print(syntax)
            else:
                print(f.read())
    else:
        print(f"file '{file}' not found.")

if __name__ == "__main__": 
    try: 
        color_f = sys.argv[1]
        cat_p = f"{os.getcwd()}/{color_f}"
    except: 
        print(f"file path not provided.")
        exit()
    cat(cat_p)



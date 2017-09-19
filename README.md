# dbdec
Brush up on Dropbox DBX decryption 
By Francesco Picasso  - April 30, 2017 - Lazarus GUI for Windows by Nanni Bassetti (www.nannibassetti.com).

This is an Open Source toolkit to brush up on the DBX files create by the Dropbox client on a Windows machine.
The Windows Dropbox client keeps its own files - user info, configuration, 'my dropbox' files sync status and even more - inside the user profile: on the Windows 7 and Windows 10 machines they reside in '\Users\%USERNAME%\AppData\Local\Dropbox\' and sub folders. Among them there are files with .DBX extension, which are the target of this post. When you take a raw look at them, you see garbage, noise... encryption is in place. DBCrack can decrypt it!
More info here: http://blog.digital-forensics.it/2017/04/brush-up-on-dropbox-dbx-decryption.html

It needs:
Python - https://www.python.org/downloads/windows/

It includes:
Python programs
SQLite Browser - https://github.com/sqlitebrowser/sqlitebrowser/
DBCrack.exe - Executable for Windows (GUI)


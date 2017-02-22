REM Script to compile the NML scripts
REM Created by: guohongliang
REM Create at 2016.4.19

REM -nc infolder outfilename namespace file1[ file2[ ...]]
D:\SVN\projects\Toolkits\trunk\NMLCompiler\bin\Debug\NMLCompiler.exe -nc D:\SVN\projects\OTMS\trunk\bin\Resources\DML\ NmlCollection.cs NDS.NMLCollection tms_0205.dml tms_0204.dml tms_0203.dml tms_0202.dml tms_0201.dml

COPY /Y D:\SVN\projects\OTMS\trunk\bin\Resources\DML\NmlCollection.cs D:\SVN\Server\NSS\trunk\NDS.NMLCollection\NmlCollection.cs

PAUSE


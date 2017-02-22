REM Script to compile the NML scripts
REM Created by: guohongliang
REM Create at 2016-04-29 10:49
REM -nc infolder outfilename namespace file1[ file2[ ...]]
E:\SVN\Toolkits\trunk\NMLCompiler\bin\Debug\NMLCompiler.exe -nc E:\SVN\OTMS\trunk\bin\Resources\ NmlCollection.cs NDS.NMLCollection NmlFilelist.txt
 
COPY /Y E:\SVN\OTMS\trunk\bin\Resources\NmlCollection.cs E:\SVN\NDS.NMLCollection\NmlCollection.cs

"%VS110COMNTOOLS%..\..\Common7\IDE\devenv.com" E:\SVN\NDS.NMLCollection\NDS.NMLCollection.csproj /Rebuild "Debug|Any CPU" /project NDS.NMLCollection
"%VS110COMNTOOLS%..\..\Common7\IDE\devenv.com" E:\SVN\NDS.NMLCollection\NDS.NMLCollection.csproj /Rebuild "Release|Any CPU" /project NDS.NMLCollection

PAUSE
@echo off

:: change setting asper your configurations such as db passwd and username 
set dbUser=root
set dbPassword="123456"
set backupDir="C:\mybackup"
set mysqldump="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe"
set mysqlDataDir="C:\ProgramData\MySQL\MySQL Server 8.0\Data"
set zip="C:\Program Files\7-Zip\7z.exe"

:: get date
for /F "tokens=2-4 delims=/ " %%i in ('date /t') do (
	set mm=%%i
	set dd=%%j
	set yy=%%k
)

if %mm%==01 set Month="Jan"
if %mm%==02 set Month="Feb"
if %mm%==03 set Month="Mar"
if %mm%==04 set Month="Apr"
if %mm%==05 set Month="May"
if %mm%==06 set Month="Jun"
if %mm%==07 set Month="Jul"
if %mm%==08 set Month="Aug"
if %mm%==09 set Month="Sep"
if %mm%==10 set Month="Oct"
if %mm%==11 set Month="Nov"
if %mm%==12 set Month="Dec"


:: here i am setting dir name if you like to add dir inside parent dir 
set dirName=%dd%_%Month%_%yy%

::To set file format with date month and year 
set fileSuffix=%dd%-%Month%-%yy%

:: if you like to create one directory inside the parent directory used echo 
echo "dirName"="%dirName%"

:: switch to the "data" folder
pushd "%mysqlDataDir%"

:: create backup folder if it doesn't exist
if not exist %backupDir%\%dirName%\   mkdir %backupDir%\%dirName%


:: here i am using --database to backup one or more database using one single line command 
:: you can change this asper your requirment 

	%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% --single-transaction --add-drop-table --databases test1 test2 test3 > %backupDir%\%dirName%\test.sql
	%zip% a -tgzip %backupDir%\%dirName%\%fileSuffix%_test.sql.gz %backupDir%\%dirName%\test.sql
	del %backupDir%\%dirName%\test.sql 
  
        

        
   

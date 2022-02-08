@echo off

:: make sure to change the settings from line 4-9
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

::set dirName=%dd%_%Month%_%yy%
set fileSuffix=%dd%-%Month%-%yy%

:: remove echo here if you like
::echo "dirName"="%dirName%"

:: switch to the "data" folder
pushd "%mysqlDataDir%"

:: create backup folder if it doesn't exist
if not exist %backupDir%\%dirName%\   mkdir %backupDir%\%dirName%



	%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% --single-transaction --add-drop-table --databases cipla_new cipla_customerdata_new cipla_trading_new > %backupDir%\%dirName%\cipla.sql
	%zip% a -tgzip %backupDir%\%dirName%\%fileSuffix%_cipla.sql.gz %backupDir%\%dirName%\cipla.sql
	del %backupDir%\%dirName%\cipla.sql 
  
        
	%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% --single-transaction --add-drop-table --databases drreddy drreddy_customerdata drreddy_trading > %backupDir%\%dirName%\drreddy.sql
	%zip% a -tgzip %backupDir%\%dirName%\%fileSuffix%_drreddy.sql.gz %backupDir%\%dirName%\drreddy.sql
	del %backupDir%\%dirName%\drreddy.sql

         
	%mysqldump% --host="localhost" --user=%dbUser% --password=%dbPassword% --single-transaction --add-drop-table --databases sharechat sharechat_contractagreement sharechat_customerdata > %backupDir%\%dirName%\sharechat.sql
	%zip% a -tgzip %backupDir%\%dirName%\%fileSuffix%_sharechat.sql.gz %backupDir%\%dirName%\sharechat.sql
	del %backupDir%\%dirName%\sharechat.sql         
            
   

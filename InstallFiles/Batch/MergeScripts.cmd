@echo off

SET "outputDir=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\InstallFiles"

::-----------------------------------------------------------------------------------------
:: DBSCOMMON
::-----------------------------------------------------------------------------------------
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBSCOMMON\statements\*.sql"
SET "newFile=ghrin001.sql"
copy %source% %outputDir%\%newFile%

::-----------------------------------------------------------------------------------------
:: DBSentp
::-----------------------------------------------------------------------------------------
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBSentp\statements\*.sql"
SET "newFile=ghrin002.sql"
copy %source% %outputDir%\%newFile%

::-----------------------------------------------------------------------------------------
:: DBShrpn
::-----------------------------------------------------------------------------------------
:: functions
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBShrpn\functions\*.sql"
SET "newFile=ghrfn003.sql"
copy %source% %outputDir%\%newFile%

:: procedures
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBShrpn\procedures\*.sql"
SET "newFile=ghrsp003.sql"
copy %source% %outputDir%\%newFile%

:: statements
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBShrpn\statements\*.sql"
SET "newFile=ghrin003.sql"
copy %source% %outputDir%\%newFile%

:: tables
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBShrpn\tables\*.sql"
SET "newFile=ghrtb003.sql"
copy %source% %outputDir%\%newFile%

:: views
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBShrpn\views\*.sql"
SET "newFile=ghrvw003.sql"
copy %source% %outputDir%\%newFile%

:: DBShrpy
::-----------------------------------------------------------------------------------------
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBShrpy\procedures\*.sql"
SET "newFile=ghrsp004.sql"
copy %source% %outputDir%\%newFile%

::-----------------------------------------------------------------------------------------
:: DBSpiqd
::-----------------------------------------------------------------------------------------
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBSpiqd\statements\*.sql"
SET "newFile=ghrin005.sql"
copy %source% %outputDir%\%newFile%

::-----------------------------------------------------------------------------------------
:: DBSpscb
::-----------------------------------------------------------------------------------------
SET "source=C:\Users\purce\OneDrive\Documents\Github\GOB-SS-INT\DBSpscb\statements\*.sql"
SET "newFile=ghrin006.sql"
copy %source% %outputDir%\%newFile%

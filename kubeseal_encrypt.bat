@ECHO OFF
SET /P usecret=Please enter secret:
IF "%usecret%"=="" GOTO Error
ECHO %usecret% > tempfile
kubeseal --raw --from-file=tempfile --namespace %1 --scope namespace-wide
del tempfile
GOTO End
:Error
ECHO You did not enter any secret!
:End
SET usecret=

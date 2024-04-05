@echo off
:menu
cls
echo.
echo 1 - SRM Homologacao
echo 2 - SRM Producao
echo 3 - TRUST Homologacao
echo 4 - TRUST Producao
echo.
set /p opcao=Escolha uma opcao (1-4) e pressione Enter:
if "%opcao%"=="1" goto SRM_HOMOLOGACAO
if "%opcao%"=="2" goto SRM_PRODUCAO
if "%opcao%"=="3" goto TRUST_HOMOLOGACAO
if "%opcao%"=="4" goto TRUST_PRODUCAO
goto menu

:SRM_HOMOLOGACAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
call flutter run --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
goto end

:SRM_PRODUCAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
call flutter run --flavor SRM_PRODUCAO -t lib/main_SRM_PRODUCAO.dart
goto end

:TRUST_HOMOLOGACAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
call flutter run --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
goto end

:TRUST_PRODUCAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
call flutter run --flavor TRUST_PRODUCAO -t lib/main_TRUST_PRODUCAO.dart
goto end

:end

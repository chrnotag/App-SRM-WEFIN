@echo off
:build_or_emulate_menu
cls
echo.
echo Escolha uma opcao (Padrao 2):
echo 1 - Buildar o projeto (APK ou IPA)
echo 2 - Emular o projeto
echo 3 - Cancelar
echo.

set /p build_or_emulate=Escolha uma opcao (1 ou 2) e pressione Enter:
if "%build_or_emulate%"=="" (
    set build_or_emulate=2
)
if "%build_or_emulate%"=="1" goto build_menu
if "%build_or_emulate%"=="2" goto emulate_menu
if "%build_or_emulate%"=="3" exit
goto build_or_emulate_menu

:build_menu
cls
echo.
echo Escolha uma opcao de build:
echo 1 - APK
echo 2 - IPA
echo 3 - Voltar
echo.

set /p build_option=Escolha uma opcao de build (1 ou 2) e pressione Enter:
if "%build_option%"=="1" goto environment_menu
if "%build_option%"=="2" goto environment_menu
if "%build_option%"=="3" goto build_or_emulate_menu
goto build_menu

:emulate_menu
cls
echo.
echo Escolha uma opcao de emulacao:
echo 1 - SRM Homologacao
echo 2 - SRM Producao
echo 3 - TRUST Homologacao
echo 4 - TRUST Producao
echo 5 - Voltar
echo.

set /p emulate_option=Escolha uma opcao de emulacao (1-4) e pressione Enter (Padrão SRM Homologacao):
if "%emulate_option%"=="" (
    set emulate_option=1
)

if "%emulate_option%"=="1" goto SRM_HOMOLOGACAO_EMULATE
if "%emulate_option%"=="2" goto SRM_PRODUCAO_EMULATE
if "%emulate_option%"=="3" goto TRUST_HOMOLOGACAO_EMULATE
if "%emulate_option%"=="4" goto TRUST_PRODUCAO_EMULATE
if "%emulate_option%"=="5" goto build_menu
goto emulate_menu

:SRM_HOMOLOGACAO_EMULATE
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
call flutter run --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
goto end

:SRM_PRODUCAO_EMULATE
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
call flutter run --flavor SRM -t lib/main_SRM.dart
goto end

:TRUST_HOMOLOGACAO_EMULATE
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
call flutter run --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
goto end

:TRUST_PRODUCAO_EMULATE
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
call flutter run --flavor TRUST -t lib/main_TRUST.dart
goto end

:environment_menu
cls
echo.
echo Escolha uma opcao de ambiente:
echo 1 - SRM Homologacao
echo 2 - SRM Producao
echo 3 - TRUST Homologacao
echo 4 - TRUST Producao
echo 5 - Voltar
echo.

set /p environment_option=Escolha uma opcao de ambiente (1-4) e pressione Enter (Padrão SRM Homologacao):
if "%environment_option%"=="" (
    set environment_option=1
)

if "%environment_option%"=="1" goto SRM_HOMOLOGACAO
if "%environment_option%"=="2" goto SRM_PRODUCAO
if "%environment_option%"=="3" goto TRUST_HOMOLOGACAO
if "%environment_option%"=="4" goto TRUST_PRODUCAO
if "%environment_option%"=="5" goto build_menu
goto environment_menu

:SRM_HOMOLOGACAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
if "%build_option%"=="1" (
    call flutter build apk --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
) else (
    call flutter build ios --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
)
goto end

:SRM_PRODUCAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
if "%build_option%"=="1" (
    call flutter build apk --flavor SRM -t lib/main_SRM.dart
) else (
    call flutter build ios --flavor SRM -t lib/main_SRM.dart
)
goto end

:TRUST_HOMOLOGACAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
if "%build_option%"=="1" (
    call flutter build apk --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
) else (
    call flutter build ios --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
)
goto end

:TRUST_PRODUCAO
call flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
call dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
if "%build_option%"=="1" (
    call flutter build apk --flavor TRUST -t lib/main_TRUST.dart
) else (
    call flutter build ios --flavor TRUST -t lib/main_TRUST.dart
)
goto end

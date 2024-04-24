#!/bin/bash

build_or_emulate_menu() {
    clear
    echo ""
    echo "Escolha uma opcao (Padrao 2):"
    echo "1 - Buildar o projeto (APK ou IPA)"
    echo "2 - Emular o projeto"
    echo "3 - Cancelar"
    echo ""

    read -p "Escolha uma opcao (1 ou 2) e pressione Enter: " build_or_emulate
    build_or_emulate=${build_or_emulate:-2}

    if [ "$build_or_emulate" == "1" ]; then
        build_menu
    elif [ "$build_or_emulate" == "2" ]; then
        emulate_menu
    elif [ "$build_or_emulate" == "3" ]; then
        exit 0
    else
        build_or_emulate_menu
    fi
}

build_menu() {
    clear
    echo ""
    echo "Escolha uma opcao de build:"
    echo "1 - APK"
    echo "2 - IPA"
    echo "3 - Voltar"
    echo ""

    read -p "Escolha uma opcao de build (1 ou 2) e pressione Enter: " build_option

    if [ "$build_option" == "1" ] || [ "$build_option" == "2" ]; then
        environment_menu
    elif [ "$build_option" == "3" ]; then
        build_or_emulate_menu
    else
        build_menu
    fi
}

emulate_menu() {
    clear
    echo ""
    echo "Escolha uma opcao de emulacao:"
    echo "1 - SRM Homologacao"
    echo "2 - SRM Producao"
    echo "3 - TRUST Homologacao"
    echo "4 - TRUST Producao"
    echo "5 - Voltar"
    echo ""

    read -p "Escolha uma opcao de emulacao (1-4) e pressione Enter (Padrão SRM Homologacao): " emulate_option
    emulate_option=${emulate_option:-1}

    case $emulate_option in
        1) SRM_HOMOLOGACAO_EMULATE ;;
        2) SRM_PRODUCAO_EMULATE ;;
        3) TRUST_HOMOLOGACAO_EMULATE ;;
        4) TRUST_PRODUCAO_EMULATE ;;
        5) build_menu ;;
        *) emulate_menu ;;
    esac
}

SRM_HOMOLOGACAO_EMULATE() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
    flutter run --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
    end
}

SRM_PRODUCAO_EMULATE() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
    flutter run --flavor SRM -t lib/main_SRM.dart
    end
}

TRUST_HOMOLOGACAO_EMULATE() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
    flutter run --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
    end
}

TRUST_PRODUCAO_EMULATE() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
    flutter run --flavor TRUST -t lib/main_TRUST.dart
    end
}

environment_menu() {
    clear
    echo ""
    echo "Escolha uma opcao de ambiente:"
    echo "1 - SRM Homologacao"
    echo "2 - SRM Producao"
    echo "3 - TRUST Homologacao"
    echo "4 - TRUST Producao"
    echo "5 - Voltar"
    echo ""

    read -p "Escolha uma opcao de ambiente (1-4) e pressione Enter (Padrão SRM Homologacao): " environment_option
    environment_option=${environment_option:-1}

    case $environment_option in
        1) SRM_HOMOLOGACAO ;;
        2) SRM_PRODUCAO ;;
        3) TRUST_HOMOLOGACAO ;;
        4) TRUST_PRODUCAO ;;
        5) build_menu ;;
        *) environment_menu ;;
    esac
}

SRM_HOMOLOGACAO() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml

    if [ "$build_option" == "1" ]; then
        flutter build apk --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
    else
        flutter build ios --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
    fi
    end
}

SRM_PRODUCAO() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml

    if [ "$build_option" == "1" ]; then
        flutter build apk --flavor SRM -t lib/main_SRM.dart
    else
        flutter build ios --flavor SRM -t lib/main_SRM.dart
    fi
    end
}

TRUST_HOMOLOGACAO() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml

    if [ "$build_option" == "1" ]; then
        flutter build apk --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
    else
        flutter build ios --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
    fi
    end
}

TRUST_PRODUCAO() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml

    if [ "$build_option" == "1" ]; then
        flutter build apk --flavor TRUST -t lib/main_TRUST.dart
    else
        flutter build ios --flavor TRUST -t lib/main_TRUST.dart
    fi
    end
}

end() {
    exit 0
}

build_or_emulate_menu
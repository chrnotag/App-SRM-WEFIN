#!/bin/bash

# Função para incrementar a versão
increment_version() {
  local version=$1
  local part=$2
  local major minor patch build

  # Separar a versão e o build number
  IFS='+' read -r version build <<< "$version"
  IFS='.' read -r major minor patch <<< "$version"

  case $part in
    major) major=$((major + 1)); minor=0; patch=0 ;;
    minor) minor=$((minor + 1)); patch=0 ;;
    patch) patch=$((patch + 1)) ;;
  esac

  # Incrementar o build number
  build=$((build + 1))

  echo "$major.$minor.$patch+$build"
}

# Função para obter a versão atual do pubspec.yaml para um flavor específico
get_current_version() {
  local flavor=$1
  grep "^version:" "$flavor.yaml" | awk '{print $2}'
}

# Função para atualizar o pubspec.yaml com a nova versão para um flavor específico
update_pubspec_version() {
  local new_version=$1
  local flavor=$2
  sed -i '' "s/^version: .*/version: $new_version/" "$flavor.yaml"
}

# Função para enviar a versão atual para o endpoint de homologação
send_version_to_homolog_endpoint() {
  local version=$1
  local sistema_operacional=$2
  local plataforma=$3

  echo "Enviando os seguintes dados para o endpoint de homologação:"
  echo "Versão: $version"
  echo "Sistema Operacional: $sistema_operacional"
  echo "Plataforma: $plataforma"

  curl -k -X POST \
    -H "Content-Type: application/json" \
    -d "{\"versao\": \"$version\", \"sistemaOperacional\": \"$sistema_operacional\", \"plataforma\": \"$plataforma\"}" \
    https://core-app-bff-homologacao.srmasset.com/core-app-bff/v1/aplicativos
}

# Função para enviar a versão atual para o endpoint de produção
send_version_to_prod_endpoint() {
  local version=$1
  local sistema_operacional=$2
  local plataforma=$3

  echo "Enviando os seguintes dados para o endpoint de produção:"
  echo "Versão: $version"
  echo "Sistema Operacional: $sistema_operacional"
  echo "Plataforma: $plataforma"

  curl -k -X POST \
    -H "Content-Type: application/json" \
    -d "{\"versao\": \"$version\", \"sistemaOperacional\": \"$sistema_operacional\", \"plataforma\": \"$plataforma\"}" \
    https://core-app-bff.srmasset.com/core-app-bff/v1/aplicativos
}

# Função para atualizar a versão no pubspec.yaml
update_version() {
  local flavor=$1
  local current_version=$(get_current_version "$flavor")
  local impact

  clear
  echo "Escolha o impacto da atualização: (versão atual: $current_version)"
  echo "1 - Major"
  echo "2 - Minor"
  echo "3 - Patch"
  echo "4 - Build Number"
  echo "5 - Não atualizar versão"
  echo "6 - Cancelar"
  echo ""

  read -p "Escolha uma opção (1-4) e pressione Enter: " impact_option
  case $impact_option in
    1) impact="major" ;;
    2) impact="minor" ;;
    3) impact="patch" ;;
    4) impact="buildnumber" ;;
    5) echo "Versão não foi alterada. Versão atual: $current_version"
      return ;;  # Sai da função sem fazer alterações
    6) end;;
    *) update_version "$flavor" ;;
  esac

  local new_version=$(increment_version "$current_version" "$impact")
  update_pubspec_version "$new_version" "$flavor"

  echo "Versão atualizada para: $new_version"
}

# Função para submeter a versão ao backend
submit_version() {
  clear
  echo ""
  echo "Escolha o ambiente para submeter a versão:"
  echo "1 - Homologação"
  echo "2 - Produção"
  echo "3 - Cancelar"
  echo ""

  read -p "Escolha uma opção (1-3) e pressione Enter: " submit_option
  case $submit_option in
    1) submit_flavor_version "homolog" ;;
    2) submit_flavor_version "prod" ;;
    3) return ;;
    *) submit_version ;;
  esac
}

# Função para submeter a versão de um flavor específico
submit_flavor_version() {
  local env=$1
  clear
  echo ""
  echo "Escolha o flavor para submeter a versão:"
  echo "1 - SRM Homologação"
  echo "2 - SRM Produção"
  echo "3 - TRUST Homologação"
  echo "4 - TRUST Produção"
  echo "5 - Voltar"
  echo ""

  read -p "Escolha uma opção (1-5) e pressione Enter: " flavor_option
  case $flavor_option in
    1) submit_to_endpoint "srm_homologacao" "$env" ;;
    2) submit_to_endpoint "srm_producao" "$env" ;;
    3) submit_to_endpoint "trust_homologacao" "$env" ;;
    4) submit_to_endpoint "trust_producao" "$env" ;;
    5) submit_version ;;
    *) submit_flavor_version "$env" ;;
  esac
}

# Função para enviar a versão ao endpoint correto baseado no flavor e ambiente
submit_to_endpoint() {
  local flavor=$1
  local env=$2
  local version=$(get_current_version "$flavor")

  # Escolher sistema operacional
  clear
  echo ""
  echo "Escolha o sistema operacional:"
  echo "1 - ANDROID"
  echo "2 - IOS"
  echo ""
  read -p "Escolha uma opção (1-2) e pressione Enter: " so_option

  local sistema_operacional
  case $so_option in
    1) sistema_operacional="ANDROID" ;;
    2) sistema_operacional="IOS" ;;
    *) submit_to_endpoint "$flavor" "$env" ;;
  esac

  local plataforma
  case $flavor in
    srm*) plataforma="SRM" ;;
    trust*) plataforma="TRUST" ;;
  esac

  if [ "$env" == "homolog" ]; then
    send_version_to_homolog_endpoint "$version" "$sistema_operacional" "$plataforma"
  elif [ "$env" == "prod" ]; then
    send_version_to_prod_endpoint "$version" "$sistema_operacional" "$plataforma"
  fi
}

build_or_emulate_menu() {
    clear
    echo ""
    echo "Escolha uma opção (Padrão 2):"
    echo "1 - Buildar o projeto (APK ou IPA)"
    echo "2 - Emular o projeto"
    echo "3 - Atualizar versão no pubspec.yaml"
    echo "4 - Submeter versão ao backend"
    echo "5 - Cancelar"
    echo ""

    read -p "Escolha uma opção (1-5) e pressione Enter: " build_or_emulate
    build_or_emulate=${build_or_emulate:-2}

    if [ "$build_or_emulate" == "1" ]; then
        build_menu
    elif [ "$build_or_emulate" == "2" ]; then
        emulate_menu
    elif [ "$build_or_emulate" == "3" ]; then
        flavor_menu update_version
    elif [ "$build_or_emulate" == "4" ]; then
        submit_version
    elif [ "$build_or_emulate" == "5" ]; then
        exit 0
    else
        build_or_emulate_menu
    fi
}

build_menu() {
    clear
    echo ""
    echo "Escolha uma opção de build:"
    echo "1 - APK"
    echo "2 - IPA"
    echo "3 - BUNDLE"
    echo "4 - Voltar"
    echo ""

    read -p "Escolha uma opção de build (1 ou 2) e pressione Enter: " build_option

    if [ "$build_option" == "1" ] || [ "$build_option" == "2" ]; then
        environment_menu
    elif [ "$build_option" == "3" ]; then
      build_bundle
    elif [ "$build_option" == "4" ]; then
        build_or_emulate_menu
    else
        build_menu
    fi
}

emulate_menu() {
    clear
    echo ""
    echo "Escolha uma opção de emulação:"
    echo "1 - SRM Homologação"
    echo "2 - SRM Produção"
    echo "3 - TRUST Homologação"
    echo "4 - TRUST Produção"
    echo "5 - Voltar"
    echo ""

    read -p "Escolha uma opção de emulação (1-4) e pressione Enter (Padrão SRM Homologação): " emulate_option
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
    flutter pub run rename setAppName --targets android --value "SRM"
    flutter run --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
    end
}

SRM_PRODUCAO_EMULATE() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
    flutter pub run rename setAppName --targets android --value "SRM"
    flutter run --flavor SRM -t lib/main_SRM.dart
    end
}

TRUST_HOMOLOGACAO_EMULATE() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
    flutter pub run rename setAppName --targets android --value "TRUST"
    flutter run --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
    end
}

TRUST_PRODUCAO_EMULATE() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
    flutter pub run rename setAppName --targets android --value "TRUST"
    flutter run --flavor TRUST -t lib/main_TRUST.dart
    end
}

environment_menu() {
    clear
    echo ""
    echo "Escolha uma opção de ambiente:"
    echo "1 - SRM Homologação"
    echo "2 - SRM Produção"
    echo "3 - TRUST Homologação"
    echo "4 - TRUST Produção"
    echo "5 - Voltar"
    echo ""

    read -p "Escolha uma opção de ambiente (1-4) e pressione Enter (Padrão SRM Homologação): " environment_option
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
        flutter pub run rename setAppName --targets android --value "SRM"
        flutter build apk --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
    else
        flutter pub run rename setAppName --targets ios --value "SRM"
        flutter pub run rename setBundleId --targets ios --value "com.srm.appsrm"
        flutter build ipa --flavor SRM_HOMOLOGACAO -t lib/main_SRM_HOMOLOGACAO.dart
    fi
    end
}

SRM_PRODUCAO() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml

    if [ "$build_option" == "1" ]; then
        flutter pub run rename setAppName --targets android --value "SRM"
        flutter build apk --flavor SRM -t lib/main_SRM.dart
    else
      update_version "SRM_PRODUCAO"
        flutter pub run rename setAppName --targets ios --value "SRM"
        flutter pub run rename setBundleId --targets ios --value "com.srm.appsrm"
        flutter build ipa --flavor SRM -t lib/main_SRM.dart
    fi
    end
}

TRUST_HOMOLOGACAO() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml

    if [ "$build_option" == "1" ]; then
        flutter pub run rename setAppName --targets android --value "TRUST"
        flutter build apk --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
    else
        flutter pub run rename setAppName --targets ios --value "TRUST"
        flutter pub run rename setBundleId --targets ios --value "com.app.apptrust"
        flutter build ipa --flavor TRUST_HOMOLOGACAO -t lib/main_TRUST_HOMOLOGACAO.dart
    fi
    end
}

TRUST_PRODUCAO() {
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml

    if [ "$build_option" == "1" ]; then
        flutter pub run rename setAppName --targets android --value "TRUST"
        flutter build apk --flavor TRUST -t lib/main_TRUST.dart
    else
      update_version "TRUST_PRODUCAO"
        flutter pub run rename setAppName --targets ios --value "TRUST"
        flutter pub run rename setBundleId --targets ios --value "com.app.apptrust"
        flutter build ipa --flavor TRUST -t lib/main_TRUST.dart
    fi
    end
}

build_bundle() {
    clear
    echo ""
    echo "Escolha uma versão:"
    echo "1 - SRM Produção"
    echo "2 - TRUST Produção"
    echo "3 - Voltar"
    echo ""

    read -p "Escolha uma versão do aplicativo para buildar: " environment_option
    environment_option=${environment_option:-1}

    case $environment_option in
        1) SRM_PRODUCAO_BUNDLE ;;
        2) TRUST_PRODUCAO_BUNDLE ;;
        3) build_menu ;;
        *) environment_menu ;;
    esac
}

SRM_PRODUCAO_BUNDLE() {
  update_version "SRM_PRODUCAO"
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_srm.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_srm.yaml
    flutter build appbundle --flavor SRM -t lib/main_SRM.dart
    end
}

TRUST_PRODUCAO_BUNDLE() {
  update_version "TRUST_PRODUCAO"
    flutter pub run flutter_launcher_icons:main -f configuracao_icone_splash_trust.yaml
    dart run flutter_native_splash:create --path=configuracao_icone_splash_trust.yaml
    flutter build appbundle --flavor TRUST -t lib/main_TRUST.dart
    end
}

flavor_menu() {
    clear
    echo ""
    echo "Escolha o flavor:"
    echo "1 - SRM Homologação"
    echo "2 - SRM Produção"
    echo "3 - TRUST Homologação"
    echo "4 - TRUST Produção"
    echo "5 - Voltar"
    echo ""

    read -p "Escolha uma opção de flavor (1-4) e pressione Enter: " flavor_option
    flavor_option=${flavor_option:-1}

    case $flavor_option in
        1) $1 "srm_homologacao" ;;
        2) $1 "srm_producao" ;;
        3) $1 "trust_homologacao" ;;
        4) $1 "trust_producao" ;;
        5) build_or_emulate_menu ;;
        *) flavor_menu "$1" ;;
    esac
}

end() {
    clear
    exit 0
}

build_or_emulate_menu

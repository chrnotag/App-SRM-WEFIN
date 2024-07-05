import '../enuns/roles_acesso_enum.dart';

extension RolesAcessoListExtensions on List<RolesAcessoEnum>? {

  bool contemRoles(List<RolesAcessoEnum> rolesNecessarias) {
    if (this == null) {
      return false;
    }
    for (var role in rolesNecessarias) {
      if (!this!.contains(role)) {
        return false;
      }
    }
    return true;
  }
}

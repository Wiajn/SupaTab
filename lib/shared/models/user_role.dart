enum UserRole {
  superAdmin,  // You — full access, cross-branch reports
  owner,       // Branch owner — sees all their owned branches
  admin,       // Branch manager — add/change drivers, all below
  salesman,    // Adjust service dates, all below
  technician,  // Add services only — no dashboard
  ;

  /// Whether this role can access a feature requiring [requiredRole]
  bool canAccess(UserRole requiredRole) {
    return index <= requiredRole.index;
  }

  String get displayName => switch (this) {
    UserRole.superAdmin => 'Super Admin',
    UserRole.owner      => 'Owner',
    UserRole.admin      => 'Manager',
    UserRole.salesman   => 'Salesman',
    UserRole.technician => 'Technician',
  };

  // Permissions
  bool get canManageDrivers       => canAccess(UserRole.admin);
  bool get canEditServiceDates    => canAccess(UserRole.salesman);
  bool get canAddService          => true;
  bool get canViewReports         => canAccess(UserRole.admin);
  bool get canViewCrossBranch     => this == UserRole.superAdmin;
  bool get canViewOwnedBranches   => this == UserRole.owner || this == UserRole.superAdmin;
  bool get canManageBranchUsers   => this == UserRole.superAdmin;
  bool get isTechnician           => this == UserRole.technician;
  bool get canSeeDashboard        => this != UserRole.technician;
}

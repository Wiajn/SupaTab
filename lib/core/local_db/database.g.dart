// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BranchesTable extends Branches with TableInfo<$BranchesTable, Branche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, city, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(Insertable<Branche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Branche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Branche(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class Branche extends DataClass implements Insertable<Branche> {
  final String id;
  final String name;
  final String city;
  final DateTime updatedAt;
  const Branche(
      {required this.id,
      required this.name,
      required this.city,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['city'] = Variable<String>(city);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      id: Value(id),
      name: Value(name),
      city: Value(city),
      updatedAt: Value(updatedAt),
    );
  }

  factory Branche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Branche(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      city: serializer.fromJson<String>(json['city']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'city': serializer.toJson<String>(city),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Branche copyWith(
          {String? id, String? name, String? city, DateTime? updatedAt}) =>
      Branche(
        id: id ?? this.id,
        name: name ?? this.name,
        city: city ?? this.city,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Branche copyWithCompanion(BranchesCompanion data) {
    return Branche(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      city: data.city.present ? data.city.value : this.city,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Branche(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, city, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branche &&
          other.id == this.id &&
          other.name == this.name &&
          other.city == this.city &&
          other.updatedAt == this.updatedAt);
}

class BranchesCompanion extends UpdateCompanion<Branche> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> city;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BranchesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.city = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchesCompanion.insert({
    required String id,
    required String name,
    required String city,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        city = Value(city),
        updatedAt = Value(updatedAt);
  static Insertable<Branche> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? city,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (city != null) 'city': city,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? city,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return BranchesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppUsersTable extends AppUsers with TableInfo<$AppUsersTable, AppUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES branches (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pinMeta = const VerificationMeta('pin');
  @override
  late final GeneratedColumn<String> pin = GeneratedColumn<String>(
      'pin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, branchId, name, email, role, pin, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_users';
  @override
  VerificationContext validateIntegrity(Insertable<AppUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('pin')) {
      context.handle(
          _pinMeta, pin.isAcceptableOrUnknown(data['pin']!, _pinMeta));
    } else if (isInserting) {
      context.missing(_pinMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      pin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AppUsersTable createAlias(String alias) {
    return $AppUsersTable(attachedDatabase, alias);
  }
}

class AppUser extends DataClass implements Insertable<AppUser> {
  final String id;
  final String branchId;
  final String name;
  final String email;
  final String role;
  final String pin;
  final bool isActive;
  final DateTime createdAt;
  const AppUser(
      {required this.id,
      required this.branchId,
      required this.name,
      required this.email,
      required this.role,
      required this.pin,
      required this.isActive,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['pin'] = Variable<String>(pin);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AppUsersCompanion toCompanion(bool nullToAbsent) {
    return AppUsersCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      email: Value(email),
      role: Value(role),
      pin: Value(pin),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUser(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      pin: serializer.fromJson<String>(json['pin']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'pin': serializer.toJson<String>(pin),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AppUser copyWith(
          {String? id,
          String? branchId,
          String? name,
          String? email,
          String? role,
          String? pin,
          bool? isActive,
          DateTime? createdAt}) =>
      AppUser(
        id: id ?? this.id,
        branchId: branchId ?? this.branchId,
        name: name ?? this.name,
        email: email ?? this.email,
        role: role ?? this.role,
        pin: pin ?? this.pin,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
      );
  AppUser copyWithCompanion(AppUsersCompanion data) {
    return AppUser(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      pin: data.pin.present ? data.pin.value : this.pin,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUser(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('pin: $pin, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, branchId, name, email, role, pin, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.email == this.email &&
          other.role == this.role &&
          other.pin == this.pin &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class AppUsersCompanion extends UpdateCompanion<AppUser> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String> email;
  final Value<String> role;
  final Value<String> pin;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AppUsersCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.pin = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUsersCompanion.insert({
    required String id,
    required String branchId,
    required String name,
    required String email,
    required String role,
    required String pin,
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        branchId = Value(branchId),
        name = Value(name),
        email = Value(email),
        role = Value(role),
        pin = Value(pin),
        createdAt = Value(createdAt);
  static Insertable<AppUser> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? pin,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (pin != null) 'pin': pin,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? branchId,
      Value<String>? name,
      Value<String>? email,
      Value<String>? role,
      Value<String>? pin,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AppUsersCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      pin: pin ?? this.pin,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (pin.present) {
      map['pin'] = Variable<String>(pin.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsersCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('pin: $pin, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES branches (id)'));
  static const VerificationMeta _licensePlateMeta =
      const VerificationMeta('licensePlate');
  @override
  late final GeneratedColumn<String> licensePlate = GeneratedColumn<String>(
      'license_plate', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
      'make', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _colourMeta = const VerificationMeta('colour');
  @override
  late final GeneratedColumn<String> colour = GeneratedColumn<String>(
      'colour', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vinMeta = const VerificationMeta('vin');
  @override
  late final GeneratedColumn<String> vin = GeneratedColumn<String>(
      'vin', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _assignedDriverIdMeta =
      const VerificationMeta('assignedDriverId');
  @override
  late final GeneratedColumn<String> assignedDriverId = GeneratedColumn<String>(
      'assigned_driver_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _licenseExpiryMeta =
      const VerificationMeta('licenseExpiry');
  @override
  late final GeneratedColumn<DateTime> licenseExpiry =
      GeneratedColumn<DateTime>('license_expiry', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncPendingMeta =
      const VerificationMeta('syncPending');
  @override
  late final GeneratedColumn<bool> syncPending = GeneratedColumn<bool>(
      'sync_pending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sync_pending" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        branchId,
        licensePlate,
        make,
        model,
        year,
        colour,
        vin,
        assignedDriverId,
        licenseExpiry,
        updatedAt,
        syncPending
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(Insertable<Vehicle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('license_plate')) {
      context.handle(
          _licensePlateMeta,
          licensePlate.isAcceptableOrUnknown(
              data['license_plate']!, _licensePlateMeta));
    } else if (isInserting) {
      context.missing(_licensePlateMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
          _makeMeta, make.isAcceptableOrUnknown(data['make']!, _makeMeta));
    } else if (isInserting) {
      context.missing(_makeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('colour')) {
      context.handle(_colourMeta,
          colour.isAcceptableOrUnknown(data['colour']!, _colourMeta));
    } else if (isInserting) {
      context.missing(_colourMeta);
    }
    if (data.containsKey('vin')) {
      context.handle(
          _vinMeta, vin.isAcceptableOrUnknown(data['vin']!, _vinMeta));
    }
    if (data.containsKey('assigned_driver_id')) {
      context.handle(
          _assignedDriverIdMeta,
          assignedDriverId.isAcceptableOrUnknown(
              data['assigned_driver_id']!, _assignedDriverIdMeta));
    }
    if (data.containsKey('license_expiry')) {
      context.handle(
          _licenseExpiryMeta,
          licenseExpiry.isAcceptableOrUnknown(
              data['license_expiry']!, _licenseExpiryMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_pending')) {
      context.handle(
          _syncPendingMeta,
          syncPending.isAcceptableOrUnknown(
              data['sync_pending']!, _syncPendingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      licensePlate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}license_plate'])!,
      make: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}make'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      colour: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}colour'])!,
      vin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vin']),
      assignedDriverId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}assigned_driver_id']),
      licenseExpiry: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}license_expiry']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncPending: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sync_pending'])!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final String id;
  final String branchId;
  final String licensePlate;
  final String make;
  final String model;
  final int year;
  final String colour;
  final String? vin;
  final String? assignedDriverId;
  final DateTime? licenseExpiry;
  final DateTime updatedAt;
  final bool syncPending;
  const Vehicle(
      {required this.id,
      required this.branchId,
      required this.licensePlate,
      required this.make,
      required this.model,
      required this.year,
      required this.colour,
      this.vin,
      this.assignedDriverId,
      this.licenseExpiry,
      required this.updatedAt,
      required this.syncPending});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['license_plate'] = Variable<String>(licensePlate);
    map['make'] = Variable<String>(make);
    map['model'] = Variable<String>(model);
    map['year'] = Variable<int>(year);
    map['colour'] = Variable<String>(colour);
    if (!nullToAbsent || vin != null) {
      map['vin'] = Variable<String>(vin);
    }
    if (!nullToAbsent || assignedDriverId != null) {
      map['assigned_driver_id'] = Variable<String>(assignedDriverId);
    }
    if (!nullToAbsent || licenseExpiry != null) {
      map['license_expiry'] = Variable<DateTime>(licenseExpiry);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_pending'] = Variable<bool>(syncPending);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      branchId: Value(branchId),
      licensePlate: Value(licensePlate),
      make: Value(make),
      model: Value(model),
      year: Value(year),
      colour: Value(colour),
      vin: vin == null && nullToAbsent ? const Value.absent() : Value(vin),
      assignedDriverId: assignedDriverId == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedDriverId),
      licenseExpiry: licenseExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseExpiry),
      updatedAt: Value(updatedAt),
      syncPending: Value(syncPending),
    );
  }

  factory Vehicle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      licensePlate: serializer.fromJson<String>(json['licensePlate']),
      make: serializer.fromJson<String>(json['make']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int>(json['year']),
      colour: serializer.fromJson<String>(json['colour']),
      vin: serializer.fromJson<String?>(json['vin']),
      assignedDriverId: serializer.fromJson<String?>(json['assignedDriverId']),
      licenseExpiry: serializer.fromJson<DateTime?>(json['licenseExpiry']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncPending: serializer.fromJson<bool>(json['syncPending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'licensePlate': serializer.toJson<String>(licensePlate),
      'make': serializer.toJson<String>(make),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int>(year),
      'colour': serializer.toJson<String>(colour),
      'vin': serializer.toJson<String?>(vin),
      'assignedDriverId': serializer.toJson<String?>(assignedDriverId),
      'licenseExpiry': serializer.toJson<DateTime?>(licenseExpiry),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncPending': serializer.toJson<bool>(syncPending),
    };
  }

  Vehicle copyWith(
          {String? id,
          String? branchId,
          String? licensePlate,
          String? make,
          String? model,
          int? year,
          String? colour,
          Value<String?> vin = const Value.absent(),
          Value<String?> assignedDriverId = const Value.absent(),
          Value<DateTime?> licenseExpiry = const Value.absent(),
          DateTime? updatedAt,
          bool? syncPending}) =>
      Vehicle(
        id: id ?? this.id,
        branchId: branchId ?? this.branchId,
        licensePlate: licensePlate ?? this.licensePlate,
        make: make ?? this.make,
        model: model ?? this.model,
        year: year ?? this.year,
        colour: colour ?? this.colour,
        vin: vin.present ? vin.value : this.vin,
        assignedDriverId: assignedDriverId.present
            ? assignedDriverId.value
            : this.assignedDriverId,
        licenseExpiry:
            licenseExpiry.present ? licenseExpiry.value : this.licenseExpiry,
        updatedAt: updatedAt ?? this.updatedAt,
        syncPending: syncPending ?? this.syncPending,
      );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      licensePlate: data.licensePlate.present
          ? data.licensePlate.value
          : this.licensePlate,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      colour: data.colour.present ? data.colour.value : this.colour,
      vin: data.vin.present ? data.vin.value : this.vin,
      assignedDriverId: data.assignedDriverId.present
          ? data.assignedDriverId.value
          : this.assignedDriverId,
      licenseExpiry: data.licenseExpiry.present
          ? data.licenseExpiry.value
          : this.licenseExpiry,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncPending:
          data.syncPending.present ? data.syncPending.value : this.syncPending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('colour: $colour, ')
          ..write('vin: $vin, ')
          ..write('assignedDriverId: $assignedDriverId, ')
          ..write('licenseExpiry: $licenseExpiry, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, branchId, licensePlate, make, model, year,
      colour, vin, assignedDriverId, licenseExpiry, updatedAt, syncPending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.licensePlate == this.licensePlate &&
          other.make == this.make &&
          other.model == this.model &&
          other.year == this.year &&
          other.colour == this.colour &&
          other.vin == this.vin &&
          other.assignedDriverId == this.assignedDriverId &&
          other.licenseExpiry == this.licenseExpiry &&
          other.updatedAt == this.updatedAt &&
          other.syncPending == this.syncPending);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> licensePlate;
  final Value<String> make;
  final Value<String> model;
  final Value<int> year;
  final Value<String> colour;
  final Value<String?> vin;
  final Value<String?> assignedDriverId;
  final Value<DateTime?> licenseExpiry;
  final Value<DateTime> updatedAt;
  final Value<bool> syncPending;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.licensePlate = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.colour = const Value.absent(),
    this.vin = const Value.absent(),
    this.assignedDriverId = const Value.absent(),
    this.licenseExpiry = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    required String id,
    required String branchId,
    required String licensePlate,
    required String make,
    required String model,
    required int year,
    required String colour,
    this.vin = const Value.absent(),
    this.assignedDriverId = const Value.absent(),
    this.licenseExpiry = const Value.absent(),
    required DateTime updatedAt,
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        branchId = Value(branchId),
        licensePlate = Value(licensePlate),
        make = Value(make),
        model = Value(model),
        year = Value(year),
        colour = Value(colour),
        updatedAt = Value(updatedAt);
  static Insertable<Vehicle> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? licensePlate,
    Expression<String>? make,
    Expression<String>? model,
    Expression<int>? year,
    Expression<String>? colour,
    Expression<String>? vin,
    Expression<String>? assignedDriverId,
    Expression<DateTime>? licenseExpiry,
    Expression<DateTime>? updatedAt,
    Expression<bool>? syncPending,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (licensePlate != null) 'license_plate': licensePlate,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (colour != null) 'colour': colour,
      if (vin != null) 'vin': vin,
      if (assignedDriverId != null) 'assigned_driver_id': assignedDriverId,
      if (licenseExpiry != null) 'license_expiry': licenseExpiry,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncPending != null) 'sync_pending': syncPending,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith(
      {Value<String>? id,
      Value<String>? branchId,
      Value<String>? licensePlate,
      Value<String>? make,
      Value<String>? model,
      Value<int>? year,
      Value<String>? colour,
      Value<String?>? vin,
      Value<String?>? assignedDriverId,
      Value<DateTime?>? licenseExpiry,
      Value<DateTime>? updatedAt,
      Value<bool>? syncPending,
      Value<int>? rowid}) {
    return VehiclesCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      licensePlate: licensePlate ?? this.licensePlate,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      colour: colour ?? this.colour,
      vin: vin ?? this.vin,
      assignedDriverId: assignedDriverId ?? this.assignedDriverId,
      licenseExpiry: licenseExpiry ?? this.licenseExpiry,
      updatedAt: updatedAt ?? this.updatedAt,
      syncPending: syncPending ?? this.syncPending,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (licensePlate.present) {
      map['license_plate'] = Variable<String>(licensePlate.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (colour.present) {
      map['colour'] = Variable<String>(colour.value);
    }
    if (vin.present) {
      map['vin'] = Variable<String>(vin.value);
    }
    if (assignedDriverId.present) {
      map['assigned_driver_id'] = Variable<String>(assignedDriverId.value);
    }
    if (licenseExpiry.present) {
      map['license_expiry'] = Variable<DateTime>(licenseExpiry.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncPending.present) {
      map['sync_pending'] = Variable<bool>(syncPending.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('licensePlate: $licensePlate, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('colour: $colour, ')
          ..write('vin: $vin, ')
          ..write('assignedDriverId: $assignedDriverId, ')
          ..write('licenseExpiry: $licenseExpiry, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncPending: $syncPending, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DriversTable extends Drivers with TableInfo<$DriversTable, Driver> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriversTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES branches (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idNumberMeta =
      const VerificationMeta('idNumber');
  @override
  late final GeneratedColumn<String> idNumber = GeneratedColumn<String>(
      'id_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _licenseNumberMeta =
      const VerificationMeta('licenseNumber');
  @override
  late final GeneratedColumn<String> licenseNumber = GeneratedColumn<String>(
      'license_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _licenseExpiryMeta =
      const VerificationMeta('licenseExpiry');
  @override
  late final GeneratedColumn<DateTime> licenseExpiry =
      GeneratedColumn<DateTime>('license_expiry', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncPendingMeta =
      const VerificationMeta('syncPending');
  @override
  late final GeneratedColumn<bool> syncPending = GeneratedColumn<bool>(
      'sync_pending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sync_pending" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        branchId,
        name,
        idNumber,
        licenseNumber,
        licenseExpiry,
        phone,
        isActive,
        updatedAt,
        syncPending
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drivers';
  @override
  VerificationContext validateIntegrity(Insertable<Driver> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('id_number')) {
      context.handle(_idNumberMeta,
          idNumber.isAcceptableOrUnknown(data['id_number']!, _idNumberMeta));
    }
    if (data.containsKey('license_number')) {
      context.handle(
          _licenseNumberMeta,
          licenseNumber.isAcceptableOrUnknown(
              data['license_number']!, _licenseNumberMeta));
    }
    if (data.containsKey('license_expiry')) {
      context.handle(
          _licenseExpiryMeta,
          licenseExpiry.isAcceptableOrUnknown(
              data['license_expiry']!, _licenseExpiryMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_pending')) {
      context.handle(
          _syncPendingMeta,
          syncPending.isAcceptableOrUnknown(
              data['sync_pending']!, _syncPendingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Driver map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Driver(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      idNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_number']),
      licenseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}license_number']),
      licenseExpiry: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}license_expiry']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncPending: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sync_pending'])!,
    );
  }

  @override
  $DriversTable createAlias(String alias) {
    return $DriversTable(attachedDatabase, alias);
  }
}

class Driver extends DataClass implements Insertable<Driver> {
  final String id;
  final String branchId;
  final String name;
  final String? idNumber;
  final String? licenseNumber;
  final DateTime? licenseExpiry;
  final String? phone;
  final bool isActive;
  final DateTime updatedAt;
  final bool syncPending;
  const Driver(
      {required this.id,
      required this.branchId,
      required this.name,
      this.idNumber,
      this.licenseNumber,
      this.licenseExpiry,
      this.phone,
      required this.isActive,
      required this.updatedAt,
      required this.syncPending});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || idNumber != null) {
      map['id_number'] = Variable<String>(idNumber);
    }
    if (!nullToAbsent || licenseNumber != null) {
      map['license_number'] = Variable<String>(licenseNumber);
    }
    if (!nullToAbsent || licenseExpiry != null) {
      map['license_expiry'] = Variable<DateTime>(licenseExpiry);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_pending'] = Variable<bool>(syncPending);
    return map;
  }

  DriversCompanion toCompanion(bool nullToAbsent) {
    return DriversCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      idNumber: idNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(idNumber),
      licenseNumber: licenseNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseNumber),
      licenseExpiry: licenseExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseExpiry),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
      syncPending: Value(syncPending),
    );
  }

  factory Driver.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Driver(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      idNumber: serializer.fromJson<String?>(json['idNumber']),
      licenseNumber: serializer.fromJson<String?>(json['licenseNumber']),
      licenseExpiry: serializer.fromJson<DateTime?>(json['licenseExpiry']),
      phone: serializer.fromJson<String?>(json['phone']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncPending: serializer.fromJson<bool>(json['syncPending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'idNumber': serializer.toJson<String?>(idNumber),
      'licenseNumber': serializer.toJson<String?>(licenseNumber),
      'licenseExpiry': serializer.toJson<DateTime?>(licenseExpiry),
      'phone': serializer.toJson<String?>(phone),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncPending': serializer.toJson<bool>(syncPending),
    };
  }

  Driver copyWith(
          {String? id,
          String? branchId,
          String? name,
          Value<String?> idNumber = const Value.absent(),
          Value<String?> licenseNumber = const Value.absent(),
          Value<DateTime?> licenseExpiry = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          bool? isActive,
          DateTime? updatedAt,
          bool? syncPending}) =>
      Driver(
        id: id ?? this.id,
        branchId: branchId ?? this.branchId,
        name: name ?? this.name,
        idNumber: idNumber.present ? idNumber.value : this.idNumber,
        licenseNumber:
            licenseNumber.present ? licenseNumber.value : this.licenseNumber,
        licenseExpiry:
            licenseExpiry.present ? licenseExpiry.value : this.licenseExpiry,
        phone: phone.present ? phone.value : this.phone,
        isActive: isActive ?? this.isActive,
        updatedAt: updatedAt ?? this.updatedAt,
        syncPending: syncPending ?? this.syncPending,
      );
  Driver copyWithCompanion(DriversCompanion data) {
    return Driver(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      idNumber: data.idNumber.present ? data.idNumber.value : this.idNumber,
      licenseNumber: data.licenseNumber.present
          ? data.licenseNumber.value
          : this.licenseNumber,
      licenseExpiry: data.licenseExpiry.present
          ? data.licenseExpiry.value
          : this.licenseExpiry,
      phone: data.phone.present ? data.phone.value : this.phone,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncPending:
          data.syncPending.present ? data.syncPending.value : this.syncPending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Driver(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('idNumber: $idNumber, ')
          ..write('licenseNumber: $licenseNumber, ')
          ..write('licenseExpiry: $licenseExpiry, ')
          ..write('phone: $phone, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, branchId, name, idNumber, licenseNumber,
      licenseExpiry, phone, isActive, updatedAt, syncPending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Driver &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.idNumber == this.idNumber &&
          other.licenseNumber == this.licenseNumber &&
          other.licenseExpiry == this.licenseExpiry &&
          other.phone == this.phone &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt &&
          other.syncPending == this.syncPending);
}

class DriversCompanion extends UpdateCompanion<Driver> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String?> idNumber;
  final Value<String?> licenseNumber;
  final Value<DateTime?> licenseExpiry;
  final Value<String?> phone;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  final Value<bool> syncPending;
  final Value<int> rowid;
  const DriversCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.licenseNumber = const Value.absent(),
    this.licenseExpiry = const Value.absent(),
    this.phone = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DriversCompanion.insert({
    required String id,
    required String branchId,
    required String name,
    this.idNumber = const Value.absent(),
    this.licenseNumber = const Value.absent(),
    this.licenseExpiry = const Value.absent(),
    this.phone = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        branchId = Value(branchId),
        name = Value(name),
        updatedAt = Value(updatedAt);
  static Insertable<Driver> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? idNumber,
    Expression<String>? licenseNumber,
    Expression<DateTime>? licenseExpiry,
    Expression<String>? phone,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
    Expression<bool>? syncPending,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (idNumber != null) 'id_number': idNumber,
      if (licenseNumber != null) 'license_number': licenseNumber,
      if (licenseExpiry != null) 'license_expiry': licenseExpiry,
      if (phone != null) 'phone': phone,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncPending != null) 'sync_pending': syncPending,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DriversCompanion copyWith(
      {Value<String>? id,
      Value<String>? branchId,
      Value<String>? name,
      Value<String?>? idNumber,
      Value<String?>? licenseNumber,
      Value<DateTime?>? licenseExpiry,
      Value<String?>? phone,
      Value<bool>? isActive,
      Value<DateTime>? updatedAt,
      Value<bool>? syncPending,
      Value<int>? rowid}) {
    return DriversCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      idNumber: idNumber ?? this.idNumber,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseExpiry: licenseExpiry ?? this.licenseExpiry,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      syncPending: syncPending ?? this.syncPending,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (idNumber.present) {
      map['id_number'] = Variable<String>(idNumber.value);
    }
    if (licenseNumber.present) {
      map['license_number'] = Variable<String>(licenseNumber.value);
    }
    if (licenseExpiry.present) {
      map['license_expiry'] = Variable<DateTime>(licenseExpiry.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncPending.present) {
      map['sync_pending'] = Variable<bool>(syncPending.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriversCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('idNumber: $idNumber, ')
          ..write('licenseNumber: $licenseNumber, ')
          ..write('licenseExpiry: $licenseExpiry, ')
          ..write('phone: $phone, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncPending: $syncPending, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceRecordsTable extends ServiceRecords
    with TableInfo<$ServiceRecordsTable, ServiceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vehicleIdMeta =
      const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
      'vehicle_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES vehicles (id)'));
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES branches (id)'));
  static const VerificationMeta _technicianIdMeta =
      const VerificationMeta('technicianId');
  @override
  late final GeneratedColumn<String> technicianId = GeneratedColumn<String>(
      'technician_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES app_users (id)'));
  static const VerificationMeta _salesmanIdMeta =
      const VerificationMeta('salesmanId');
  @override
  late final GeneratedColumn<String> salesmanId = GeneratedColumn<String>(
      'salesman_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _serviceTypeMeta =
      const VerificationMeta('serviceType');
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
      'service_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _odometerMeta =
      const VerificationMeta('odometer');
  @override
  late final GeneratedColumn<int> odometer = GeneratedColumn<int>(
      'odometer', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _serviceDateMeta =
      const VerificationMeta('serviceDate');
  @override
  late final GeneratedColumn<DateTime> serviceDate = GeneratedColumn<DateTime>(
      'service_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncPendingMeta =
      const VerificationMeta('syncPending');
  @override
  late final GeneratedColumn<bool> syncPending = GeneratedColumn<bool>(
      'sync_pending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sync_pending" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        vehicleId,
        branchId,
        technicianId,
        salesmanId,
        serviceType,
        notes,
        odometer,
        serviceDate,
        createdAt,
        syncPending
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_records';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('technician_id')) {
      context.handle(
          _technicianIdMeta,
          technicianId.isAcceptableOrUnknown(
              data['technician_id']!, _technicianIdMeta));
    } else if (isInserting) {
      context.missing(_technicianIdMeta);
    }
    if (data.containsKey('salesman_id')) {
      context.handle(
          _salesmanIdMeta,
          salesmanId.isAcceptableOrUnknown(
              data['salesman_id']!, _salesmanIdMeta));
    }
    if (data.containsKey('service_type')) {
      context.handle(
          _serviceTypeMeta,
          serviceType.isAcceptableOrUnknown(
              data['service_type']!, _serviceTypeMeta));
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('odometer')) {
      context.handle(_odometerMeta,
          odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta));
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('service_date')) {
      context.handle(
          _serviceDateMeta,
          serviceDate.isAcceptableOrUnknown(
              data['service_date']!, _serviceDateMeta));
    } else if (isInserting) {
      context.missing(_serviceDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_pending')) {
      context.handle(
          _syncPendingMeta,
          syncPending.isAcceptableOrUnknown(
              data['sync_pending']!, _syncPendingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      vehicleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      technicianId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}technician_id'])!,
      salesmanId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}salesman_id']),
      serviceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_type'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      odometer: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}odometer'])!,
      serviceDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}service_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncPending: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sync_pending'])!,
    );
  }

  @override
  $ServiceRecordsTable createAlias(String alias) {
    return $ServiceRecordsTable(attachedDatabase, alias);
  }
}

class ServiceRecord extends DataClass implements Insertable<ServiceRecord> {
  final String id;
  final String vehicleId;
  final String branchId;
  final String technicianId;
  final String? salesmanId;
  final String serviceType;
  final String? notes;
  final int odometer;
  final DateTime serviceDate;
  final DateTime createdAt;
  final bool syncPending;
  const ServiceRecord(
      {required this.id,
      required this.vehicleId,
      required this.branchId,
      required this.technicianId,
      this.salesmanId,
      required this.serviceType,
      this.notes,
      required this.odometer,
      required this.serviceDate,
      required this.createdAt,
      required this.syncPending});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['branch_id'] = Variable<String>(branchId);
    map['technician_id'] = Variable<String>(technicianId);
    if (!nullToAbsent || salesmanId != null) {
      map['salesman_id'] = Variable<String>(salesmanId);
    }
    map['service_type'] = Variable<String>(serviceType);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['odometer'] = Variable<int>(odometer);
    map['service_date'] = Variable<DateTime>(serviceDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_pending'] = Variable<bool>(syncPending);
    return map;
  }

  ServiceRecordsCompanion toCompanion(bool nullToAbsent) {
    return ServiceRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      branchId: Value(branchId),
      technicianId: Value(technicianId),
      salesmanId: salesmanId == null && nullToAbsent
          ? const Value.absent()
          : Value(salesmanId),
      serviceType: Value(serviceType),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      odometer: Value(odometer),
      serviceDate: Value(serviceDate),
      createdAt: Value(createdAt),
      syncPending: Value(syncPending),
    );
  }

  factory ServiceRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceRecord(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      technicianId: serializer.fromJson<String>(json['technicianId']),
      salesmanId: serializer.fromJson<String?>(json['salesmanId']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      notes: serializer.fromJson<String?>(json['notes']),
      odometer: serializer.fromJson<int>(json['odometer']),
      serviceDate: serializer.fromJson<DateTime>(json['serviceDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncPending: serializer.fromJson<bool>(json['syncPending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'branchId': serializer.toJson<String>(branchId),
      'technicianId': serializer.toJson<String>(technicianId),
      'salesmanId': serializer.toJson<String?>(salesmanId),
      'serviceType': serializer.toJson<String>(serviceType),
      'notes': serializer.toJson<String?>(notes),
      'odometer': serializer.toJson<int>(odometer),
      'serviceDate': serializer.toJson<DateTime>(serviceDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncPending': serializer.toJson<bool>(syncPending),
    };
  }

  ServiceRecord copyWith(
          {String? id,
          String? vehicleId,
          String? branchId,
          String? technicianId,
          Value<String?> salesmanId = const Value.absent(),
          String? serviceType,
          Value<String?> notes = const Value.absent(),
          int? odometer,
          DateTime? serviceDate,
          DateTime? createdAt,
          bool? syncPending}) =>
      ServiceRecord(
        id: id ?? this.id,
        vehicleId: vehicleId ?? this.vehicleId,
        branchId: branchId ?? this.branchId,
        technicianId: technicianId ?? this.technicianId,
        salesmanId: salesmanId.present ? salesmanId.value : this.salesmanId,
        serviceType: serviceType ?? this.serviceType,
        notes: notes.present ? notes.value : this.notes,
        odometer: odometer ?? this.odometer,
        serviceDate: serviceDate ?? this.serviceDate,
        createdAt: createdAt ?? this.createdAt,
        syncPending: syncPending ?? this.syncPending,
      );
  ServiceRecord copyWithCompanion(ServiceRecordsCompanion data) {
    return ServiceRecord(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      technicianId: data.technicianId.present
          ? data.technicianId.value
          : this.technicianId,
      salesmanId:
          data.salesmanId.present ? data.salesmanId.value : this.salesmanId,
      serviceType:
          data.serviceType.present ? data.serviceType.value : this.serviceType,
      notes: data.notes.present ? data.notes.value : this.notes,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      serviceDate:
          data.serviceDate.present ? data.serviceDate.value : this.serviceDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncPending:
          data.syncPending.present ? data.syncPending.value : this.syncPending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecord(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('branchId: $branchId, ')
          ..write('technicianId: $technicianId, ')
          ..write('salesmanId: $salesmanId, ')
          ..write('serviceType: $serviceType, ')
          ..write('notes: $notes, ')
          ..write('odometer: $odometer, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      vehicleId,
      branchId,
      technicianId,
      salesmanId,
      serviceType,
      notes,
      odometer,
      serviceDate,
      createdAt,
      syncPending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceRecord &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.branchId == this.branchId &&
          other.technicianId == this.technicianId &&
          other.salesmanId == this.salesmanId &&
          other.serviceType == this.serviceType &&
          other.notes == this.notes &&
          other.odometer == this.odometer &&
          other.serviceDate == this.serviceDate &&
          other.createdAt == this.createdAt &&
          other.syncPending == this.syncPending);
}

class ServiceRecordsCompanion extends UpdateCompanion<ServiceRecord> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> branchId;
  final Value<String> technicianId;
  final Value<String?> salesmanId;
  final Value<String> serviceType;
  final Value<String?> notes;
  final Value<int> odometer;
  final Value<DateTime> serviceDate;
  final Value<DateTime> createdAt;
  final Value<bool> syncPending;
  final Value<int> rowid;
  const ServiceRecordsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.technicianId = const Value.absent(),
    this.salesmanId = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.notes = const Value.absent(),
    this.odometer = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceRecordsCompanion.insert({
    required String id,
    required String vehicleId,
    required String branchId,
    required String technicianId,
    this.salesmanId = const Value.absent(),
    required String serviceType,
    this.notes = const Value.absent(),
    required int odometer,
    required DateTime serviceDate,
    required DateTime createdAt,
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        vehicleId = Value(vehicleId),
        branchId = Value(branchId),
        technicianId = Value(technicianId),
        serviceType = Value(serviceType),
        odometer = Value(odometer),
        serviceDate = Value(serviceDate),
        createdAt = Value(createdAt);
  static Insertable<ServiceRecord> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? branchId,
    Expression<String>? technicianId,
    Expression<String>? salesmanId,
    Expression<String>? serviceType,
    Expression<String>? notes,
    Expression<int>? odometer,
    Expression<DateTime>? serviceDate,
    Expression<DateTime>? createdAt,
    Expression<bool>? syncPending,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (branchId != null) 'branch_id': branchId,
      if (technicianId != null) 'technician_id': technicianId,
      if (salesmanId != null) 'salesman_id': salesmanId,
      if (serviceType != null) 'service_type': serviceType,
      if (notes != null) 'notes': notes,
      if (odometer != null) 'odometer': odometer,
      if (serviceDate != null) 'service_date': serviceDate,
      if (createdAt != null) 'created_at': createdAt,
      if (syncPending != null) 'sync_pending': syncPending,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? vehicleId,
      Value<String>? branchId,
      Value<String>? technicianId,
      Value<String?>? salesmanId,
      Value<String>? serviceType,
      Value<String?>? notes,
      Value<int>? odometer,
      Value<DateTime>? serviceDate,
      Value<DateTime>? createdAt,
      Value<bool>? syncPending,
      Value<int>? rowid}) {
    return ServiceRecordsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      branchId: branchId ?? this.branchId,
      technicianId: technicianId ?? this.technicianId,
      salesmanId: salesmanId ?? this.salesmanId,
      serviceType: serviceType ?? this.serviceType,
      notes: notes ?? this.notes,
      odometer: odometer ?? this.odometer,
      serviceDate: serviceDate ?? this.serviceDate,
      createdAt: createdAt ?? this.createdAt,
      syncPending: syncPending ?? this.syncPending,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (technicianId.present) {
      map['technician_id'] = Variable<String>(technicianId.value);
    }
    if (salesmanId.present) {
      map['salesman_id'] = Variable<String>(salesmanId.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<int>(odometer.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<DateTime>(serviceDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncPending.present) {
      map['sync_pending'] = Variable<bool>(syncPending.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('branchId: $branchId, ')
          ..write('technicianId: $technicianId, ')
          ..write('salesmanId: $salesmanId, ')
          ..write('serviceType: $serviceType, ')
          ..write('notes: $notes, ')
          ..write('odometer: $odometer, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncPending: $syncPending, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicePhotosTable extends ServicePhotos
    with TableInfo<$ServicePhotosTable, ServicePhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicePhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_records (id)'));
  static const VerificationMeta _photoTypeMeta =
      const VerificationMeta('photoType');
  @override
  late final GeneratedColumn<String> photoType = GeneratedColumn<String>(
      'photo_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remoteUrlMeta =
      const VerificationMeta('remoteUrl');
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
      'remote_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _takenAtMeta =
      const VerificationMeta('takenAt');
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
      'taken_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncPendingMeta =
      const VerificationMeta('syncPending');
  @override
  late final GeneratedColumn<bool> syncPending = GeneratedColumn<bool>(
      'sync_pending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sync_pending" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, serviceId, photoType, localPath, remoteUrl, takenAt, syncPending];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_photos';
  @override
  VerificationContext validateIntegrity(Insertable<ServicePhoto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('photo_type')) {
      context.handle(_photoTypeMeta,
          photoType.isAcceptableOrUnknown(data['photo_type']!, _photoTypeMeta));
    } else if (isInserting) {
      context.missing(_photoTypeMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('remote_url')) {
      context.handle(_remoteUrlMeta,
          remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta));
    }
    if (data.containsKey('taken_at')) {
      context.handle(_takenAtMeta,
          takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta));
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('sync_pending')) {
      context.handle(
          _syncPendingMeta,
          syncPending.isAcceptableOrUnknown(
              data['sync_pending']!, _syncPendingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServicePhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServicePhoto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_id'])!,
      photoType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_type'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path'])!,
      remoteUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_url']),
      takenAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}taken_at'])!,
      syncPending: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sync_pending'])!,
    );
  }

  @override
  $ServicePhotosTable createAlias(String alias) {
    return $ServicePhotosTable(attachedDatabase, alias);
  }
}

class ServicePhoto extends DataClass implements Insertable<ServicePhoto> {
  final String id;
  final String serviceId;
  final String photoType;
  final String localPath;
  final String? remoteUrl;
  final DateTime takenAt;
  final bool syncPending;
  const ServicePhoto(
      {required this.id,
      required this.serviceId,
      required this.photoType,
      required this.localPath,
      this.remoteUrl,
      required this.takenAt,
      required this.syncPending});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['service_id'] = Variable<String>(serviceId);
    map['photo_type'] = Variable<String>(photoType);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    map['taken_at'] = Variable<DateTime>(takenAt);
    map['sync_pending'] = Variable<bool>(syncPending);
    return map;
  }

  ServicePhotosCompanion toCompanion(bool nullToAbsent) {
    return ServicePhotosCompanion(
      id: Value(id),
      serviceId: Value(serviceId),
      photoType: Value(photoType),
      localPath: Value(localPath),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      takenAt: Value(takenAt),
      syncPending: Value(syncPending),
    );
  }

  factory ServicePhoto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServicePhoto(
      id: serializer.fromJson<String>(json['id']),
      serviceId: serializer.fromJson<String>(json['serviceId']),
      photoType: serializer.fromJson<String>(json['photoType']),
      localPath: serializer.fromJson<String>(json['localPath']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
      syncPending: serializer.fromJson<bool>(json['syncPending']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serviceId': serializer.toJson<String>(serviceId),
      'photoType': serializer.toJson<String>(photoType),
      'localPath': serializer.toJson<String>(localPath),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'takenAt': serializer.toJson<DateTime>(takenAt),
      'syncPending': serializer.toJson<bool>(syncPending),
    };
  }

  ServicePhoto copyWith(
          {String? id,
          String? serviceId,
          String? photoType,
          String? localPath,
          Value<String?> remoteUrl = const Value.absent(),
          DateTime? takenAt,
          bool? syncPending}) =>
      ServicePhoto(
        id: id ?? this.id,
        serviceId: serviceId ?? this.serviceId,
        photoType: photoType ?? this.photoType,
        localPath: localPath ?? this.localPath,
        remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
        takenAt: takenAt ?? this.takenAt,
        syncPending: syncPending ?? this.syncPending,
      );
  ServicePhoto copyWithCompanion(ServicePhotosCompanion data) {
    return ServicePhoto(
      id: data.id.present ? data.id.value : this.id,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      photoType: data.photoType.present ? data.photoType.value : this.photoType,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      syncPending:
          data.syncPending.present ? data.syncPending.value : this.syncPending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServicePhoto(')
          ..write('id: $id, ')
          ..write('serviceId: $serviceId, ')
          ..write('photoType: $photoType, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('takenAt: $takenAt, ')
          ..write('syncPending: $syncPending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, serviceId, photoType, localPath, remoteUrl, takenAt, syncPending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServicePhoto &&
          other.id == this.id &&
          other.serviceId == this.serviceId &&
          other.photoType == this.photoType &&
          other.localPath == this.localPath &&
          other.remoteUrl == this.remoteUrl &&
          other.takenAt == this.takenAt &&
          other.syncPending == this.syncPending);
}

class ServicePhotosCompanion extends UpdateCompanion<ServicePhoto> {
  final Value<String> id;
  final Value<String> serviceId;
  final Value<String> photoType;
  final Value<String> localPath;
  final Value<String?> remoteUrl;
  final Value<DateTime> takenAt;
  final Value<bool> syncPending;
  final Value<int> rowid;
  const ServicePhotosCompanion({
    this.id = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.photoType = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicePhotosCompanion.insert({
    required String id,
    required String serviceId,
    required String photoType,
    required String localPath,
    this.remoteUrl = const Value.absent(),
    required DateTime takenAt,
    this.syncPending = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        serviceId = Value(serviceId),
        photoType = Value(photoType),
        localPath = Value(localPath),
        takenAt = Value(takenAt);
  static Insertable<ServicePhoto> custom({
    Expression<String>? id,
    Expression<String>? serviceId,
    Expression<String>? photoType,
    Expression<String>? localPath,
    Expression<String>? remoteUrl,
    Expression<DateTime>? takenAt,
    Expression<bool>? syncPending,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serviceId != null) 'service_id': serviceId,
      if (photoType != null) 'photo_type': photoType,
      if (localPath != null) 'local_path': localPath,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (takenAt != null) 'taken_at': takenAt,
      if (syncPending != null) 'sync_pending': syncPending,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicePhotosCompanion copyWith(
      {Value<String>? id,
      Value<String>? serviceId,
      Value<String>? photoType,
      Value<String>? localPath,
      Value<String?>? remoteUrl,
      Value<DateTime>? takenAt,
      Value<bool>? syncPending,
      Value<int>? rowid}) {
    return ServicePhotosCompanion(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      photoType: photoType ?? this.photoType,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      takenAt: takenAt ?? this.takenAt,
      syncPending: syncPending ?? this.syncPending,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (photoType.present) {
      map['photo_type'] = Variable<String>(photoType.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (syncPending.present) {
      map['sync_pending'] = Variable<bool>(syncPending.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicePhotosCompanion(')
          ..write('id: $id, ')
          ..write('serviceId: $serviceId, ')
          ..write('photoType: $photoType, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('takenAt: $takenAt, ')
          ..write('syncPending: $syncPending, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncLogTable extends SyncLog with TableInfo<$SyncLogTable, SyncLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _targetTableMeta =
      const VerificationMeta('targetTable');
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
      'target_table', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordIdMeta =
      const VerificationMeta('recordId');
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
      'record_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _queuedAtMeta =
      const VerificationMeta('queuedAt');
  @override
  late final GeneratedColumn<DateTime> queuedAt = GeneratedColumn<DateTime>(
      'queued_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, targetTable, recordId, operation, queuedAt, syncedAt, errorMessage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_log';
  @override
  VerificationContext validateIntegrity(Insertable<SyncLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_table')) {
      context.handle(
          _targetTableMeta,
          targetTable.isAcceptableOrUnknown(
              data['target_table']!, _targetTableMeta));
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(_recordIdMeta,
          recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta));
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('queued_at')) {
      context.handle(_queuedAtMeta,
          queuedAt.isAcceptableOrUnknown(data['queued_at']!, _queuedAtMeta));
    } else if (isInserting) {
      context.missing(_queuedAtMeta);
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      targetTable: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_table'])!,
      recordId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}record_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      queuedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}queued_at'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
    );
  }

  @override
  $SyncLogTable createAlias(String alias) {
    return $SyncLogTable(attachedDatabase, alias);
  }
}

class SyncLogData extends DataClass implements Insertable<SyncLogData> {
  final int id;
  final String targetTable;
  final String recordId;
  final String operation;
  final DateTime queuedAt;
  final DateTime? syncedAt;
  final String? errorMessage;
  const SyncLogData(
      {required this.id,
      required this.targetTable,
      required this.recordId,
      required this.operation,
      required this.queuedAt,
      this.syncedAt,
      this.errorMessage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_table'] = Variable<String>(targetTable);
    map['record_id'] = Variable<String>(recordId);
    map['operation'] = Variable<String>(operation);
    map['queued_at'] = Variable<DateTime>(queuedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  SyncLogCompanion toCompanion(bool nullToAbsent) {
    return SyncLogCompanion(
      id: Value(id),
      targetTable: Value(targetTable),
      recordId: Value(recordId),
      operation: Value(operation),
      queuedAt: Value(queuedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory SyncLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLogData(
      id: serializer.fromJson<int>(json['id']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      recordId: serializer.fromJson<String>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      queuedAt: serializer.fromJson<DateTime>(json['queuedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetTable': serializer.toJson<String>(targetTable),
      'recordId': serializer.toJson<String>(recordId),
      'operation': serializer.toJson<String>(operation),
      'queuedAt': serializer.toJson<DateTime>(queuedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  SyncLogData copyWith(
          {int? id,
          String? targetTable,
          String? recordId,
          String? operation,
          DateTime? queuedAt,
          Value<DateTime?> syncedAt = const Value.absent(),
          Value<String?> errorMessage = const Value.absent()}) =>
      SyncLogData(
        id: id ?? this.id,
        targetTable: targetTable ?? this.targetTable,
        recordId: recordId ?? this.recordId,
        operation: operation ?? this.operation,
        queuedAt: queuedAt ?? this.queuedAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
      );
  SyncLogData copyWithCompanion(SyncLogCompanion data) {
    return SyncLogData(
      id: data.id.present ? data.id.value : this.id,
      targetTable:
          data.targetTable.present ? data.targetTable.value : this.targetTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      queuedAt: data.queuedAt.present ? data.queuedAt.value : this.queuedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogData(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, targetTable, recordId, operation, queuedAt, syncedAt, errorMessage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLogData &&
          other.id == this.id &&
          other.targetTable == this.targetTable &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.queuedAt == this.queuedAt &&
          other.syncedAt == this.syncedAt &&
          other.errorMessage == this.errorMessage);
}

class SyncLogCompanion extends UpdateCompanion<SyncLogData> {
  final Value<int> id;
  final Value<String> targetTable;
  final Value<String> recordId;
  final Value<String> operation;
  final Value<DateTime> queuedAt;
  final Value<DateTime?> syncedAt;
  final Value<String?> errorMessage;
  const SyncLogCompanion({
    this.id = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.queuedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  });
  SyncLogCompanion.insert({
    this.id = const Value.absent(),
    required String targetTable,
    required String recordId,
    required String operation,
    required DateTime queuedAt,
    this.syncedAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  })  : targetTable = Value(targetTable),
        recordId = Value(recordId),
        operation = Value(operation),
        queuedAt = Value(queuedAt);
  static Insertable<SyncLogData> custom({
    Expression<int>? id,
    Expression<String>? targetTable,
    Expression<String>? recordId,
    Expression<String>? operation,
    Expression<DateTime>? queuedAt,
    Expression<DateTime>? syncedAt,
    Expression<String>? errorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetTable != null) 'target_table': targetTable,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (queuedAt != null) 'queued_at': queuedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }

  SyncLogCompanion copyWith(
      {Value<int>? id,
      Value<String>? targetTable,
      Value<String>? recordId,
      Value<String>? operation,
      Value<DateTime>? queuedAt,
      Value<DateTime?>? syncedAt,
      Value<String?>? errorMessage}) {
    return SyncLogCompanion(
      id: id ?? this.id,
      targetTable: targetTable ?? this.targetTable,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      queuedAt: queuedAt ?? this.queuedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (queuedAt.present) {
      map['queued_at'] = Variable<DateTime>(queuedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogCompanion(')
          ..write('id: $id, ')
          ..write('targetTable: $targetTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('queuedAt: $queuedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BranchesTable branches = $BranchesTable(this);
  late final $AppUsersTable appUsers = $AppUsersTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $DriversTable drivers = $DriversTable(this);
  late final $ServiceRecordsTable serviceRecords = $ServiceRecordsTable(this);
  late final $ServicePhotosTable servicePhotos = $ServicePhotosTable(this);
  late final $SyncLogTable syncLog = $SyncLogTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        branches,
        appUsers,
        vehicles,
        drivers,
        serviceRecords,
        servicePhotos,
        syncLog
      ];
}

typedef $$BranchesTableCreateCompanionBuilder = BranchesCompanion Function({
  required String id,
  required String name,
  required String city,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BranchesTableUpdateCompanionBuilder = BranchesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> city,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$BranchesTableReferences
    extends BaseReferences<_$AppDatabase, $BranchesTable, Branche> {
  $$BranchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AppUsersTable, List<AppUser>> _appUsersRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.appUsers,
          aliasName:
              $_aliasNameGenerator(db.branches.id, db.appUsers.branchId));

  $$AppUsersTableProcessedTableManager get appUsersRefs {
    final manager = $$AppUsersTableTableManager($_db, $_db.appUsers)
        .filter((f) => f.branchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_appUsersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$VehiclesTable, List<Vehicle>> _vehiclesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.vehicles,
          aliasName:
              $_aliasNameGenerator(db.branches.id, db.vehicles.branchId));

  $$VehiclesTableProcessedTableManager get vehiclesRefs {
    final manager = $$VehiclesTableTableManager($_db, $_db.vehicles)
        .filter((f) => f.branchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_vehiclesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$DriversTable, List<Driver>> _driversRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.drivers,
          aliasName: $_aliasNameGenerator(db.branches.id, db.drivers.branchId));

  $$DriversTableProcessedTableManager get driversRefs {
    final manager = $$DriversTableTableManager($_db, $_db.drivers)
        .filter((f) => f.branchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_driversRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecord>>
      _serviceRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.serviceRecords,
              aliasName: $_aliasNameGenerator(
                  db.branches.id, db.serviceRecords.branchId));

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager($_db, $_db.serviceRecords)
        .filter((f) => f.branchId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> appUsersRefs(
      Expression<bool> Function($$AppUsersTableFilterComposer f) f) {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.appUsers,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppUsersTableFilterComposer(
              $db: $db,
              $table: $db.appUsers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> vehiclesRefs(
      Expression<bool> Function($$VehiclesTableFilterComposer f) f) {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableFilterComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> driversRefs(
      Expression<bool> Function($$DriversTableFilterComposer f) f) {
    final $$DriversTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drivers,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DriversTableFilterComposer(
              $db: $db,
              $table: $db.drivers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> serviceRecordsRefs(
      Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableFilterComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> appUsersRefs<T extends Object>(
      Expression<T> Function($$AppUsersTableAnnotationComposer a) f) {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.appUsers,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppUsersTableAnnotationComposer(
              $db: $db,
              $table: $db.appUsers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> vehiclesRefs<T extends Object>(
      Expression<T> Function($$VehiclesTableAnnotationComposer a) f) {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableAnnotationComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> driversRefs<T extends Object>(
      Expression<T> Function($$DriversTableAnnotationComposer a) f) {
    final $$DriversTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.drivers,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DriversTableAnnotationComposer(
              $db: $db,
              $table: $db.drivers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
      Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.branchId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BranchesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BranchesTable,
    Branche,
    $$BranchesTableFilterComposer,
    $$BranchesTableOrderingComposer,
    $$BranchesTableAnnotationComposer,
    $$BranchesTableCreateCompanionBuilder,
    $$BranchesTableUpdateCompanionBuilder,
    (Branche, $$BranchesTableReferences),
    Branche,
    PrefetchHooks Function(
        {bool appUsersRefs,
        bool vehiclesRefs,
        bool driversRefs,
        bool serviceRecordsRefs})> {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BranchesCompanion(
            id: id,
            name: name,
            city: city,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String city,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BranchesCompanion.insert(
            id: id,
            name: name,
            city: city,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BranchesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {appUsersRefs = false,
              vehiclesRefs = false,
              driversRefs = false,
              serviceRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (appUsersRefs) db.appUsers,
                if (vehiclesRefs) db.vehicles,
                if (driversRefs) db.drivers,
                if (serviceRecordsRefs) db.serviceRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (appUsersRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BranchesTableReferences._appUsersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BranchesTableReferences(db, table, p0)
                                .appUsersRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.branchId == item.id),
                        typedResults: items),
                  if (vehiclesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BranchesTableReferences._vehiclesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BranchesTableReferences(db, table, p0)
                                .vehiclesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.branchId == item.id),
                        typedResults: items),
                  if (driversRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$BranchesTableReferences._driversRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BranchesTableReferences(db, table, p0)
                                .driversRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.branchId == item.id),
                        typedResults: items),
                  if (serviceRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$BranchesTableReferences
                            ._serviceRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BranchesTableReferences(db, table, p0)
                                .serviceRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.branchId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BranchesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BranchesTable,
    Branche,
    $$BranchesTableFilterComposer,
    $$BranchesTableOrderingComposer,
    $$BranchesTableAnnotationComposer,
    $$BranchesTableCreateCompanionBuilder,
    $$BranchesTableUpdateCompanionBuilder,
    (Branche, $$BranchesTableReferences),
    Branche,
    PrefetchHooks Function(
        {bool appUsersRefs,
        bool vehiclesRefs,
        bool driversRefs,
        bool serviceRecordsRefs})>;
typedef $$AppUsersTableCreateCompanionBuilder = AppUsersCompanion Function({
  required String id,
  required String branchId,
  required String name,
  required String email,
  required String role,
  required String pin,
  Value<bool> isActive,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AppUsersTableUpdateCompanionBuilder = AppUsersCompanion Function({
  Value<String> id,
  Value<String> branchId,
  Value<String> name,
  Value<String> email,
  Value<String> role,
  Value<String> pin,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$AppUsersTableReferences
    extends BaseReferences<_$AppDatabase, $AppUsersTable, AppUser> {
  $$AppUsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) => db.branches
      .createAlias($_aliasNameGenerator(db.appUsers.branchId, db.branches.id));

  $$BranchesTableProcessedTableManager? get branchId {
    if ($_item.branchId == null) return null;
    final manager = $$BranchesTableTableManager($_db, $_db.branches)
        .filter((f) => f.id($_item.branchId!));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecord>>
      _serviceRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.serviceRecords,
              aliasName: $_aliasNameGenerator(
                  db.appUsers.id, db.serviceRecords.technicianId));

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager($_db, $_db.serviceRecords)
        .filter((f) => f.technicianId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AppUsersTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pin => $composableBuilder(
      column: $table.pin, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableFilterComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> serviceRecordsRefs(
      Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.technicianId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableFilterComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AppUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pin => $composableBuilder(
      column: $table.pin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableOrderingComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AppUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get pin =>
      $composableBuilder(column: $table.pin, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableAnnotationComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
      Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.technicianId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AppUsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppUsersTable,
    AppUser,
    $$AppUsersTableFilterComposer,
    $$AppUsersTableOrderingComposer,
    $$AppUsersTableAnnotationComposer,
    $$AppUsersTableCreateCompanionBuilder,
    $$AppUsersTableUpdateCompanionBuilder,
    (AppUser, $$AppUsersTableReferences),
    AppUser,
    PrefetchHooks Function({bool branchId, bool serviceRecordsRefs})> {
  $$AppUsersTableTableManager(_$AppDatabase db, $AppUsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> pin = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUsersCompanion(
            id: id,
            branchId: branchId,
            name: name,
            email: email,
            role: role,
            pin: pin,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String branchId,
            required String name,
            required String email,
            required String role,
            required String pin,
            Value<bool> isActive = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppUsersCompanion.insert(
            id: id,
            branchId: branchId,
            name: name,
            email: email,
            role: role,
            pin: pin,
            isActive: isActive,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AppUsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {branchId = false, serviceRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (serviceRecordsRefs) db.serviceRecords
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (branchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.branchId,
                    referencedTable:
                        $$AppUsersTableReferences._branchIdTable(db),
                    referencedColumn:
                        $$AppUsersTableReferences._branchIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (serviceRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AppUsersTableReferences
                            ._serviceRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AppUsersTableReferences(db, table, p0)
                                .serviceRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.technicianId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AppUsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppUsersTable,
    AppUser,
    $$AppUsersTableFilterComposer,
    $$AppUsersTableOrderingComposer,
    $$AppUsersTableAnnotationComposer,
    $$AppUsersTableCreateCompanionBuilder,
    $$AppUsersTableUpdateCompanionBuilder,
    (AppUser, $$AppUsersTableReferences),
    AppUser,
    PrefetchHooks Function({bool branchId, bool serviceRecordsRefs})>;
typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  required String id,
  required String branchId,
  required String licensePlate,
  required String make,
  required String model,
  required int year,
  required String colour,
  Value<String?> vin,
  Value<String?> assignedDriverId,
  Value<DateTime?> licenseExpiry,
  required DateTime updatedAt,
  Value<bool> syncPending,
  Value<int> rowid,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<String> id,
  Value<String> branchId,
  Value<String> licensePlate,
  Value<String> make,
  Value<String> model,
  Value<int> year,
  Value<String> colour,
  Value<String?> vin,
  Value<String?> assignedDriverId,
  Value<DateTime?> licenseExpiry,
  Value<DateTime> updatedAt,
  Value<bool> syncPending,
  Value<int> rowid,
});

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) => db.branches
      .createAlias($_aliasNameGenerator(db.vehicles.branchId, db.branches.id));

  $$BranchesTableProcessedTableManager? get branchId {
    if ($_item.branchId == null) return null;
    final manager = $$BranchesTableTableManager($_db, $_db.branches)
        .filter((f) => f.id($_item.branchId!));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ServiceRecordsTable, List<ServiceRecord>>
      _serviceRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.serviceRecords,
              aliasName: $_aliasNameGenerator(
                  db.vehicles.id, db.serviceRecords.vehicleId));

  $$ServiceRecordsTableProcessedTableManager get serviceRecordsRefs {
    final manager = $$ServiceRecordsTableTableManager($_db, $_db.serviceRecords)
        .filter((f) => f.vehicleId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_serviceRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get licensePlate => $composableBuilder(
      column: $table.licensePlate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get make => $composableBuilder(
      column: $table.make, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colour => $composableBuilder(
      column: $table.colour, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vin => $composableBuilder(
      column: $table.vin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assignedDriverId => $composableBuilder(
      column: $table.assignedDriverId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get licenseExpiry => $composableBuilder(
      column: $table.licenseExpiry, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnFilters(column));

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableFilterComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> serviceRecordsRefs(
      Expression<bool> Function($$ServiceRecordsTableFilterComposer f) f) {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.vehicleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableFilterComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get licensePlate => $composableBuilder(
      column: $table.licensePlate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get make => $composableBuilder(
      column: $table.make, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colour => $composableBuilder(
      column: $table.colour, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vin => $composableBuilder(
      column: $table.vin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assignedDriverId => $composableBuilder(
      column: $table.assignedDriverId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get licenseExpiry => $composableBuilder(
      column: $table.licenseExpiry,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnOrderings(column));

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableOrderingComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get licensePlate => $composableBuilder(
      column: $table.licensePlate, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get colour =>
      $composableBuilder(column: $table.colour, builder: (column) => column);

  GeneratedColumn<String> get vin =>
      $composableBuilder(column: $table.vin, builder: (column) => column);

  GeneratedColumn<String> get assignedDriverId => $composableBuilder(
      column: $table.assignedDriverId, builder: (column) => column);

  GeneratedColumn<DateTime> get licenseExpiry => $composableBuilder(
      column: $table.licenseExpiry, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableAnnotationComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> serviceRecordsRefs<T extends Object>(
      Expression<T> Function($$ServiceRecordsTableAnnotationComposer a) f) {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.vehicleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VehiclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, $$VehiclesTableReferences),
    Vehicle,
    PrefetchHooks Function({bool branchId, bool serviceRecordsRefs})> {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> licensePlate = const Value.absent(),
            Value<String> make = const Value.absent(),
            Value<String> model = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<String> colour = const Value.absent(),
            Value<String?> vin = const Value.absent(),
            Value<String?> assignedDriverId = const Value.absent(),
            Value<DateTime?> licenseExpiry = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesCompanion(
            id: id,
            branchId: branchId,
            licensePlate: licensePlate,
            make: make,
            model: model,
            year: year,
            colour: colour,
            vin: vin,
            assignedDriverId: assignedDriverId,
            licenseExpiry: licenseExpiry,
            updatedAt: updatedAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String branchId,
            required String licensePlate,
            required String make,
            required String model,
            required int year,
            required String colour,
            Value<String?> vin = const Value.absent(),
            Value<String?> assignedDriverId = const Value.absent(),
            Value<DateTime?> licenseExpiry = const Value.absent(),
            required DateTime updatedAt,
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesCompanion.insert(
            id: id,
            branchId: branchId,
            licensePlate: licensePlate,
            make: make,
            model: model,
            year: year,
            colour: colour,
            vin: vin,
            assignedDriverId: assignedDriverId,
            licenseExpiry: licenseExpiry,
            updatedAt: updatedAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VehiclesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {branchId = false, serviceRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (serviceRecordsRefs) db.serviceRecords
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (branchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.branchId,
                    referencedTable:
                        $$VehiclesTableReferences._branchIdTable(db),
                    referencedColumn:
                        $$VehiclesTableReferences._branchIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (serviceRecordsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$VehiclesTableReferences
                            ._serviceRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VehiclesTableReferences(db, table, p0)
                                .serviceRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.vehicleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VehiclesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, $$VehiclesTableReferences),
    Vehicle,
    PrefetchHooks Function({bool branchId, bool serviceRecordsRefs})>;
typedef $$DriversTableCreateCompanionBuilder = DriversCompanion Function({
  required String id,
  required String branchId,
  required String name,
  Value<String?> idNumber,
  Value<String?> licenseNumber,
  Value<DateTime?> licenseExpiry,
  Value<String?> phone,
  Value<bool> isActive,
  required DateTime updatedAt,
  Value<bool> syncPending,
  Value<int> rowid,
});
typedef $$DriversTableUpdateCompanionBuilder = DriversCompanion Function({
  Value<String> id,
  Value<String> branchId,
  Value<String> name,
  Value<String?> idNumber,
  Value<String?> licenseNumber,
  Value<DateTime?> licenseExpiry,
  Value<String?> phone,
  Value<bool> isActive,
  Value<DateTime> updatedAt,
  Value<bool> syncPending,
  Value<int> rowid,
});

final class $$DriversTableReferences
    extends BaseReferences<_$AppDatabase, $DriversTable, Driver> {
  $$DriversTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) => db.branches
      .createAlias($_aliasNameGenerator(db.drivers.branchId, db.branches.id));

  $$BranchesTableProcessedTableManager? get branchId {
    if ($_item.branchId == null) return null;
    final manager = $$BranchesTableTableManager($_db, $_db.branches)
        .filter((f) => f.id($_item.branchId!));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DriversTableFilterComposer
    extends Composer<_$AppDatabase, $DriversTable> {
  $$DriversTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get idNumber => $composableBuilder(
      column: $table.idNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get licenseNumber => $composableBuilder(
      column: $table.licenseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get licenseExpiry => $composableBuilder(
      column: $table.licenseExpiry, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnFilters(column));

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableFilterComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DriversTableOrderingComposer
    extends Composer<_$AppDatabase, $DriversTable> {
  $$DriversTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get idNumber => $composableBuilder(
      column: $table.idNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get licenseNumber => $composableBuilder(
      column: $table.licenseNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get licenseExpiry => $composableBuilder(
      column: $table.licenseExpiry,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnOrderings(column));

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableOrderingComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DriversTableAnnotationComposer
    extends Composer<_$AppDatabase, $DriversTable> {
  $$DriversTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get idNumber =>
      $composableBuilder(column: $table.idNumber, builder: (column) => column);

  GeneratedColumn<String> get licenseNumber => $composableBuilder(
      column: $table.licenseNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get licenseExpiry => $composableBuilder(
      column: $table.licenseExpiry, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableAnnotationComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DriversTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DriversTable,
    Driver,
    $$DriversTableFilterComposer,
    $$DriversTableOrderingComposer,
    $$DriversTableAnnotationComposer,
    $$DriversTableCreateCompanionBuilder,
    $$DriversTableUpdateCompanionBuilder,
    (Driver, $$DriversTableReferences),
    Driver,
    PrefetchHooks Function({bool branchId})> {
  $$DriversTableTableManager(_$AppDatabase db, $DriversTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DriversTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DriversTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DriversTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> idNumber = const Value.absent(),
            Value<String?> licenseNumber = const Value.absent(),
            Value<DateTime?> licenseExpiry = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DriversCompanion(
            id: id,
            branchId: branchId,
            name: name,
            idNumber: idNumber,
            licenseNumber: licenseNumber,
            licenseExpiry: licenseExpiry,
            phone: phone,
            isActive: isActive,
            updatedAt: updatedAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String branchId,
            required String name,
            Value<String?> idNumber = const Value.absent(),
            Value<String?> licenseNumber = const Value.absent(),
            Value<DateTime?> licenseExpiry = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required DateTime updatedAt,
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DriversCompanion.insert(
            id: id,
            branchId: branchId,
            name: name,
            idNumber: idNumber,
            licenseNumber: licenseNumber,
            licenseExpiry: licenseExpiry,
            phone: phone,
            isActive: isActive,
            updatedAt: updatedAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DriversTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (branchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.branchId,
                    referencedTable:
                        $$DriversTableReferences._branchIdTable(db),
                    referencedColumn:
                        $$DriversTableReferences._branchIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DriversTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DriversTable,
    Driver,
    $$DriversTableFilterComposer,
    $$DriversTableOrderingComposer,
    $$DriversTableAnnotationComposer,
    $$DriversTableCreateCompanionBuilder,
    $$DriversTableUpdateCompanionBuilder,
    (Driver, $$DriversTableReferences),
    Driver,
    PrefetchHooks Function({bool branchId})>;
typedef $$ServiceRecordsTableCreateCompanionBuilder = ServiceRecordsCompanion
    Function({
  required String id,
  required String vehicleId,
  required String branchId,
  required String technicianId,
  Value<String?> salesmanId,
  required String serviceType,
  Value<String?> notes,
  required int odometer,
  required DateTime serviceDate,
  required DateTime createdAt,
  Value<bool> syncPending,
  Value<int> rowid,
});
typedef $$ServiceRecordsTableUpdateCompanionBuilder = ServiceRecordsCompanion
    Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<String> branchId,
  Value<String> technicianId,
  Value<String?> salesmanId,
  Value<String> serviceType,
  Value<String?> notes,
  Value<int> odometer,
  Value<DateTime> serviceDate,
  Value<DateTime> createdAt,
  Value<bool> syncPending,
  Value<int> rowid,
});

final class $$ServiceRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $ServiceRecordsTable, ServiceRecord> {
  $$ServiceRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias(
          $_aliasNameGenerator(db.serviceRecords.vehicleId, db.vehicles.id));

  $$VehiclesTableProcessedTableManager? get vehicleId {
    if ($_item.vehicleId == null) return null;
    final manager = $$VehiclesTableTableManager($_db, $_db.vehicles)
        .filter((f) => f.id($_item.vehicleId!));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias(
          $_aliasNameGenerator(db.serviceRecords.branchId, db.branches.id));

  $$BranchesTableProcessedTableManager? get branchId {
    if ($_item.branchId == null) return null;
    final manager = $$BranchesTableTableManager($_db, $_db.branches)
        .filter((f) => f.id($_item.branchId!));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AppUsersTable _technicianIdTable(_$AppDatabase db) =>
      db.appUsers.createAlias(
          $_aliasNameGenerator(db.serviceRecords.technicianId, db.appUsers.id));

  $$AppUsersTableProcessedTableManager? get technicianId {
    if ($_item.technicianId == null) return null;
    final manager = $$AppUsersTableTableManager($_db, $_db.appUsers)
        .filter((f) => f.id($_item.technicianId!));
    final item = $_typedResult.readTableOrNull(_technicianIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ServicePhotosTable, List<ServicePhoto>>
      _servicePhotosRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.servicePhotos,
              aliasName: $_aliasNameGenerator(
                  db.serviceRecords.id, db.servicePhotos.serviceId));

  $$ServicePhotosTableProcessedTableManager get servicePhotosRefs {
    final manager = $$ServicePhotosTableTableManager($_db, $_db.servicePhotos)
        .filter((f) => f.serviceId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_servicePhotosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ServiceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get salesmanId => $composableBuilder(
      column: $table.salesmanId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get odometer => $composableBuilder(
      column: $table.odometer, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get serviceDate => $composableBuilder(
      column: $table.serviceDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnFilters(column));

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleId,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableFilterComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableFilterComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AppUsersTableFilterComposer get technicianId {
    final $$AppUsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.technicianId,
        referencedTable: $db.appUsers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppUsersTableFilterComposer(
              $db: $db,
              $table: $db.appUsers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> servicePhotosRefs(
      Expression<bool> Function($$ServicePhotosTableFilterComposer f) f) {
    final $$ServicePhotosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.servicePhotos,
        getReferencedColumn: (t) => t.serviceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicePhotosTableFilterComposer(
              $db: $db,
              $table: $db.servicePhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ServiceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get salesmanId => $composableBuilder(
      column: $table.salesmanId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get odometer => $composableBuilder(
      column: $table.odometer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get serviceDate => $composableBuilder(
      column: $table.serviceDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnOrderings(column));

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleId,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableOrderingComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableOrderingComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AppUsersTableOrderingComposer get technicianId {
    final $$AppUsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.technicianId,
        referencedTable: $db.appUsers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppUsersTableOrderingComposer(
              $db: $db,
              $table: $db.appUsers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ServiceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceRecordsTable> {
  $$ServiceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get salesmanId => $composableBuilder(
      column: $table.salesmanId, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<DateTime> get serviceDate => $composableBuilder(
      column: $table.serviceDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vehicleId,
        referencedTable: $db.vehicles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VehiclesTableAnnotationComposer(
              $db: $db,
              $table: $db.vehicles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.branchId,
        referencedTable: $db.branches,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BranchesTableAnnotationComposer(
              $db: $db,
              $table: $db.branches,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AppUsersTableAnnotationComposer get technicianId {
    final $$AppUsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.technicianId,
        referencedTable: $db.appUsers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AppUsersTableAnnotationComposer(
              $db: $db,
              $table: $db.appUsers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> servicePhotosRefs<T extends Object>(
      Expression<T> Function($$ServicePhotosTableAnnotationComposer a) f) {
    final $$ServicePhotosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.servicePhotos,
        getReferencedColumn: (t) => t.serviceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServicePhotosTableAnnotationComposer(
              $db: $db,
              $table: $db.servicePhotos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ServiceRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServiceRecordsTable,
    ServiceRecord,
    $$ServiceRecordsTableFilterComposer,
    $$ServiceRecordsTableOrderingComposer,
    $$ServiceRecordsTableAnnotationComposer,
    $$ServiceRecordsTableCreateCompanionBuilder,
    $$ServiceRecordsTableUpdateCompanionBuilder,
    (ServiceRecord, $$ServiceRecordsTableReferences),
    ServiceRecord,
    PrefetchHooks Function(
        {bool vehicleId,
        bool branchId,
        bool technicianId,
        bool servicePhotosRefs})> {
  $$ServiceRecordsTableTableManager(
      _$AppDatabase db, $ServiceRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> vehicleId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> technicianId = const Value.absent(),
            Value<String?> salesmanId = const Value.absent(),
            Value<String> serviceType = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> odometer = const Value.absent(),
            Value<DateTime> serviceDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ServiceRecordsCompanion(
            id: id,
            vehicleId: vehicleId,
            branchId: branchId,
            technicianId: technicianId,
            salesmanId: salesmanId,
            serviceType: serviceType,
            notes: notes,
            odometer: odometer,
            serviceDate: serviceDate,
            createdAt: createdAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String vehicleId,
            required String branchId,
            required String technicianId,
            Value<String?> salesmanId = const Value.absent(),
            required String serviceType,
            Value<String?> notes = const Value.absent(),
            required int odometer,
            required DateTime serviceDate,
            required DateTime createdAt,
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ServiceRecordsCompanion.insert(
            id: id,
            vehicleId: vehicleId,
            branchId: branchId,
            technicianId: technicianId,
            salesmanId: salesmanId,
            serviceType: serviceType,
            notes: notes,
            odometer: odometer,
            serviceDate: serviceDate,
            createdAt: createdAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ServiceRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {vehicleId = false,
              branchId = false,
              technicianId = false,
              servicePhotosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (servicePhotosRefs) db.servicePhotos
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (vehicleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.vehicleId,
                    referencedTable:
                        $$ServiceRecordsTableReferences._vehicleIdTable(db),
                    referencedColumn:
                        $$ServiceRecordsTableReferences._vehicleIdTable(db).id,
                  ) as T;
                }
                if (branchId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.branchId,
                    referencedTable:
                        $$ServiceRecordsTableReferences._branchIdTable(db),
                    referencedColumn:
                        $$ServiceRecordsTableReferences._branchIdTable(db).id,
                  ) as T;
                }
                if (technicianId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.technicianId,
                    referencedTable:
                        $$ServiceRecordsTableReferences._technicianIdTable(db),
                    referencedColumn: $$ServiceRecordsTableReferences
                        ._technicianIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (servicePhotosRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ServiceRecordsTableReferences
                            ._servicePhotosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ServiceRecordsTableReferences(db, table, p0)
                                .servicePhotosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.serviceId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ServiceRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServiceRecordsTable,
    ServiceRecord,
    $$ServiceRecordsTableFilterComposer,
    $$ServiceRecordsTableOrderingComposer,
    $$ServiceRecordsTableAnnotationComposer,
    $$ServiceRecordsTableCreateCompanionBuilder,
    $$ServiceRecordsTableUpdateCompanionBuilder,
    (ServiceRecord, $$ServiceRecordsTableReferences),
    ServiceRecord,
    PrefetchHooks Function(
        {bool vehicleId,
        bool branchId,
        bool technicianId,
        bool servicePhotosRefs})>;
typedef $$ServicePhotosTableCreateCompanionBuilder = ServicePhotosCompanion
    Function({
  required String id,
  required String serviceId,
  required String photoType,
  required String localPath,
  Value<String?> remoteUrl,
  required DateTime takenAt,
  Value<bool> syncPending,
  Value<int> rowid,
});
typedef $$ServicePhotosTableUpdateCompanionBuilder = ServicePhotosCompanion
    Function({
  Value<String> id,
  Value<String> serviceId,
  Value<String> photoType,
  Value<String> localPath,
  Value<String?> remoteUrl,
  Value<DateTime> takenAt,
  Value<bool> syncPending,
  Value<int> rowid,
});

final class $$ServicePhotosTableReferences
    extends BaseReferences<_$AppDatabase, $ServicePhotosTable, ServicePhoto> {
  $$ServicePhotosTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ServiceRecordsTable _serviceIdTable(_$AppDatabase db) =>
      db.serviceRecords.createAlias($_aliasNameGenerator(
          db.servicePhotos.serviceId, db.serviceRecords.id));

  $$ServiceRecordsTableProcessedTableManager? get serviceId {
    if ($_item.serviceId == null) return null;
    final manager = $$ServiceRecordsTableTableManager($_db, $_db.serviceRecords)
        .filter((f) => f.id($_item.serviceId!));
    final item = $_typedResult.readTableOrNull(_serviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ServicePhotosTableFilterComposer
    extends Composer<_$AppDatabase, $ServicePhotosTable> {
  $$ServicePhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoType => $composableBuilder(
      column: $table.photoType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
      column: $table.takenAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnFilters(column));

  $$ServiceRecordsTableFilterComposer get serviceId {
    final $$ServiceRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.serviceId,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableFilterComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ServicePhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicePhotosTable> {
  $$ServicePhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoType => $composableBuilder(
      column: $table.photoType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
      column: $table.remoteUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
      column: $table.takenAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => ColumnOrderings(column));

  $$ServiceRecordsTableOrderingComposer get serviceId {
    final $$ServiceRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.serviceId,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ServicePhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicePhotosTable> {
  $$ServicePhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get photoType =>
      $composableBuilder(column: $table.photoType, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<bool> get syncPending => $composableBuilder(
      column: $table.syncPending, builder: (column) => column);

  $$ServiceRecordsTableAnnotationComposer get serviceId {
    final $$ServiceRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.serviceId,
        referencedTable: $db.serviceRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ServiceRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.serviceRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ServicePhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServicePhotosTable,
    ServicePhoto,
    $$ServicePhotosTableFilterComposer,
    $$ServicePhotosTableOrderingComposer,
    $$ServicePhotosTableAnnotationComposer,
    $$ServicePhotosTableCreateCompanionBuilder,
    $$ServicePhotosTableUpdateCompanionBuilder,
    (ServicePhoto, $$ServicePhotosTableReferences),
    ServicePhoto,
    PrefetchHooks Function({bool serviceId})> {
  $$ServicePhotosTableTableManager(_$AppDatabase db, $ServicePhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicePhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicePhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicePhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> serviceId = const Value.absent(),
            Value<String> photoType = const Value.absent(),
            Value<String> localPath = const Value.absent(),
            Value<String?> remoteUrl = const Value.absent(),
            Value<DateTime> takenAt = const Value.absent(),
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ServicePhotosCompanion(
            id: id,
            serviceId: serviceId,
            photoType: photoType,
            localPath: localPath,
            remoteUrl: remoteUrl,
            takenAt: takenAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String serviceId,
            required String photoType,
            required String localPath,
            Value<String?> remoteUrl = const Value.absent(),
            required DateTime takenAt,
            Value<bool> syncPending = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ServicePhotosCompanion.insert(
            id: id,
            serviceId: serviceId,
            photoType: photoType,
            localPath: localPath,
            remoteUrl: remoteUrl,
            takenAt: takenAt,
            syncPending: syncPending,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ServicePhotosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({serviceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (serviceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.serviceId,
                    referencedTable:
                        $$ServicePhotosTableReferences._serviceIdTable(db),
                    referencedColumn:
                        $$ServicePhotosTableReferences._serviceIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ServicePhotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServicePhotosTable,
    ServicePhoto,
    $$ServicePhotosTableFilterComposer,
    $$ServicePhotosTableOrderingComposer,
    $$ServicePhotosTableAnnotationComposer,
    $$ServicePhotosTableCreateCompanionBuilder,
    $$ServicePhotosTableUpdateCompanionBuilder,
    (ServicePhoto, $$ServicePhotosTableReferences),
    ServicePhoto,
    PrefetchHooks Function({bool serviceId})>;
typedef $$SyncLogTableCreateCompanionBuilder = SyncLogCompanion Function({
  Value<int> id,
  required String targetTable,
  required String recordId,
  required String operation,
  required DateTime queuedAt,
  Value<DateTime?> syncedAt,
  Value<String?> errorMessage,
});
typedef $$SyncLogTableUpdateCompanionBuilder = SyncLogCompanion Function({
  Value<int> id,
  Value<String> targetTable,
  Value<String> recordId,
  Value<String> operation,
  Value<DateTime> queuedAt,
  Value<DateTime?> syncedAt,
  Value<String?> errorMessage,
});

class $$SyncLogTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordId => $composableBuilder(
      column: $table.recordId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get queuedAt => $composableBuilder(
      column: $table.queuedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));
}

class $$SyncLogTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordId => $composableBuilder(
      column: $table.recordId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get queuedAt => $composableBuilder(
      column: $table.queuedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
      column: $table.targetTable, builder: (column) => column);

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<DateTime> get queuedAt =>
      $composableBuilder(column: $table.queuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);
}

class $$SyncLogTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncLogTable,
    SyncLogData,
    $$SyncLogTableFilterComposer,
    $$SyncLogTableOrderingComposer,
    $$SyncLogTableAnnotationComposer,
    $$SyncLogTableCreateCompanionBuilder,
    $$SyncLogTableUpdateCompanionBuilder,
    (SyncLogData, BaseReferences<_$AppDatabase, $SyncLogTable, SyncLogData>),
    SyncLogData,
    PrefetchHooks Function()> {
  $$SyncLogTableTableManager(_$AppDatabase db, $SyncLogTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> targetTable = const Value.absent(),
            Value<String> recordId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<DateTime> queuedAt = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
          }) =>
              SyncLogCompanion(
            id: id,
            targetTable: targetTable,
            recordId: recordId,
            operation: operation,
            queuedAt: queuedAt,
            syncedAt: syncedAt,
            errorMessage: errorMessage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String targetTable,
            required String recordId,
            required String operation,
            required DateTime queuedAt,
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
          }) =>
              SyncLogCompanion.insert(
            id: id,
            targetTable: targetTable,
            recordId: recordId,
            operation: operation,
            queuedAt: queuedAt,
            syncedAt: syncedAt,
            errorMessage: errorMessage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncLogTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncLogTable,
    SyncLogData,
    $$SyncLogTableFilterComposer,
    $$SyncLogTableOrderingComposer,
    $$SyncLogTableAnnotationComposer,
    $$SyncLogTableCreateCompanionBuilder,
    $$SyncLogTableUpdateCompanionBuilder,
    (SyncLogData, BaseReferences<_$AppDatabase, $SyncLogTable, SyncLogData>),
    SyncLogData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$AppUsersTableTableManager get appUsers =>
      $$AppUsersTableTableManager(_db, _db.appUsers);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$DriversTableTableManager get drivers =>
      $$DriversTableTableManager(_db, _db.drivers);
  $$ServiceRecordsTableTableManager get serviceRecords =>
      $$ServiceRecordsTableTableManager(_db, _db.serviceRecords);
  $$ServicePhotosTableTableManager get servicePhotos =>
      $$ServicePhotosTableTableManager(_db, _db.servicePhotos);
  $$SyncLogTableTableManager get syncLog =>
      $$SyncLogTableTableManager(_db, _db.syncLog);
}

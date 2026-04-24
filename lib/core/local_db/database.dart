import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

// ─── Tables ────────────────────────────────────────────────────────────────

class Branches extends Table {
  TextColumn get id          => text()();
  TextColumn get name        => text()();
  TextColumn get city        => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class AppUsers extends Table {
  TextColumn get id         => text()();
  TextColumn get branchId   => text().references(Branches, #id)();
  TextColumn get name       => text()();
  TextColumn get email      => text()();
  TextColumn get role       => text()(); // UserRole.name
  TextColumn get pin        => text()(); // hashed
  BoolColumn get isActive   => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Vehicles extends Table {
  TextColumn get id             => text()();
  TextColumn get branchId       => text().references(Branches, #id)();
  TextColumn get licensePlate   => text()();
  TextColumn get make           => text()();
  TextColumn get model          => text()();
  IntColumn  get year           => integer()();
  TextColumn get colour         => text()();
  TextColumn get vin            => text().nullable()();
  TextColumn get assignedDriverId => text().nullable()();
  DateTimeColumn get licenseExpiry  => dateTime().nullable()();
  DateTimeColumn get updatedAt      => dateTime()();
  BoolColumn get syncPending    => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Drivers extends Table {
  TextColumn get id          => text()();
  TextColumn get branchId    => text().references(Branches, #id)();
  TextColumn get name        => text()();
  TextColumn get idNumber    => text().nullable()();
  TextColumn get licenseNumber => text().nullable()();
  DateTimeColumn get licenseExpiry => dateTime().nullable()();
  TextColumn get phone       => text().nullable()();
  BoolColumn get isActive    => boolean().withDefault(const Constant(true))();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get syncPending => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class ServiceRecords extends Table {
  TextColumn get id          => text()();
  TextColumn get vehicleId   => text().references(Vehicles, #id)();
  TextColumn get branchId    => text().references(Branches, #id)();
  TextColumn get technicianId => text().references(AppUsers, #id)();
  TextColumn get salesmanId  => text().nullable()();
  TextColumn get serviceType => text()();
  TextColumn get notes       => text().nullable()();
  IntColumn  get odometer    => integer()();
  DateTimeColumn get serviceDate  => dateTime()();
  DateTimeColumn get createdAt    => dateTime()();
  BoolColumn get syncPending => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class ServicePhotos extends Table {
  TextColumn get id          => text()();
  TextColumn get serviceId   => text().references(ServiceRecords, #id)();
  TextColumn get photoType   => text()(); // PhotoType.name
  TextColumn get localPath   => text()(); // path on device
  TextColumn get remoteUrl   => text().nullable()(); // Supabase Storage URL
  DateTimeColumn get takenAt => dateTime()();
  BoolColumn get syncPending => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncLog extends Table {
  IntColumn  get id           => integer().autoIncrement()();
  TextColumn get targetTable  => text()();  // renamed: tableName is reserved by Drift
  TextColumn get recordId     => text()();
  TextColumn get operation    => text()(); // insert | update | delete
  DateTimeColumn get queuedAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();
}

// ─── Database ──────────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  Branches,
  AppUsers,
  Vehicles,
  Drivers,
  ServiceRecords,
  ServicePhotos,
  SyncLog,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Future migrations go here
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'fleet_manager_db');
  }
}

// ─── Photo types (10 required shots) ──────────────────────────────────────

enum PhotoType {
  frontView       ('Front view'),
  rearView        ('Rear view'),
  leftSide        ('Left side'),
  rightSide       ('Right side'),
  frontLeftWheel  ('Front left wheel'),
  frontRightWheel ('Front right wheel'),
  rearLeftWheel   ('Rear left wheel'),
  rearRightWheel  ('Rear right wheel'),
  spareWheel      ('Spare wheel'),
  odometer        ('Odometer');

  const PhotoType(this.label);
  final String label;

  String get instruction => switch (this) {
    PhotoType.frontView       => 'Stand 2m in front of the vehicle',
    PhotoType.rearView        => 'Stand 2m behind the vehicle',
    PhotoType.leftSide        => 'Stand alongside the left side of the vehicle',
    PhotoType.rightSide       => 'Stand alongside the right side of the vehicle',
    PhotoType.frontLeftWheel  => 'Photograph the front left wheel and tyre',
    PhotoType.frontRightWheel => 'Photograph the front right wheel and tyre',
    PhotoType.rearLeftWheel   => 'Photograph the rear left wheel and tyre',
    PhotoType.rearRightWheel  => 'Photograph the rear right wheel and tyre',
    PhotoType.spareWheel      => 'Locate and photograph the spare wheel',
    PhotoType.odometer        => 'Photograph the odometer reading clearly',
  };
}

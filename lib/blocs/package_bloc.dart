// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

sealed class PackageEvent {}

final class UpdatePackage extends PackageEvent {
  final Package package;
  UpdatePackage(this.package);
}

final class ToggleSave extends PackageEvent {}

final class GetPackage extends PackageEvent {
  final String packageId;
  GetPackage(this.packageId);
}

enum PackageStatus { success, failure }

class PackageState extends Equatable {
  const PackageState({
    this.status = PackageStatus.success,
    required this.package,
  });
  final PackageStatus status;
  final Package package;

  PackageState copyWith({
    PackageStatus? status,
    Package? package,
  }) {
    return PackageState(
      status: status ?? this.status,
      package: package ?? this.package,
    );
  }

  @override
  List<Object?> get props =>
      [status, package, package.hasDetails, package.isSaved];
}

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackageBloc(package) : super(PackageState(package: package)) {
    on<UpdatePackage>((event, emit) => emit(state.copyWith(
          package: event.package,
          status: PackageStatus.success,
        )));
    on<ToggleSave>(
      (event, emit) => emit(state.copyWith(
          package: state.package.copyWith(isSaved: !state.package.isSaved))),
    );
    on<GetPackage>(_onGetPackage);
  }

  Future<void> _onGetPackage(
      GetPackage event, Emitter<PackageState> emit) async {
    try {
      if (!state.package.hasDetails) {
        final Package package = await _fetchPackage();
        emit(state.copyWith(
          package: package.copyWith(hasDetails: true),
          status: PackageStatus.success,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: PackageStatus.failure));
    }
  }

  Future<Package> _fetchPackage() async {
    Response response =
        await GovinfoApi().getPackageById(state.package.packageId);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Package package = Package.fromJson(response.body);
      return package;
    } else if (response.statusCode == 429) {
      throw Exception("429: Too many requests");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to retrieve package');
    }
  }
}

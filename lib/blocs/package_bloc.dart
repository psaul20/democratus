// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class PackageEvent {}

final class UpdatePackage extends PackageEvent {}

final class ToggleSave extends PackageEvent {}

final class GetPackage extends PackageEvent {}

enum PackageStatus { initial, summarized, detailed, failure }

class PackageState extends Equatable {
  const PackageState({
    this.status = PackageStatus.initial,
    this.package,
  });
  final PackageStatus status;
  final Package? package;

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
  List<Object?> get props => [status, package];
}

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  PackageBloc() : super(const PackageState()) {
    // on<UpdatePackage>((event, emit) => emit(package));
    // on<ToggleSave>(
    //   (event, emit) => emit(),
    // );
    on<GetPackage>(_onGetPackage);
  }

  Future<void> _onGetPackage(GetPackage event, Emitter<PackageState> emit) {
    try {
      if (state.status == PackageStatus.initial) {
        final package = await
      }
    }
  }
}

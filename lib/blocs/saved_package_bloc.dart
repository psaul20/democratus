// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Implement repository to share state across blocs

sealed class SavedPackagesEvent {}

final class ReplacePackages extends SavedPackagesEvent {
  List<Package> packages;
  ReplacePackages({
    required this.packages,
  });
}

final class SavePackage extends SavedPackagesEvent {
  Package package;
  SavePackage({
    required this.package,
  });
}

final class RemovePackage extends SavedPackagesEvent {
  Package package;
  RemovePackage({
    required this.package,
  });
}

enum SavedPackagesStatus { initial, success, failure }

final class SavedPackagesState extends Equatable {
  const SavedPackagesState({
    this.status = SavedPackagesStatus.initial,
    this.packages = const <Package>[],
  });

  final SavedPackagesStatus status;
  final List<Package> packages;

  SavedPackagesState copyWith({
    SavedPackagesStatus? status,
    List<Package>? packages,
  }) {
    return SavedPackagesState(
      status: status ?? this.status,
      packages: packages ?? this.packages,
    );
  }

  @override
  List<Object?> get props => [status, packages];
}

class SavedPackagesBloc extends Bloc<SavedPackagesEvent, SavedPackagesState> {
  SavedPackagesBloc() : super(const SavedPackagesState()) {
    on<ReplacePackages>(
      (event, emit) => state.copyWith(
        packages: event.packages,
        status: SavedPackagesStatus.success,
      ),
    );
    on<SavePackage>((event, emit) => emit(state.copyWith(
          status: SavedPackagesStatus.success,
          packages: [...state.packages, event.package],
        )));
    on<RemovePackage>(
      (event, emit) {
        List<Package> newPackages = [
          for (final package in state.packages)
            if (package.packageId != event.package.packageId) package,
        ];
        emit(state.copyWith(
            packages: newPackages,
            status: newPackages.isEmpty
                ? SavedPackagesStatus.initial
                : SavedPackagesStatus.success));
      },
    );
  }
}

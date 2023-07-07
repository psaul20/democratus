// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/package.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class PackageListEvent {}

final class SearchPackages extends PackageListEvent {}

final class ReplacePackages extends PackageListEvent {}

final class AddPackage extends PackageListEvent {}

final class UpdatePackageWith extends PackageListEvent {}

final class RemovePackage extends PackageListEvent {}

enum PackageListStatus { initial, success, failure }

final class PackageListState extends Equatable {
  const PackageListState({
    this.status = PackageListStatus.initial,
    this.packages = const <Package>[],
  });

  final PackageListStatus status;
  final List<Package> packages;

  PackageListState copyWith({
    PackageListStatus? status,
    List<Package>? packages,
  }) {
    return PackageListState(
      status: status ?? this.status,
      packages: packages ?? this.packages,
    );
  }

  @override
  List<Object?> get props => [status, packages];
}

class PackageListBloc extends Bloc<PackageListEvent, PackageListState> {
  PackageListBloc() : super(const PackageListState()) {
    on<SearchPackages>(_onSearchPackages);
  };

  Future<void> _onSearchPackages(SearchPackages event, Emitter<PackageListState> emit) async {
      try{
    if(state.status == PackageListStatus.initial) {
      final packages = await GovinfoApi().searchPackages(startDate: startDate, collectionCodes: collectionCodes);
      return emit(state.copyWith(status: PackageListStatus.success, packages: packages));
    }
  } catch (_) {
    emit(state.copyWith(status: PackageListStatus.failure));
  }

  }


}

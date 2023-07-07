// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class CollectionsListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCollectionsList extends CollectionsListEvent {}

final class SelectCollection extends CollectionsListEvent {
  final Collection collection;
  SelectCollection({required this.collection});
}

enum CollectionsListStatus { initial, success, failure }

final class CollectionsListState extends Equatable {
  final CollectionsListStatus status;
  final List<Collection> collections;
  final Collection? selectedCollection;

  const CollectionsListState({
    this.status = CollectionsListStatus.initial,
    this.collections = const <Collection>[],
    this.selectedCollection,
  });

  @override
  List<Object?> get props => [status, collections];

  CollectionsListState copyWith({
    CollectionsListStatus? status,
    List<Collection>? collections,
    Collection? selectedCollection,
  }) {
    return CollectionsListState(
      status: status ?? this.status,
      collections: collections ?? this.collections,
      selectedCollection: selectedCollection ?? this.selectedCollection,
    );
  }
}

class CollectionsListBloc
    extends Bloc<CollectionsListEvent, CollectionsListState> {
  CollectionsListBloc() : super(const CollectionsListState()) {
    on<GetCollectionsList>(_onGetCollectionsList);
    on<SelectCollection>(
      (event, emit) =>
          emit(state.copyWith(selectedCollection: event.collection)),
    );
  }

  Future<void> _onGetCollectionsList(
      CollectionsListEvent event, Emitter<CollectionsListState> emit) async {
    try {
      if (state.status == CollectionsListStatus.initial) {
        final collections = await _fetchCollections();
        return emit(state.copyWith(
            collections: collections,
            status: CollectionsListStatus.success,
            selectedCollection: collections.first));
      }
    } catch (_) {
      emit(state.copyWith(status: CollectionsListStatus.failure));
    }
  }

  Future<List<Collection>> _fetchCollections() async {
    final response = await GovinfoApi().getCollections();
    if (response.statusCode == 200) {
      CollectionList clist = CollectionList.fromJson(response.body);
      return clist.asList;
    }
    throw Exception('Error fetching Collections');
  }
}

part of 'client_cubit.dart';

class ClientState {
  final Client client;
  const ClientState(this.client);
}

final class ClientInitial extends ClientState {
  const ClientInitial(client) : super(client);
}

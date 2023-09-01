import 'package:bloc/bloc.dart';
import 'package:http/http.dart';

part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit([client]) : super(ClientInitial(client ?? Client()));
}

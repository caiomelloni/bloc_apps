import 'dart:async';

import 'package:busca_cep/bloc/cep_events.dart';
import 'package:busca_cep/bloc/cep_state.dart';
import 'package:busca_cep/service/cep_service.dart';

class CepBloc {
  late CepService _cepService;

  final StreamController<CepEvent> _inputEvent = StreamController<CepEvent>();
  final StreamController<CepState> _outputEvent = StreamController<CepState>();

  Sink<CepEvent> get inputEvent => _inputEvent.sink;
  Stream<CepState> get stream => _outputEvent.stream;

  CepBloc() {
    _cepService = CepService();
    _inputEvent.stream.listen(_mapEventToState);
  }

  Future<void> _mapEventToState(CepEvent event) async {
    if (event is InputCepEvent) {
      _outputEvent.add(LoadingCepState());
      try {
        await _cepService.fetchEndereco(event.input);
        _outputEvent.add(
          SuccessLoadingCepState(endereco: _cepService.endereco!),
        );
      } on ErroCep catch (e) {
        _outputEvent.add(ErrorLoadingCepState(
          e.erroMessage,
        ));
      }
    }
  }
}

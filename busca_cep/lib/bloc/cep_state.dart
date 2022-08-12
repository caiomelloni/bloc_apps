import 'package:busca_cep/models/endereco.dart';

abstract class CepState {
  Endereco endereco;
  CepState({
    required this.endereco,
  });

  String? get errorMessage => null;
}

class LoadingCepState extends CepState {
  LoadingCepState() : super(endereco: Endereco());
}

class SuccessLoadingCepState extends CepState {
  SuccessLoadingCepState({required super.endereco});
}

class ErrorLoadingCepState extends CepState {
  String erro;
  ErrorLoadingCepState(this.erro) : super(endereco: Endereco());

  @override
  String? get errorMessage => erro;
}

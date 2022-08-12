import 'package:busca_cep/models/endereco.dart';
import 'package:http/http.dart' as http;

class CepService {
  Endereco? _enderecoAtual;

  Endereco? get endereco => _enderecoAtual;

  Future<void> fetchEndereco(String cep) async {
    if (cep.length < 8) {
      throw ErroCep(erro: "Um cep possui pelo menos 8 digitos");
    }

    _enderecoAtual = await _fetchEndereco(cep);

    if (_enderecoAtual == null) {
      throw ErroCep(erro: "Cep inválido");
    }
  }

  Future<Endereco?> _fetchEndereco(String cep) async {
    var url = Uri.https('viacep.com.br', '/ws/$cep/json/');
    var response = await http.get(url);
    if (response.statusCode != 200) return null;
    return Endereco.fromJson(response.body);
  }
}

class ErroCep implements Exception {
  String erroMessage;
  ErroCep({
    required String erro,
  }) : erroMessage = erro;
}

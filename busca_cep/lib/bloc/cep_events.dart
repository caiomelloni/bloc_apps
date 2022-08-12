abstract class CepEvent {}

class InputCepEvent extends CepEvent {
  final String _input;
  String get input => _input;
  InputCepEvent({
    required String input,
  }) : _input = input;
}

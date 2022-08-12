# Bloc design pattern

- obs: na branch "package" foram refeitas versões com package

## Como usar BLoC sem packages

### A Classe Bloc
- Só ela se comunica com o backend através de um instância privada da classe que contém os serviços

- possui dois StreamControllers privados, um para o input de eventos e outro para a emissão de estados

- a partir de getters, ocorre a exposição do sink do input para a adição de eventos e a exposição da stream para ouvir os novos estados

- no construtor do bloc declaramos que a stream do controller de input de eventos vai escutar os eventos, podemos passar um método privado _mapEventToState para isso

- no método _mapEventToState recebemos o evento e criamos o output do estado pelo controller

### As Classes de Estado
- Ao serem emitadas pelo bloc, recebem os dados do backend, assim levam não só o tipo do estado, mas também os dados

### As Classes de Evento
- são instânciadas na UI e passadas pelo input de evento, levando todas informações necessárias para que o bloc possa interagir corretamente com o backend
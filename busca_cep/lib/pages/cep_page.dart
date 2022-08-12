import 'package:busca_cep/bloc/cep_bloc.dart';
import 'package:busca_cep/bloc/cep_events.dart';
import 'package:busca_cep/bloc/cep_state.dart';
import 'package:busca_cep/models/endereco.dart';
import 'package:flutter/material.dart';

class CepPage extends StatefulWidget {
  const CepPage({Key? key}) : super(key: key);

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  late CepBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CepBloc();
  }

  @override
  void dispose() {
    bloc.inputEvent.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<CepState>(
              stream: bloc.stream,
              builder: (context, AsyncSnapshot<CepState> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(height: 300);
                }

                if (snapshot.data is LoadingCepState) {
                  return const SizedBox(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.data is ErrorLoadingCepState) {
                  return SizedBox(
                    height: 300,
                    child: Text(
                      snapshot.data!.errorMessage!,
                    ),
                  );
                }

                Endereco endereco = snapshot.data!.endereco;
                return SizedBox(
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("cep : ${endereco.cep}"),
                      Text("logradouro : ${endereco.logradouro}"),
                      Text("complemento : ${endereco.complemento}"),
                      Text("bairro : ${endereco.bairro}"),
                      Text("localidade : ${endereco.localidade}"),
                      Text("uf : ${endereco.uf}"),
                      Text("ibge : ${endereco.ibge}"),
                      Text("gia : ${endereco.gia}"),
                      Text("ddd : ${endereco.ddd}"),
                      Text("siafi : ${endereco.siafi}"),
                    ],
                  ),
                );
              }),
          SizedBox(
              width: 200,
              child: TextField(
                onChanged: (input) {
                  bloc.inputEvent.add(InputCepEvent(input: input));
                },
              )),
        ],
      ),
    ));
  }
}

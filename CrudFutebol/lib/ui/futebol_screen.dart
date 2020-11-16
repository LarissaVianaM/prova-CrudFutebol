import 'package:flutter/material.dart';
import 'package:CrudFutebol/model/futebol.dart';
import 'package:CrudFutebol/db/database_helper.dart';

class FutebolScreen extends StatefulWidget {
  final Futebol futebol;
  FutebolScreen(this.futebol);
  @override
  State<StatefulWidget> createState() => new _FutebolScreenState();
}
class _FutebolScreenState extends State<FutebolScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _fundacaoController;
  TextEditingController _presidenteController;
  TextEditingController _mascoteController;
  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.futebol.nome);
    _fundacaoController = new TextEditingController(text: widget.futebol.fundacao);
    _presidenteController = new TextEditingController(text: widget.futebol.presidente);
    _mascoteController = new TextEditingController(text: widget.futebol.mascote);
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cadastro de Times de Futebol'),
        centerTitle: true,
        backgroundColor: Colors.cyan[300],
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        
        child: Column(
          children:[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Time', labelStyle: new TextStyle(color: Colors.cyan[400])),
              
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _fundacaoController,
              decoration: InputDecoration(labelText: 'Ano de Fundação', labelStyle: new TextStyle(color: Colors.cyan[400])),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _presidenteController,
              decoration: InputDecoration(labelText: 'Nome do Presidente', labelStyle: new TextStyle(color: Colors.cyan[400])),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _mascoteController,
              decoration: InputDecoration(labelText: 'Mascote' , labelStyle: new TextStyle(color: Colors.cyan[400])),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.futebol.id != null) ? Text('Alterar') : Text('Inserir'),
              color: Colors.cyan[300],
              
              onPressed: () {
                if (widget.futebol.id != null) {
                  db.updateFutebol(Futebol.fromMap({
                    'id': widget.futebol.id,
                    'nome': _nomeController.text,
                    'fundacao': _fundacaoController.text,
                    'presidente': _presidenteController.text,
                    'mascote': _mascoteController.text
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                } 
                else {
                  db.inserirFutebol(Futebol(_nomeController.text, _fundacaoController.text, _presidenteController.text, _mascoteController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

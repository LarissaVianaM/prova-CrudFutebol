class Futebol {
  int _id;
  String _nome;
  String _fundacao;
  String _presidente;
  String _mascote;
  //construtor da classe
  Futebol(this._nome, this._fundacao, this._presidente, this._mascote);
  //converte dados de vetor para objeto
  Futebol.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._fundacao = obj['fundacao'];
    this._presidente = obj['presidente'];
    this._mascote = obj['mascote'];
  }
  // encapsulamento
  int get id => _id;
  String get nome => _nome;
  String get fundacao => _fundacao;
  String get presidente => _presidente;
  String get mascote => _mascote;
 //converte o objeto em um map
 Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
       map['id'] = _id;
    }
    map['nome'] = _nome;
    map['fundacao'] = _fundacao;
    map['presidente'] = _presidente;
    map['mascote'] = _mascote;
    return map;
  }
  //converte map em um objeto
  Futebol.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._fundacao = map['fundacao'];
    this._presidente = map['presidente'];
    this._mascote = map['mascote'];
  }
}

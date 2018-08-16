class Kefir {

  String id;
  String nome;
  String criacao;
  List<String> registros = [];
  
  Kefir({this.id, this.nome, this.criacao, this.registros});

  factory Kefir.fromJson(Map<String, dynamic> parsedJson) {
    var registrosFromJson = parsedJson['registros'];
    List<String> registrosList = new List<String>.from(registrosFromJson);
    return new Kefir(
      id: parsedJson['id'],
      nome: parsedJson['nome'],
      criacao: parsedJson['criacao'],
      registros: registrosList,
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id,'nome': nome, 'criacao': criacao, "registros": registros};

  @override
  bool operator ==(other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

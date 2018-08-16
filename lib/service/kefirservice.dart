import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:kefir/model/kefir.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const String APP_STATE_KEY = "LISTA_GERAL";

class KefirService {
  DateFormat _formatter = DateFormat('dd/MM/yyyy HH:mm');

  Future<List<String>> _getListaGeral() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> listaGeral = preferences.getStringList(APP_STATE_KEY);
    if (listaGeral == null) {
      listaGeral = List<String>();
    }
    return listaGeral;
  }

  Future<List<Kefir>> createKefirCommand(String nome) async {
    List<String> listaGeral = await _getListaGeral();

    if (nome != '') {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var jobject = json.encode(new Kefir(
          id: new Uuid().v1(),
          nome: nome,
          criacao: _formatter.format(DateTime.now()),
          registros: []).toJson());
      listaGeral.add(jobject);
      await preferences.setStringList(APP_STATE_KEY, listaGeral);
    }
    var listaKefir = listaGeral.map((i) {
      return new Kefir.fromJson(json.decode(i));
    }).toList();

    return listaKefir;
  }

  Future<List<Kefir>> removeKefirCommand(Kefir kefir) async {
    List<String> listaGeral = await _getListaGeral();
    var listaKefir = listaGeral.map((i) {
      return new Kefir.fromJson(json.decode(i));
    }).toList();
    if (kefir != null) {
      listaKefir.remove(kefir);
      listaGeral.removeWhere(
          (item) => Kefir.fromJson(json.decode(item)).id == kefir.id);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setStringList(APP_STATE_KEY, listaGeral);
    }
    return listaKefir;
  }


  Future<List<String>> addRegistroKefirCommand(
      Map<String, dynamic> param) async {
    var kefir = param['kefir'];
    
    List<String> listaGeral = await _getListaGeral();
    var listaKefir = listaGeral.map((i) {
      return new Kefir.fromJson(json.decode(i));
    }).toList();
    if (kefir != null) {
      kefir = listaKefir.firstWhere((item) => item.id == kefir.id);
    }
    
    if (!param['listar']) {
      kefir.registros.add(_formatter.format(DateTime.now()));

      listaGeral.removeWhere(
          (item) => Kefir.fromJson(json.decode(item)).id == kefir.id);
      listaGeral.add(json.encode(kefir.toJson()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setStringList(APP_STATE_KEY, listaGeral);
    }
    return kefir.registros;
  }

  Future<List<String>> removeRegistroKefirCommand(
      Map<String, dynamic> param) async {
    var kefir = param['kefir'];
    var registro = param['registro'];
    List<String> listaGeral = await _getListaGeral();
    var listaKefir = listaGeral.map((i) {
      return new Kefir.fromJson(json.decode(i));
    }).toList();
    if (kefir != null) {
      kefir = listaKefir.firstWhere((item) => item.id == kefir.id);
      kefir.registros.remove(registro);

      listaGeral.removeWhere(
          (item) => Kefir.fromJson(json.decode(item)).id == kefir.id);
      listaGeral.add(json.encode(kefir.toJson()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setStringList(APP_STATE_KEY, listaGeral);
    }
    return kefir.registros;
  }
}

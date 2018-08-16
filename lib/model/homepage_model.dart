import 'package:kefir/model/kefir.dart';
import 'package:kefir/service/kefirservice.dart';
import 'package:rx_command/rx_command.dart';

class HomePageModel {
  final KefirService service;
  final RxCommand<String, List<Kefir>> createKefirCommand;
  final RxCommand<Kefir, List<Kefir>> removeKefirCommand;
  final RxCommand<Map<String,dynamic>, List<String>> addRegistroKefirCommand;
  final RxCommand<Map<String,dynamic>, List<String>> removeRegistroKefirCommand;

  HomePageModel._(
    this.createKefirCommand,
    this.removeKefirCommand,
    this.addRegistroKefirCommand,
    this.removeRegistroKefirCommand,
    this.service,
  );

  factory HomePageModel(KefirService service) {
    final _createKefirCommand =
        RxCommand.createAsync3<String, List<Kefir>>(service.createKefirCommand);

    final _removeKefirCommand =
        RxCommand.createAsync3<Kefir, List<Kefir>>(service.removeKefirCommand);

    final _addRegistroKefirCommand =
        RxCommand.createAsync3<Map<String,dynamic>, List<String>>(
            service.addRegistroKefirCommand);

    final _removeRegistroKefirCommand =
        RxCommand.createAsync3<Map<String,dynamic>, List<String>>(
            service.removeRegistroKefirCommand);

    _createKefirCommand('');

    return new HomePageModel._(
      _createKefirCommand,
      _removeKefirCommand,
      _addRegistroKefirCommand,
      _removeRegistroKefirCommand,
      service,
    );
  }
}

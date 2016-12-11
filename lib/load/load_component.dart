import 'dart:html' show File;
import 'dart:async' show Future;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import '../read_wrapper_service.dart';

/// Dialog for loading the dmi file
@Component(
    selector: 'load-component',
    templateUrl: 'load_component.html',
    styleUrls: const ['../../lib/load/load_component.css'])
class LoadComponent implements OnInit {
  final ReadWrapperService _reader;
  final RouteParams _routeParams;

  bool buttonsEnabled = true;
  String _localMessage = null;
  bool _localError = false;

  String get message => _reader.message ?? _localMessage;
  bool get error => _reader.error ? _reader.error : _localError;

  LoadComponent(this._reader, this._routeParams);

  Future<Null> ngOnInit() async {
    if(_routeParams.get('url') != null){
      urlLoad(_routeParams.get('url'));
    }
  }

  void lockForm([String message]) {
    _localMessage = message;
    buttonsEnabled = false;
  }

  void unlockForm([String message]) {
    _localMessage = message;
    buttonsEnabled = true;
  }

  fileLoad(File file) async {
    if (file == null) {
      // happens when Load is clicked with file selector blank
      return;
    }
    lockForm("Loading...");

    await _reader.getBytesFromFile(file);

    unlockForm();
  }

  urlLoad(String url) async {
    lockForm("Downloading...");

    await _reader.getBytesFromUrl(url);

    unlockForm();
  }
}

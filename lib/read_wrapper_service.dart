import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dmi_read/dmi_read.dart';

/// Wrapper service around the dmi_read library
///
/// This service holds the current DmiSheet object, as well as the current state
/// of loading (ie, any errors).
@Injectable()
class ReadWrapperService {
  DmiSheet _sheet;
  final Router _router;

  /// The DmiSheet itself. If `null`, it isn't loaded yet.
  DmiSheet get sheet => _sheet;

  //TODO: Pull out this functionality into its own service
  String message;
  bool error = false;

  ReadWrapperService(this._router);

  Future<Null> processFile(List<int> bytes) async {
    try {
      _sheet = new DmiSheet.fromBytes(bytes);

      // we're good, don't display any errors
      setMessage(false);
      await _router.navigate(['Overview']);
    } on DmiParseError catch (e) {
      window.console.error('Problem in DmiSheet loading: ${e.toString()}');
      setMessage(true, e.toString());
    }
  }

  /// Set an error or informative message regarding loading state
  void setMessage(bool error, [String message]){
    this.error = error;
    this.message = message;
  }

  Future<Null> getBytesFromUrl(String url) async {
    url = _guessUrl(url);

    try {
      HttpRequest request =
          await HttpRequest.request(url, responseType: 'arraybuffer');

        List<int> bytes = request.response.asUint8List();
        window.console.debug('Fetch completed, ${bytes.length} bytes.');
        processFile(bytes);
    } catch(e) {
      window.console.error('Problem loading from URL: $url. ${e.toString()}');
      setMessage(true, 'Problem downloading file: ${e.toString()}');
    }
  }

  /// Attempt to guess a download URL
  ///
  /// Currently maps https://github.com URLs to https://raw.githubusercontent.com
  /// URLS.
  String _guessUrl(String url){
    // 1: User, 2: Repo, 3: git ref, 4: filepath
    final githubRaw = new RegExp(r'://github\.com/([A-Za-z0-9\-]+)/([A-Za-z0-9\-]+)/raw/(\w+)/([^#?\s]+)');
    final match = githubRaw.firstMatch(url);

    if(match != null){
      return 'https://raw.githubusercontent.com/' +
          match.group(1) + '/' +
          match.group(2) + '/' +
          match.group(3) + '/' +
          match.group(4);
    } else {
      return url;
    }
  }

  Future<Null> getBytesFromFile(File file) async {
    try{
      FileReader fileReader = new FileReader();

      // Filereader doesn't use Future, so we wait on the event instead
      fileReader.readAsArrayBuffer(file);
      await fileReader.onLoadEnd.first;

      final bytes = fileReader.result;

      if(bytes is List<int>){
        window.console.debug('Load completed, ${bytes.length} bytes.');
        processFile(bytes);
      } else {
        window.console.error('File loaded as something other than a list of bytes');
        setMessage(true, 'File loadig failed.');
      }
    } catch(e) {
      window.console.error('Problem loading from file $file: ${e.toString}');
      setMessage(true, 'Problem loading file: ${e.toString}');
    }
  }
}

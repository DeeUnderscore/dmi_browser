import 'dart:html' show window;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart' show Location;

import 'package:dmi_read/dmi_read.dart';

import '../icon_viewer/icon_viewer_component.dart';
import '../direction_name_pipe.dart';
import '../read_wrapper_service.dart';

@Component(
    selector: 'movie-icon-viewer',
    templateUrl: 'movie_icon_viewer_component.html',
    pipes: const [DirectionNamePipe],
    directives: const [IconViewerComponent])
class MovieIconViewerComponent {
  final RouteParams _routeParams;
  final Location _location;
  final ReadWrapperService _reader;

  String stateName;
  IconDirection direction;
  int iconNum;
  DmiIcon icon;

  MovieIconViewerComponent(
      this._routeParams, this._location, this._reader) {
    try {
      MovieState state = _reader.sheet.getStateNamed(_routeParams.get('name'));
      stateName = state.name;
      direction =
          IconDirection.values[int.parse(_routeParams.get('direction'))];
      iconNum = int.parse(_routeParams.get('iconNum'));
      icon = state.icons[direction][iconNum];
    } catch (e) {
      _bailOut(e);
    }
  }

  void _bailOut([dynamic e]) {
    window.console.error(
        'Tried getting an invalid icon out of a movie. ' + e?.toString());
    _location.back();
  }
}

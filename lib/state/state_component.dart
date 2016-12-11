import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dmi_read/dmi_read.dart';

import '../read_wrapper_service.dart';
import '../icon_viewer/icon_viewer_component.dart';
import '../movie_viewer/movie_viewer_component.dart';

/// View of a single state
///
/// This component decides whether to display a single icon in case of pixmaps,
/// or a table of icons in case of animations
@Component(
    selector: 'state-component',
    templateUrl: 'state_component.html',
    styleUrls: const ['../../lib/state/state_component.css'],
    directives: const [IconViewerComponent, MovieViewerComponent])
class StateComponent implements OnInit {
  final RouteParams _routeParams;
  final ReadWrapperService _reader;
  final Router _router;

  DmiState state;
  String stateName;

  StateComponent(this._routeParams, this._reader, this._router);

  void ngOnInit() {
    stateName = _routeParams.get('name');
    if(stateName == null){
      // Not sure if this can even happen
      window.console.error('Navigated to the State route, but StateComponent was unable to get the name param');
      _router.navigate(['Overview']);
    }

    // _reader.sheet may be null if we haven't yet loaded a dmi
    state = _reader?.sheet?.getStateNamed(stateName);

    if(state == null){
      window.console.error('Unable to retrieve state named "$stateName"');
      _router.navigate(['Overview']);
    }
  }

  bool isStatePixmap() => state != null && state is PixmapState;
  bool isStateMovie() => state != null && state is MovieState;
}

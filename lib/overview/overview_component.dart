import 'dart:html';
import 'dart:collection' show UnmodifiableListView;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dmi_read/dmi_read.dart';

import '../read_wrapper_service.dart';
import '../icon_render_component.dart';

/// Overview of the whole sheet, listing all states
@Component(
    selector: 'overview-component',
    templateUrl: 'overview_component.html',
    // Yes, that's two ..s. Sorry.
    styleUrls: const ['../../lib/overview/overview_component.css'],
    directives: const [ROUTER_DIRECTIVES, IconRenderComponent],
    pipes: const [StateTypeNamePipe])
class OverviewComponent {
  final ReadWrapperService _reader;
  final Router _router;

  OverviewComponent(this._reader, this._router) {
    if (_reader.sheet == null) {
      window.console.error(
          'Navigated to OverviewComponent despite no sheet being currently loaded');
      _router.navigate(['Load']);
    }
  }

  UnmodifiableListView<DmiState> get states => _reader.sheet.states;
}

/// Returns the type of the piped in state as a string
@Pipe(name: 'stateTypeName')
class StateTypeNamePipe {
  String transform(DmiState state) {
    if (state is PixmapState) {
      return 'pixmap';
    } else if (state is MovieState) {
      return 'movie';
    } else {
      return null;
    }
  }
}

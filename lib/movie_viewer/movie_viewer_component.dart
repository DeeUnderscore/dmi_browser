import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:dmi_read/dmi_read.dart';

import '../icon_render_component.dart';
import '../anim_render_component.dart';
import '../back_button_component.dart';
import '../direction_name_pipe.dart';

@Component(
    selector: 'movie-viewer',
    templateUrl: 'movie_viewer_component.html',
    styleUrls: const [
      '../../lib/movie_viewer/movie_viewer_component.css'
    ],
    pipes: const [
      DirectionNamePipe
    ],
    directives: const [
      ROUTER_DIRECTIVES,
      IconRenderComponent,
      AnimationRenderComponent,
      BackButtonComponent
    ])
class MovieViewerComponent {
  @Input()
  DmiState state;
}

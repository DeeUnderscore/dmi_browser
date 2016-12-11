import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'load/load_component.dart';
import 'overview/overview_component.dart';
import 'state/state_component.dart';
import 'read_wrapper_service.dart';
import 'movie_viewer/movie_icon_viewer_component.dart';

@Component(
    selector: 'dmi-browser',
    template: '<router-outlet></router-outlet>',
    directives: const [
      ROUTER_DIRECTIVES
    ],
    providers: const [
      ReadWrapperService,
      ROUTER_PROVIDERS,
      const Provider(LocationStrategy, useClass: HashLocationStrategy)
    ])
@RouteConfig(const [
  const Route(
      name: 'Load', path: '', component: LoadComponent, useAsDefault: true),
  const Route(name: 'Overview', path: '/view', component: OverviewComponent),
  const Route(name: 'State', path: '/view/:name', component: StateComponent),
  const Route(
      name: 'MovieIcon',
      path: '/view/:name/:direction/:iconNum',
      component: MovieIconViewerComponent)
])
class DmiBrowserComponent {}

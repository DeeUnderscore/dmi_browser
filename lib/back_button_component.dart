import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart' show Location;


/// A simple back button
@Component(
    selector: 'back-button',
    template: '<button id="back" (click)="back()">Back</button>')
class BackButtonComponent {
  final Location _location;

  BackButtonComponent(this._location);

  void back() => _location.back();
}

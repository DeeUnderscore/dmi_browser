import 'package:angular2/core.dart';

import 'package:dmi_read/dmi_read.dart';

/// Direction name as a string from a [IconDirection] valuse
@Pipe(name: 'dirName')
class DirectionNamePipe {
  String transform(IconDirection dir) {
    switch (dir) {
      // everything is a return, breaks are omitted!
      case IconDirection.none:
        return 'No direction';
      case IconDirection.south:
        return 'South';
      case IconDirection.north:
        return 'North';
      case IconDirection.east:
        return 'East';
      case IconDirection.west:
        return 'West';
      case IconDirection.southeast:
        return 'Southeast';
      case IconDirection.southwest:
        return 'Southwest';
      case IconDirection.northeast:
        return 'Northeast';
      case IconDirection.northwest:
        return 'Northwest';
    }

    return ''; // Should be unreachable
  }
}

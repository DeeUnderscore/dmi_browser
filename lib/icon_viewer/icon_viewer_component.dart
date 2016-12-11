import 'dart:html' show ImageData;

import 'package:angular2/core.dart';

import 'package:dmi_read/dmi_read.dart';
import 'package:image/image.dart';

import '../back_button_component.dart';

/// Possible zoom levels
const gZoomLevels = const [100, 200, 300, 500];

/// Initial zoom when the icon is first opened
///
/// Value is an index into the zooms list
const initZoomIndex = 2;

/// Zoomable view of a single icon
@Component(
    selector: 'icon-viewer',
    templateUrl: 'icon_viewer_component.html',
    styleUrls: const ['../../lib/icon_viewer/icon_viewer_component.css'],
    directives: const [BackButtonComponent])
class IconViewerComponent implements OnInit {
  @Input() DmiIcon icon;
  List<ImageData> _cachedZooms = new List(gZoomLevels.length);
  @ViewChild('canvas') ElementRef canvasWrapped;
  final List<int> zoomLevels = gZoomLevels;
  int currentZoomIndex = initZoomIndex;

  void ngOnInit(){
    setZoom(currentZoomIndex);
  }

  /// Set the canvas to given zoom level
  void setZoom(int index) {
    final zoom = zoomAtIndex(index);
    final canvas = canvasWrapped.nativeElement;
    currentZoomIndex = index;

    canvas.width = zoom.width;
    canvas.height = zoom.height;

    canvas.context2D.putImageData(zoom, 0, 0);
  }

  /// Generate cached zoomed [ImageData] for zoom level at [index]
  ImageData _generateZoomLevel(int index){
    final canvas = canvasWrapped.nativeElement;

    //TODO: Switch to native browser resizes and abandon Image
    final zoomedImage = copyResize(icon.image, zoomLevels[index], -1, NEAREST);

    final imageData = canvas.context2D.createImageData(zoomedImage.width, zoomedImage.height)
    ..data.setAll(0, zoomedImage.getBytes());

    _cachedZooms[index] = imageData;
    return imageData;
  }

  ImageData zoomAtIndex(int index) => _cachedZooms[index] ?? _generateZoomLevel(index);
}

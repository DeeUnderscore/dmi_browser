import 'dart:html';

import 'package:angular2/core.dart';

import 'package:image/image.dart';

/// Component for rendering an [Image] on a canvas
@Component(
  template: '<canvas #canvas></canvas>',
  selector: 'icon-component')
class IconRenderComponent implements OnInit {
  @Input() Image image;
  @ViewChild('canvas') ElementRef canvasWrapped;

  /// Draw [_image] onto associated canvas
  void drawImage(){
    CanvasElement canvas = canvasWrapped.nativeElement;
    canvas.width = image.width;
    canvas.height = image.height;
    ImageData imageData = canvas.context2D.createImageData(image.width, image.height)
      ..data.setAll(0, image.getBytes());

    canvas.context2D.putImageData(imageData, 0, 0);
  }

  void ngOnInit() => drawImage();
}

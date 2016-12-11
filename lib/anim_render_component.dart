import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';

import 'package:dmi_read/dmi_read.dart';

/// Component for rendering an animated [DmiIcon]
@Component(template: '<canvas #canvas></canvas>', selector: 'anim-component')
class AnimationRenderComponent implements OnInit {
  @Input()
  List<DmiIcon> icons;

  @Input()
  List<int> timing;

  @ViewChild('canvas')
  ElementRef canvasWrapped;

  List<ImageData> _frames;

  /// Populate [_frames] with the icons
  void cacheFrames() {
    final CanvasElement canvas = canvasWrapped.nativeElement;
    final firstImage = icons.first.image;
    canvas.width = firstImage.width;
    canvas.height = firstImage.height;

    for (var i = 0; i < icons.length; i++) {
      final image = icons[i].image;
      _frames[i] = canvas.context2D.createImageData(image.width, image.height)
        ..data.setAll(0, image.getBytes());
    }
  }

  /// Draw frame with index [index] to the canvas
  void drawFrame(int index) =>
      canvasWrapped.nativeElement.context2D.putImageData(_frames[index], 0, 0);

  /// Run the animation once
  ///
  /// Assumes frames are cached
  Future<Null> runAnim() async {
    // animationFrame gives us a timer in miliseconds
    num lastTime = await window.animationFrame;
    int currentFrame = 0;
    drawFrame(currentFrame);

    while (true) {
      num timeNow = await window.animationFrame;
      if(timeNow > lastTime + deciToMili(timing[currentFrame])) {
        if(currentFrame == timing.length-1){
          // loop around
          currentFrame = 0;
        } else {
          currentFrame += 1;
        }
        drawFrame(currentFrame);

        lastTime = timeNow;
      }
    }
  }

  Future<Null> ngOnInit() async {
    _frames = new List(icons.length);
    cacheFrames();

    // timing will be null if it's a single-frame movie
    if(timing != null && timing.length > 1) {
      await runAnim();
    } else {
      // We shouldn't be trying to render static images with this, but let's
      // log an error and render anyway since we're here
      window.console.error('Was asked to animate an animation of one frame');
      drawFrame(0);
    }
  }
}

/// Convert deci(seconds) to mili(seconds)
int deciToMili(int deci) => deci * 100;

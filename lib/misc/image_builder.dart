import 'package:image/image.dart';
import 'package:http/http.dart' as http;

class ImageBuilder {

  Image _image;

  ImageBuilder(int width, int height){
    _image = new Image(width, height);
  }

  Image build(){
    return _image;
  }

  ImageBuilder loadImage(String url){

    var data = http.readBytes(url);

    data.then((buffer) {
      _image = decodeImage(buffer);
    }
    );
    return this;
  }

  ImageBuilder resize(int size)
  {
    _image = copyResize(_image, size);
    return this;
  }
}
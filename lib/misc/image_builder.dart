
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

class ImageBuilder {

  Image _image;

  ImageBuilder(int width, int height){
    _image = new Image(width, height);
  }

  Image build(){
    return _image;
  }

  ImageBuilder load(String url){

    loadImage(url).then((data){

      _image = decodeImage(data);

    });

    return this;
  }

  Future<Uint8List> loadImage(String url) async{

    HttpClient client = new HttpClient();
    Uri resolved = Uri.base.resolve(url);
    HttpClientRequest clientRequest = await client.getUrl(resolved);
    HttpClientResponse response = await clientRequest.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);

//    var data = http.readBytes(url);
//
//    data.then((buffer) {
//      _image = decodeImage(buffer);
//    }
//    );
    return bytes;
  }

  ImageBuilder resize(int size)
  {
    _image = copyResize(_image, size);
    return this;
  }


}
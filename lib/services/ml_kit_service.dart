import 'package:face_net_authentication/services/camera.service.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';

//A singleton is created(one instance of the class is created)
class MLKitService {
  static final MLKitService _cameraServiceService = MLKitService._internal();
  //returns the cached instance on every future invocation and is not allowed to create a new one.
  factory MLKitService() {
    return _cameraServiceService;
  }
  // singleton constructor
  MLKitService._internal();

  // service injection
  CameraService _cameraService = CameraService();

  FaceDetector _faceDetector;
  FaceDetector get faceDetector => this._faceDetector;

  //The face that we detect must be accurate,get all the contours and key features of face
  void initialize() {
    this._faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
  }

// preprocess the image
  Future<List<Face>> getFacesFromImage(CameraImage image) async {
    InputImageData _firebaseImageMetadata = InputImageData(
      imageRotation: _cameraService.cameraRotation,
      //Need the image in raw format RGBA
      inputImageFormat: InputImageFormatMethods.fromRawValue(image.format.raw),

      size: Size(image.width.toDouble(), image.height.toDouble()),
      //The image
      planeData: image.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );

    // Transform the image input for the faceDetector
    InputImage _firebaseVisionImage = InputImage.fromBytes(
      bytes: image.planes[0].bytes,
      inputImageData: _firebaseImageMetadata,
    );

    // process the image and makes inference
    List<Face> faces =
        await this._faceDetector.processImage(_firebaseVisionImage);
    return faces;
  }
}

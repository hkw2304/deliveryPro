import 'dart:io';

import 'package:deliveryproject/create/create_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Create_post extends StatefulWidget {
  const Create_post({super.key});

  State<Create_post> createState() => _Create_postState();
}

class _Create_postState extends State<Create_post> {
  final model = CreateModel();
  final picker = ImagePicker();
  bool isLoading = false;

  final _menu = TextEditingController();
  final _storeTitleCtr = TextEditingController();
  final _menu1TitleCtr = TextEditingController();
  final _menu2TitleCtr = TextEditingController();
  final _menu3TitleCtr = TextEditingController();
  final _price1Ctr = TextEditingController();
  final _price2Ctr = TextEditingController();
  final _price3Ctr = TextEditingController();
  final _deliveryCtr = TextEditingController();
  final _leastMoneyCtr = TextEditingController();

  List<File> _images = [];

  void dispose() {
    _storeTitleCtr.dispose();
    _menu1TitleCtr.dispose();
    _menu2TitleCtr.dispose();
    _menu3TitleCtr.dispose();
    _price1Ctr.dispose();
    _price2Ctr.dispose();
    _price3Ctr.dispose();
    _deliveryCtr.dispose();
    _leastMoneyCtr.dispose();
    _menu.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가게 등록'),
        actions: [
          IconButton(
            onPressed: () async {
              if (_images != null) {
                setState(() {
                  isLoading = true;
                });

                await model.uploadPost(
                  _images!,
                  _menu.text,
                  _storeTitleCtr.text,
                  _menu1TitleCtr.text,
                  _menu2TitleCtr.text,
                  _menu3TitleCtr.text,
                  _price1Ctr.text,
                  _price2Ctr.text,
                  _price3Ctr.text,
                  _deliveryCtr.text,
                  _leastMoneyCtr.text,
                );

                setState(() {
                  isLoading = false;
                });

                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Expanded(
                child: Column(
                  children: [
                    if (isLoading) const CircularProgressIndicator(),
                    ElevatedButton(
                      onPressed: () async {
                        getImages();
                      },
                      child: Text('이미지 선택!'),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 300.0, // To show images in particular area only
                        child: _images.isEmpty // If no images is selected
                            ? const Center(
                                child: Text('Sorry nothing selected!!'))
                            // If atleast 1 images is selected
                            : GridView.builder(
                                itemCount: _images.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,

                                  // Horizontally only 3 images will show
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  // TO show selected file
                                  return Center(
                                    // kIsWeb : 플랫폼이 웹인지아닌지 판별해서 구동
                                    child: kIsWeb
                                        ? Image.network(_images[index].path)
                                        : Image.file(_images[index]),
                                  );
                                  // If you are making the web app then you have to
                                  // use image provider as network image or in
                                  // android or iOS it will as file only
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextField(
                      controller: _menu,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        labelText: '메뉴',
                        prefixIcon: const Icon(
                          Icons.arrow_right_outlined,
                          size: 30.0,
                          color: Colors.green,
                        ),
                        prefixText: ' ',
                        suffixText: '입력',
                        suffixStyle: const TextStyle(color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _storeTitleCtr,
                      decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        labelText: '가게이름',
                        prefixIcon: const Icon(
                          Icons.arrow_right_outlined,
                          size: 30.0,
                          color: Colors.green,
                        ),
                        prefixText: ' ',
                        suffixText: '입력',
                        suffixStyle: const TextStyle(color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _menu1TitleCtr,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '첫번째 메뉴',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _price1Ctr,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '1번 음식 가격',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _menu2TitleCtr,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '두번째 메뉴',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _price2Ctr,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '2번 음식 가격',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _menu3TitleCtr,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '세번째 메뉴',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _price3Ctr,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '3번 음식 가격',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _deliveryCtr,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '배달시간',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _leastMoneyCtr,
                      decoration: new InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          labelText: '최소금액',
                          prefixIcon: const Icon(
                            Icons.arrow_right_outlined,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          prefixText: ' ',
                          suffixText: '입력',
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
        maxHeight: 200, // To set maxheight of images that you want in your app
        maxWidth: 200); // To set maxheight of images that you want in your app
    List<XFile> xfilePick = pickedFile;

    // if atleast 1 images is selected it will add
    // all images in selectedImages
    // variable so that we can easily show them in UI
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        _images.add(File(xfilePick[i].path));
      }
      setState(
        () {},
      );
    } else {
      // If no image is selected it will show a
      // snackbar saying nothing is selected
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }
}

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:app_kinh_thanh/common/share_color.dart';
import 'package:app_kinh_thanh/models/bible_model.dart';
import 'package:app_kinh_thanh/screens/home_sceen/controller/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin {
  DateTime _date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  //controller
  final _controller = Get.put(HomeController());
  //
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _controller.getBibles(_date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShareColors.kWhite,
      appBar: _buildAppbar(),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Ngày ${DateFormat('dd/MM/yyyy').format(_date)}',
                  style: const TextStyle(
                    fontSize: 18,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(
                () {
                  //final bibleModel = _controller.getCurrentBible(_date);
                  if (_controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // if (_controller.bible.value) {
                  //   return Center(child: Text('No bibles available'));
                  // }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '${_controller.bible.value.title}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Kinh thánh: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: _controller.bible.value.bible ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Câu gốc: ',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: _controller.bible.value.original ?? "",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Câu hỏi suy ngẫm: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: _controller.bible.value.thought ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Cầu nguyện: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: _controller.bible.value.pray ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Đọc kinh thánh trong ba năm: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: _controller.bible.value.end ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: ShareColors.kPrimaryColor,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _date = (_date.subtract(const Duration(days: 1)));
                  _controller.getBibles(_date);
                });
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_circle_outline,
              ),
            ),
            IconButton(
              onPressed: () {
                _selectDate();
              },
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _date = (_date.add(const Duration(days: 1)));
                  _controller.getBibles(_date);
                });
              },
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      elevation: 0,
      child: ListView(
        //padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ShareColors.kPrimaryColor,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Bài Học Kinh Thánh Hằng Ngày',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: ShareColors.kWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.menu_book_outlined),
            title: const Text('Bài học'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: const Text('Cài đặt'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: const Text('Email phản hồi'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share_outlined),
            title: const Text('Chia sẻ'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: const Text('Giới thiệu'),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _date = picked;
        _controller.getBibles(_date);
      });
    }
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ShareColors.kPrimaryColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.share,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.zoom_in,
          ),
        ),
      ],
    );
  }
}

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:app_kinh_thanh/common/share_color.dart';
import 'package:app_kinh_thanh/controllers/network_controller.dart';
import 'package:app_kinh_thanh/main.dart';
import 'package:app_kinh_thanh/models/bible_model.dart';
import 'package:app_kinh_thanh/screens/home_sceen/controller/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin {
  //
  //
  late Stream<List<BibleModel>> streamBible;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  DateTime _date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  //audio
  final player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final secound = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${secound.toString().padLeft(2, '0')}";
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  //controller
  final _controller = Get.put(HomeController());
  final _controllerConnect = Get.find<NetworkController>();
  //
  double _fontSize = 16;
  bool _showSlider = false;
  bool _showAudio = false;

  //
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await _controller.getBibles(_date);
    //streamBible = objectBox.getBibles();

    final url = _controller.bible.value.audio ?? '';
    url.isNotEmpty
        ? player.setUrl(url)
        : player.setAsset('assets/audio/empty.mp3');
    player.positionStream.listen(
      (p) {
        setState(() => position = p);
      },
    );
    player.durationStream.listen(
      (d) {
        setState(() => duration = d!);
      },
    );
    player.playerStateStream.listen(
      (state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            position = Duration.zero;
          });
          player.pause();
          player.seek(position);
        }
      },
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: ShareColors.kWhite,
      appBar: _buildAppbar(),
      drawer: _buildDrawer(),
      body: _buildNetwork(),
      bottomNavigationBar: Container(
        color: ShareColors.kPrimaryColor,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () async {
                setState(() {
                  _showAudio = false;
                  _date = (_date.subtract(const Duration(days: 1)));
                });
                await _controller.getBibles(_date);
                final newUrl = _controller.bible.value.audio ?? '';
                newUrl.isNotEmpty
                    ? player.setUrl(newUrl)
                    : player.setAsset('assets/audio/empty.mp3');
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _showAudio = !_showAudio;
                });
              },
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
              onPressed: () async {
                setState(() {
                  _showAudio = false;
                  _date = (_date.add(const Duration(days: 1)));
                });
                await _controller.getBibles(_date);
                final newUrl = _controller.bible.value.audio ?? '';
                newUrl.isNotEmpty
                    ? player.setUrl(newUrl)
                    : player.setAsset('assets/audio/empty.mp3');
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

  Widget _buildNetwork() {
    return Obx(
      () => _controllerConnect.isConnected.value
          ? _buildBodyNetwork()
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 80),
                  Text('Lỗi kết nối mạng!'),
                ],
              ),
            ),
    );
  }

  Stack _buildBodyNetwork() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Ngày ${DateFormat('dd/MM/yyyy').format(_date)}',
                    style: TextStyle(
                      fontSize: _fontSize + 1,
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
                    return BodyItemWidget(
                      bible: _controller.bible.value,
                      fontSize: _fontSize,
                    );
                  },
                )
              ],
            ),
          ),
        ),
        // Thanh slider cố định
        if (_showSlider)
          Positioned(
            top: 20, // Dưới app bar
            left: 0,
            right: 0,
            child: Container(
              color: Colors.blue, // Nền màu để slider nổi bật
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Slider(
                value: _fontSize,
                min: 10,
                max: 50,
                divisions: 40,
                label: _fontSize.toStringAsFixed(0),
                onChanged: (double value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ),
          ),
        if (_showAudio)
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: handlePlayPause,
                    icon: Icon(
                      player.playing ? Icons.pause : Icons.play_arrow,
                      size: 50,
                    ),
                  ),
                  Text(formatDuration(position)),
                  Slider(
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: handleSeek,
                  ),
                  Text(formatDuration(duration)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Stack _buildBodyLocal() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Ngày ${DateFormat('dd/MM/yyyy').format(_date)}',
                    style: TextStyle(
                      fontSize: _fontSize + 1,
                    ),
                  ),
                ),
                StreamBuilder<List<BibleModel>>(
                  stream: streamBible,
                  builder: (context, snapshot) {
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
        // Thanh slider cố định
        if (_showSlider)
          Positioned(
            top: 20, // Dưới app bar
            left: 0,
            right: 0,
            child: Container(
              color: Colors.blue, // Nền màu để slider nổi bật
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Slider(
                value: _fontSize,
                min: 10,
                max: 50,
                divisions: 40,
                label: _fontSize.toStringAsFixed(0),
                onChanged: (double value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ),
          ),
        if (_showAudio)
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: handlePlayPause,
                    icon: Icon(
                      player.playing ? Icons.pause : Icons.play_arrow,
                      size: 50,
                    ),
                  ),
                  Text(formatDuration(position)),
                  Slider(
                    min: 0.0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: handleSeek,
                  ),
                  Text(formatDuration(duration)),
                ],
              ),
            ),
          ),
      ],
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
            leading: const Icon(FontAwesomeIcons.bible),
            title: const Text('Bài học'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.music),
            title: const Text('Thánh ca'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Cài đặt'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Email phản hồi'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Chia sẻ'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
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
          onPressed: () {
            setState(() {
              _showSlider = !_showSlider;
            });
          },
          icon: const Icon(
            Icons.zoom_in,
          ),
        ),
      ],
    );
  }
}

class BodyItemWidget extends StatelessWidget {
  const BodyItemWidget({
    super.key,
    required BibleModel bible,
    required double fontSize,
  })  : _bible = bible,
        _fontSize = fontSize;

  final BibleModel _bible;
  final double _fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              '${_bible.id}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: _fontSize + 5,
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
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: _bible.bible ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _fontSize,
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
                    fontSize: _fontSize,
                  ),
                ),
                TextSpan(
                  text: _bible.original ?? "",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: _fontSize,
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
                    fontSize: _fontSize,
                  ),
                ),
                TextSpan(
                  text: _bible.thought ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _fontSize,
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
                    fontSize: _fontSize,
                  ),
                ),
                TextSpan(
                  text: _bible.pray ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _fontSize,
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
                    fontSize: _fontSize,
                  ),
                ),
                TextSpan(
                  text: _bible.end ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: _fontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

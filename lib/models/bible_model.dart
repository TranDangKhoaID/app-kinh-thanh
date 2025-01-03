import 'package:json_annotation/json_annotation.dart';

part 'bible_model.g.dart';

@JsonSerializable()
class BibleModel {
  int? id;
  String? title;
  String? bible;
  String? original;
  String? thought;
  String? pray;
  String? end;
  String? audio;
  DateTime? dateTime;

  BibleModel({
    this.id,
    this.title,
    this.bible,
    this.original,
    this.thought,
    this.pray,
    this.end,
    this.audio,
    this.dateTime,
  });

  factory BibleModel.fromJson(Map<String, dynamic> json) =>
      _$BibleModelFromJson(json);
  Map<String, dynamic> toJson() => _$BibleModelToJson(this);
}

List<BibleModel> bibles = [
  BibleModel(
    id: 1,
    title: 'Xin Dạy Chúng Con Cầu Nguyện – 2/1/2025',
    bible: 'Ma-thi-ơ 6:9-13',
    original:
        '“Khi ngươi cầu nguyện, hãy vào phòng riêng, đóng cửa lại, rồi cầu nguyện Cha ngươi, ở nơi kín nhiệm đó; và Cha ngươi là Đấng thấy trong chỗ kín nhiệm, sẽ thưởng cho ngươi” (Ma-thi-ơ 6:6).',
    thought:
        '''Trong Ma-thi-ơ 6:9-13, Chúa Giê-xu đưa ra khuôn mẫu tổng quát về nội dung lời cầu nguyện, trước hết hướng về Đức Chúa Trời, sau đó hướng về chúng ta. Con dân Chúa có đặc ân vô cùng lớn được gọi Đức Chúa Trời là “Cha”. Từ ngữ “chúng con” suốt bài cầu nguyện nhấn mạnh đến tập thể hơn là chỉ chú trọng đến cá nhân. Cơ Đốc nhân được đặc ân gọi Đức Chúa Trời là Cha do sự chết đền tội của Chúa Giê-xu. Cụm từ “ở trên trời” nhắc nhở Ngài là Đấng siêu việt, vượt trên mọi loài thọ tạo. Đấng thấy trong chỗ kín nhiệm, biết rõ tấm lòng và đáp lời cầu xin. Chúng ta được khuyến khích dạn dĩ đến gần Chúa, nhưng phải đến với lòng tôn kính (Hê-bơ-rơ 4:14-16).

Đối với Chúa, Ngài vốn thánh khiết, “Danh Cha được tôn thánh” (BTTHĐ), vì thế lời cầu khẩn nhắc chúng ta dùng đời sống mình làm vinh hiển Danh Chúa (I Cô-rinh-tô 10:31). Lời cầu nguyện “Nước Cha… ở đất như trời” bày tỏ Vương quốc của Chúa là nơi Chúa cai trị. Hiện nay, Vương quốc Chúa là vô hình, qua sự ngự trị của Đức Thánh Linh trong lòng các tín hữu (I Cô-rinh-tô 6:19).

Đối với con người, cầu “xin cho chúng con hôm nay đồ ăn đủ ngày” nhắc nhở rằng Chúa là Đấng ban phước vật chất để chúng ta có lòng biết ơn Chúa, chớ tự mãn, kiêu căng khi được thịnh vượng, giàu sang (Phục Truyền 8:17-18). Mặt khác, cũng đừng quá lo lắng về nhu cầu vật chất (Ma-thi-ơ 10:29-31).

Khi cầu nguyện “Xin tha tội lỗi cho chúng con, như chúng con cũng tha kẻ phạm tội nghịch cùng chúng con”, nhắc nhở chúng ta về mối tương giao giữa mình với Chúa và với người khác. Tội lỗi là nguyên nhân chính gây đổ vỡ các mối tương giao này. Chúng ta cần thường xuyên thành tâm xét mình, xưng tội (I Giăng 1:8-9) và có lòng tha thứ ai làm tổn hại mình (Ma-thi-ơ 6:14-15). Khi cầu nguyện “Xin chớ để chúng con bị cám dỗ mà cứu chúng con khỏi điều ác”, nhắc nhở chúng ta cảnh giác về sự cám dỗ của ma quỷ, là kẻ luôn rình rập để gây tổn hại cho con dân Chúa. Lời Chúa khích lệ chúng ta hãy đứng vững trong đức tin vào quyền năng của Chúa mà kháng cự nó (I Phi-e-rơ 5:8-9).

Chúa Giê-xu đã đưa ra khuôn mẫu để dạy chúng ta biết cầu nguyện với Đức Chúa Cha cách phải lẽ, đẹp lòng Ngài. Trong lúc cầu nguyện phải bày tỏ lòng tôn kính và tin cậy nơi Chúa. Chúng ta phải thường xuyên xét mình, xưng tội; cảnh giác về vô vàn cám dỗ với nhiều hình thức gây tổn hại cho chính mình, người khác và làm buồn lòng Chúa.

Bạn có thường xuyên cầu nguyện theo khuôn mẫu Chúa dạy không?
              ''',
    pray:
        'Lạy Cha kính yêu, tạ ơn Cha đã dạy con cầu nguyện. Xin mở mắt con để con thấy giờ phút tương giao bên Cha là giờ phút ngọt ngào đầy phước hạnh. Xin cho con luôn sống trong mối tương giao với Cha trên trời. Nhân Danh Đức Chúa Giê-xu Christ, Amen! ',
    end: 'Thi Thiên 27-28',
    dateTime: DateTime(2025, 1, 2),
  ),
  BibleModel(
    id: 2,
    title: 'Chúa Thấy, Nghe, Biết – 31/12/2024',
    bible: 'Xuất Ê-díp-tô Ký 3:1-10',
    original: 'Khoa 31',
    thought: 'K 31',
    pray: 'K bar',
    end: 'I Sa-mu-ên 31',
    dateTime: DateTime(2024, 12, 31),
  ),
  BibleModel(
    id: 3,
    title: 'Chúa Thấy, Nghe, Biết – 31/12/2024',
    bible: 'Xuất Ê-díp-tô Ký 3:1-10',
    original: 'Khoa 30',
    thought: 'K 30',
    pray: 'K bar',
    end: 'I Sa-mu-ên 31',
    dateTime: DateTime(2024, 12, 30),
  ),
];

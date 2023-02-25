/// VideoShort is used for returning object in getInfo() which will have the videoUrl

class VideoDetailModel {
  String? encodeID;
  String? title;
  String? artistsNames;
  String? thumbnailM;
  List? genreIds;
  String? albumId;
  List? artistsId;
  String? videoUrl;

  VideoDetailModel({
    this.encodeID,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.videoUrl,
    this.albumId,
    this.artistsId,
  });

  factory VideoDetailModel.fromJson(Map<String, dynamic> json) {
    // To get the best resolution available
    // Video url could be 128p, 360p, 480p, 720p, 1080p

    final videosUrl = json["streaming"]["mp4"] as Map<String, dynamic>;
    // print(videosUrl.keys);
    final videoUrl = videosUrl[videosUrl.keys.last];

    return VideoDetailModel(
      encodeID: json["encodeId"],
      title: json["title"],
      artistsNames: json["artistsNames"],
      thumbnailM: json["thumbnailM"],
      genreIds: json["genres"]?.map((genre) => genre["id"]).toList(),
      albumId: json["album"]?["id"],
      artistsId: json["artists"]?.map((artist) => artist["id"]).toList(),
      videoUrl: videoUrl,
    );
  }
  Map<String, dynamic> toJson() => {
        "encodeId": encodeID,
        "title": title,
        "artistsNames": artistsNames,
        "thumbnailM": thumbnailM,
        "genreIds": genreIds,
        "albumId": albumId,
        "artistsId": artistsId,
        "videoUrl": videoUrl,
      };
}

final sampleVideo = VideoDetailModel(
  encodeID: "ZW6CO0FA",
  title: "Khi Phải Quên Đi",
  artistsNames: "Phan Mạnh Quỳnh",
  thumbnailM:
      "https://photo-resize-zmp3.zmdcdn.me/w600_r300x169_jpeg/thumb_video/0/6/06b8b0c81dc95cbe5d1c764b6dc14b87_1405155254.jpg",
  genreIds: ["IWZ9Z08I", "IWZ97FCD"],
  albumId: null,
  artistsId: ["IWZ98O7W"],
  videoUrl:
      "https://mcloud-bf-s7-mv-zmp3.zmdcdn.me/ui7rMG5AUsU/cc6c77fdfab913e74aa8/ad3fdbd8c89d21c3788c/1080/Khi-Phai-Quen-Di.mp4?authen=exp=1677223978~acl=/ui7rMG5AUsU/*~hmac=7be8ff50f523296e6af737e2e7a3d859",
);
final List<VideoDetailModel> sampleVideoList = [
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
];

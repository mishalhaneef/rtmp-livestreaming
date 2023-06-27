class StreamCoverModel {
  String streamerName;
  String streamerProfilePicture;
  String viewCount;
  String thumbnail;
  String title;
  StreamCoverModel({
    required this.streamerName,
    required this.streamerProfilePicture,
    required this.viewCount,
    required this.thumbnail,
    required this.title,
  });
}

List<StreamCoverModel> streamersList = [
  StreamCoverModel(
    streamerName: 'Ashley Phan',
    streamerProfilePicture:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrwG-H7B4LxQcQXIbSluMBFLCkE6Zqo_yIkA&usqp=CAU',
    viewCount: '290',
    thumbnail:
        'https://socialpubli.com/blog/wp-content/uploads/2021/07/professional-smiling-esport-gamer-girl-live-stream-FEF5K7P-scaled.jpg',
    title: 'Hi Guys :))',
  ),
  StreamCoverModel(
    streamerName: 'Pokimane',
    streamerProfilePicture:
        'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    viewCount: '420',
    thumbnail: 'https://images.wsj.net/im-428758/square',
    title: 'Chat With me :))',
  ),
  StreamCoverModel(
    streamerName: 'Kun Ageuro',
    streamerProfilePicture:
        'https://cdn.resfu.com/media/img_news/el-kun-aguero-levanta-la-copa-del-mundo-en-catar-el-18-de-diciembre-de-2022--efe.jpg',
    viewCount: '945',
    thumbnail:
        'https://neoreach.com/wp-content/uploads/2021/06/Top-10-Live-Streamers-from-TikTok-to-Gaming.png',
    title: '7 PM Live :))',
  ),
  StreamCoverModel(
    streamerName: 'Abraham',
    streamerProfilePicture:
        'https://imgv3.fotor.com/images/blog-cover-image/10-profile-picture-ideas-to-make-you-stand-out.jpg',
    viewCount: '566',
    thumbnail:
        'https://cdn.shopify.com/s/files/1/0095/4332/files/Screen_Shot_2018-02-21_at_10.43.11_AM_1024x1024.png?v=1519258577',
    title: 'Game Talks',
  ),
];

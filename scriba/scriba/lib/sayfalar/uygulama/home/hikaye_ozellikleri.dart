class HikayeOzellikleri {
  String? imgUrl;
  String? name;
  String? auther;
  num? score;
  num? review;
  num? view;
  List<String>? type;
  String? desc;

  HikayeOzellikleri(
    this.imgUrl,
    this.name,
    this.auther,
    this.score,
    this.review,
    this.view,
    this.type,
    this.desc,
  );

  static List<HikayeOzellikleri> sizinIcinOnerilenler() {
    return [
      HikayeOzellikleri(
        'assets/images/buyuk-akil.jpg',
        'Büyük Akıl',
        'Serhat Kadak',
        4.0,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri(
        'assets/images/sırali-sırasiz.jpg',
        'Sıralı Sırasız',
        'Serhat Kadak',
        4.7,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri(
        'assets/images/kole-olmayacagiz.jpg',
        'Köle Olmayacağız',
        'Serhat Kadak',
        4.3,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri(
        'assets/images/sandition.jpg',
        'Sandition',
        'Serhat Kadak',
        3.5,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      )
    ];
  }

  static List<HikayeOzellikleri> populerOlanlar() {
    return [
      HikayeOzellikleri(
        'assets/images/buyuk-akil.jpg',
        'Büyük Akıl',
        'Serhat Kadak',
        4.0,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri(
        'assets/images/sırali-sırasiz.jpg',
        'Sıralı Sırasız',
        'Serhat Kadak',
        4.7,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri(
        'assets/images/kole-olmayacagiz.jpg',
        'Köle Olmayacağız',
        'Serhat Kadak',
        4.3,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      ),
      HikayeOzellikleri(
        'assets/images/sandition.jpg',
        'Sandition',
        'Serhat Kadak',
        3.5,
        100.5,
        3.2,
        ['aksiyon', 'fantastik', 'macera'],
        'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss',
      )
    ];
  }
}

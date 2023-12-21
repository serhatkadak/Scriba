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
        'assets/images/kayip-taksiler.png',
        'Kayıp Taksiler',
        'Serhat Kadak',
        4.0,
        100.5,
        3.2,
        ['Macera', 'Modern', 'Sorunsal'],
        'Boş taksi bulamayan Osman bir fikir bulur.',
      ),
      HikayeOzellikleri(
        'assets/images/secenekler-zinciri.png',
        'Seçenekler Zinciri',
        'Ekrem Kaptanlar',
        4.7,
        100.5,
        3.2,
        ['Gizem', 'Opsiyonel', 'Macera'],
        'Ertesi günü sınavı olan bir genç bazı kararlar vermelidir.',
      ),
      HikayeOzellikleri(
        'assets/images/gergin-orman-kosusu.png',
        'Gergin Orman Koşusu',
        'Ekrem Kaptanlar',
        4.3,
        100.5,
        3.2,
        ['Aksiyon', 'Gerilim', 'Macera'],
        "Mangal yapmaya bir ormana giden iki arkadaş, olacaklardan habersizdir.",
      ),
      HikayeOzellikleri(
        'assets/images/sahilsiz-tatil-olmaz.png',
        'Sahilsiz Tatil Olmaz',
        'Serhat Kadak',
        3.5,
        100.5,
        3.2,
        ['Macera', 'Eğlence', 'Opsiyonel'],
        'Tatil yapmak isteyen bir çalışan tatili nerede yapacağı konusunda kararsızdır.',
      )
    ];
  }

  static List<HikayeOzellikleri> populerOlanlar() {
    return [
      HikayeOzellikleri(
        'assets/images/gergin-orman-kosusu.png',
        'Gergin Orman Koşusu',
        'Ekrem Kaptanlar',
        4.3,
        100.5,
        3.2,
        ['Aksiyon', 'Gerilim', 'Macera'],
        'Mangal yapmaya bir ormana giden iki arkadaş, olacaklardan habersizdir.',
      ),
      HikayeOzellikleri(
        'assets/images/secenekler-zinciri.png',
        'Seçenekler Zinciri',
        'Ekrem Kaptanlar',
        4.7,
        100.5,
        3.2,
        ['Gizem', 'Opsiyonel', 'Macera'],
        'Ertesi günü sınavı olan bir genç bazı kararlar vermelidir.',
      ),
      HikayeOzellikleri(
        'assets/images/kayip-taksiler.png',
        'Kayıp Taksiler',
        'Serhat Kadak',
        4.0,
        100.5,
        3.2,
        ['Macera', 'Modern', 'Sorunsal'],
        'Boş taksi bulamayan Osman bir fikir bulur.',
      ),
      HikayeOzellikleri(
        'assets/images/sahilsiz-tatil-olmaz.png',
        'Sahilsiz Tatil Olmaz',
        'Serhat Kadak',
        3.5,
        100.5,
        3.2,
        ['Macera', 'Eğlence', 'Opsiyonel'],
        'Tatil yapmak isteyen bir çalışan tatili nerede yapacağı konusunda kararsızdır.',
      )
    ];
  }
}

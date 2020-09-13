class OnboardData {
  String imgPath;
  String title;
  String desc;

  OnboardData({this.imgPath, this.title, this.desc});

  void setImgPath(String path) {
    imgPath = path;
  }

  void setTitle(String newTitle) {
    title = newTitle;
  }

  void setDesc(String newDesc) {
    desc = newDesc;
  }

  String getImgPath() {
    return imgPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<OnboardData> getOnboardData() {
  List<OnboardData> data = new List<OnboardData>();
  OnboardData onboardData = new OnboardData();

  onboardData.setTitle('Welcome Pomodoro App');
  onboardData.setDesc('');
  onboardData.setImgPath('assets/img/onboard_a.webp');
  data.add(onboardData);

  onboardData = new OnboardData();
  onboardData.setTitle('Pomodoro');
  onboardData.setDesc(
      'Teknik Pomodoro adalah metode manajemen waktu yang dikembangkan oleh Francesco Cirillo pada akhir 1980-an. Teknik ini menggunakan pengatur waktu untuk membagi pekerjaan menjadi beberapa interval, biasanya berdurasi 25 menit, dipisahkan dengan jeda singkat.');
  onboardData.setImgPath('assets/img/onboard_b.webp');
  data.add(onboardData);

  onboardData = new OnboardData();
  onboardData.setTitle('Pomodoro App');
  onboardData
      .setDesc('App untuk membantu tracing logs tasks dengan teknik pomodoro');
  onboardData.setImgPath('assets/img/onboard_c.webp');
  data.add(onboardData);

  return data;
}

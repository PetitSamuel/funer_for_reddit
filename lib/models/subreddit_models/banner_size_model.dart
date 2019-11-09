class BannerSize {
  int h;
  int w;

  BannerSize({this.h, this.w});

  static BannerSize fromJson(List<dynamic> data) {
    if (data == null || data.length < 2) {
      return null;
    }
    return new BannerSize(
      h: data[1],
      w: data[0],
    );
  }
}

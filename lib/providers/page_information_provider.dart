class PageInformationProvider {
  String currentPage = "home";

  PageInformationProvider();

  changeCurrentpage(String page) {
    this.currentPage = page;
  }

  String get current => this.currentPage;
  bool get isOnHomePage => this.currentPage == "home";
  bool get isOnPostPage => this.currentPage == "post";
}

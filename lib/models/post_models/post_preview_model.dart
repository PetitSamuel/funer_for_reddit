class PostPreviewModel {
  List<PostPreviewImage> images;
  bool enabled;

  PostPreviewModel({this.images, this.enabled});

  static PostPreviewModel fromJson(Map<String, dynamic> json) {
    List<PostPreviewImage> images;
    if (json['images'] != null) {
      images = new List<PostPreviewImage>();
      (json['images'] as List).forEach((v) {
        images.add(PostPreviewImage.fromJson(v));
      });
    }
    return new PostPreviewModel(
      enabled: json["enabled"],
      images: images,
    );
  }
}

class PostPreviewImage {
  List<PostPreviewImageResolutions> resolutions;
  PostPreviewImageSource source;
  PostPreviewImageVariants variants;
  String id;

  PostPreviewImage({this.resolutions, this.source, this.variants, this.id});

  static PostPreviewImage fromJson(Map<String, dynamic> json) {
    List<PostPreviewImageResolutions> resolutions;
    if (json['resolutions'] != null) {
      resolutions = new List<PostPreviewImageResolutions>();
      (json['resolutions'] as List).forEach((v) {
        resolutions.add(PostPreviewImageResolutions.fromJson(v));
      });
    }
    PostPreviewImageSource source = json['source'] != null
        ? PostPreviewImageSource.fromJson(json['source'])
        : null;
    PostPreviewImageVariants variants = json['variants'] != null
        ? PostPreviewImageVariants.fromJson(json['variants'])
        : null;
    return new PostPreviewImage(
      id: json['id'],
      resolutions: resolutions,
      source: source,
      variants: variants,
    );
  }
}

class PostsFeedDataChildrenDataPreviewImagesVariants {
  PostsFeedDataChildrenDataPreviewImagesVariants();

  PostsFeedDataChildrenDataPreviewImagesVariants.fromJson(
      Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class PostPreviewImageVariants {
  PostPreviewImageVariants();

  static PostPreviewImageVariants fromJson(Map<String, dynamic> json) {
    return new PostPreviewImageVariants();
  }
}

class PostPreviewImageSource {
  int width;
  String url;
  int height;

  PostPreviewImageSource({this.width, this.url, this.height});

  static PostPreviewImageSource fromJson(Map<String, dynamic> json) {
    return new PostPreviewImageSource(
      width: json['width'],
      url: json["url"],
      height: json["height"],
    );
  }
}

class PostPreviewImageResolutions {
  int width;
  String url;
  int height;

  PostPreviewImageResolutions({this.width, this.url, this.height});

  static PostPreviewImageResolutions fromJson(Map<String, dynamic> json) {
    return new PostPreviewImageResolutions(
      width: json['width'],
      url: json['url'],
      height: json['height'],
    );
  }
}

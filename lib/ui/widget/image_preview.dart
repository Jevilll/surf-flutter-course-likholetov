import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_icons.dart';

/// Загружает картинку из сети.
class ImagePreview extends StatelessWidget {
  final String imgUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ImagePreview({
    Key? key,
    required this.imgUrl,
    this.height = double.infinity,
    this.width = double.infinity,
    this.borderRadius,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imgUrl,
      imageBuilder: (_, imageProvider) => _ImageBuilder(
        imageProvider: imageProvider,
        fit: fit,
        borderRadius: borderRadius,
      ),
      placeholder: (_, __) => const _ImagePlaceholder(),
      // ignore: implicit_dynamic_parameter
      errorWidget: (_, __, ___) => const _ImagePlaceholder(),
    );

    return child;

  }
}

/// Загруженная картинка из сети
class _ImageBuilder extends StatelessWidget {
  final ImageProvider imageProvider;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const _ImageBuilder({
    Key? key,
    required this.imageProvider,
    required this.fit,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    );
  }
}

/// Плейсхолдер на время загрузки и если есть ошибка
class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AppIcons.photo,
        width: 64,
        height: 64,
        color: AppColors.inactiveBlack,
      ),
    );
  }
}

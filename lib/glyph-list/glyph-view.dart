import 'package:app/glyph-details/bloc.dart';
import 'package:app/glyphs/functions.dart';
import 'package:app/glyphs/glyph.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class GlyphViewModel extends Equatable {
  const GlyphViewModel();

  @override
  List<Object?> get props => [];
}

class GlyphViewBloc extends Cubit<GlyphViewModel> {
  factory GlyphViewBloc.fromContext(BuildContext context) {
    return GlyphViewBloc(
      context.read<GlyphDetailsBloc>(),
    );
  }

  final GlyphDetailsBloc _glyphDetailsBloc;

  final focusNode = FocusNode();

  GlyphViewBloc(this._glyphDetailsBloc)
      : super(
          const GlyphViewModel(),
        );

  @override
  Future<void> close() async {
    focusNode.dispose();
    await super.close();
  }

  void onFocusChange(bool isFocused, Glyph glyph) {
    if (isFocused) {
      _glyphDetailsBloc.showDetailsForGlyph(glyph);
    } else {
      _glyphDetailsBloc.hideDetails();
    }
  }
}

class GlyphViewBuilder extends StatelessWidget {
  final Glyph glyph;
  final Widget Function(BuildContext context, Glyph glyph) glyphContentBuilder;

  const GlyphViewBuilder({
    super.key,
    required this.glyph,
    required this.glyphContentBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlyphViewBloc>(
      create: GlyphViewBloc.fromContext,
      child: BlocBuilder<GlyphViewBloc, GlyphViewModel>(
        builder: (context, viewModel) {
          return GlyphView(
            glyph: glyph,
            bloc: context.read<GlyphViewBloc>(),
            glyphContentView: glyphContentBuilder(context, glyph),
          );
        },
      ),
    );
  }
}

class GlyphView extends StatelessWidget {
  final Glyph glyph;
  final GlyphViewBloc bloc;
  final Widget glyphContentView;

  const GlyphView({
    super.key,
    required this.glyph,
    required this.bloc,
    required this.glyphContentView,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      child: InkWell(
        onTap: bloc.focusNode.requestFocus,
        // TODO I'm not sure if this would work if there is another glyph selected
        // onDoubleTap: () {
        //   context.getBloc<GlyphDetailsBloc>().copySelectedGlyphToClipboard();
        // },
        focusNode: bloc.focusNode,
        focusColor: Theme.of(context).colorScheme.tertiary,
        onFocusChange: (isFocused) {
          bloc.onFocusChange(isFocused, glyph);
        },
        child: glyphContentView,
      ),
    );
  }
}

class SquaredGlyphContentView extends StatelessWidget {
  final Glyph glyph;

  const SquaredGlyphContentView({
    super.key,
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        glyph.glyph,
        style: getTextStyleForGlyph(glyph).copyWith(fontSize: 32),
      ),
    );
  }
}

class RectangularGlyphContentView extends StatelessWidget {
  final Glyph glyph;

  const RectangularGlyphContentView({
    super.key,
    required this.glyph,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        glyph.glyph,
        style: getTextStyleForGlyph(glyph).copyWith(fontSize: 18),
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
      ),
    );
  }
}

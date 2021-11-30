// Define um tipo de dado BlocBuilder  que extende um
// tipo genérico que é retornado na função.
import 'package:flutter/material.dart';

typedef BlocBuilder<T> = T Function();
// Define um tipo de dado BlocDisposer que extende um
// tipo genérico que é recebido pela função.
typedef BlocDisposer<T> = Function(T);

// Define uma classe abstrata BlocBase que exige a implementação
// do método dispose
abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  //O construtor da classe provider recede um widget como child
  //Um objeto do tipo BlocBuilder e um método de dispose
  const BlocProvider({
    Key? key,
    required this.child,
    required this.blocBuilder,
    this.blocDispose,
  }) : super(key: key);

  final Widget child;
  final BlocBuilder<T> blocBuilder;
  final BlocDisposer<T>? blocDispose;

  //Define o método create state que retorna uma chamada para
  //o construtor da classe _BlocProviderState<T>()
  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  // O Método of retorna a primeira instância de um elemento que está na pilha
  // e que seja do tipo _BlocProviderInherited
  static T of<T extends BlocBase>(BuildContext context) {
    _BlocProviderInherited<T>? provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>?;
    return provider!.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  late T bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.blocBuilder();
  }

  @override
  void dispose() {
    if (widget.blocDispose != null) {
      widget.blocDispose!(bloc);
    } else {
      bloc.dispose();
    }
    super.dispose();
  }

  // Bloc State Envolve o Bloc em um Inherited para permitir que ele fique
  // disponível no widgets abaixo da árvore através do método of de blocProvider que
  // está disponível aqui uma vez que extende blocprovider
  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child,
    );
  }
}

// Uma classe que extende InheritedWidget, herda funcionalidades
// que tornam mais eficiente a propagação de informações para baixo da árvore
class _BlocProviderInherited<T> extends InheritedWidget {
  final T bloc;
  const _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}

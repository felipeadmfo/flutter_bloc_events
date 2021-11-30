class AppInitializationState {
  AppInitializationState(
      {required this.isInitialized,
      this.isInitializing = false,
      this.progress = 0});

  final bool isInitialized;
  final bool isInitializing;
  final int progress;

  // Quando alteramos um estado, não estamos alterando o valor
  // de suas instâncias, estamos criando outro estado.
  // Ou seja, qualquer alteração de estado é a criação de um novo
  // estado através de factorys

  // Portando para cada evolução de estados implementamos uma
  // factory que retorna uma nova instancia de estado com os
  // dados necessários.

  factory AppInitializationState.notInitialized() {
    return AppInitializationState(isInitialized: false);
  }

  factory AppInitializationState.progressing(int progress) {
    return AppInitializationState(
        isInitialized: progress == 100,
        isInitializing: true,
        progress: progress);
  }

  factory AppInitializationState.initialized() {
    return AppInitializationState(isInitialized: true, progress: 100);
  }
}

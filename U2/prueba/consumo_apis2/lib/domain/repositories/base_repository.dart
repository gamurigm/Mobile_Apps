/// Base Repository Interface
/// 
/// Define métodos comunes para todos los repositorios en la arquitectura limpia.
/// Esto permite una abstracción consistente entre la capa de dominio y la capa de datos.
abstract class BaseRepository<T> {
  /// Obtiene todos los elementos del tipo T
  Future<List<T>> getAll();

  /// Obtiene un elemento por su ID
  Future<T?> getById(String id);
}

/// Processes [T] object with prepared [Operator].
abstract class Processor<T> {
  T process(T input);
}

import '../utility/error.dart';

extension SumExtension<T> on Iterable<T> {
  /// Calculates the sum of the elements in an iterable, optionally using
  /// [selector] to obtain the value to be summed.
  ///
  /// Iterates over the entire iterable, passing each element to the
  /// [selector] function and adding its return value to a running total. Once
  /// iteration is complete, the total is returned.
  ///
  /// The type of the returned total is dependent on the value returned by the
  /// [selector] function. If all values are `int`, the return value of [sum]
  /// will be `int`. If all values are `double`, the return value of [sum] will
  /// be `double`. If all values are `num` or there is a combination of `int`
  /// and `double`, the return value of [sum] will be `num`.
  ///
  /// When the type of the iterable is a numeric primitive (e.g. `int`,
  /// `double`, or `num`), the [selector] function can be omitted. If so,
  /// the elements themselves are added to the running total.
  ///
  /// If the type of the iterable is not a numeric primitive, the [selector]
  /// function must be provided. Otherwise, a [StateError] is thrown.
  ///
  /// Example:
  ///
  ///     void main() {
  ///       final listA = [1, 2, 3, 4];
  ///       final result = list.sum();
  ///
  ///       // Result: 10
  ///     }
  num sum([num Function(T) selector]) {
    checkNullError(this);

    if (isEmpty) {
      throw StateError('Iterator must not be empty.');
    }

    if (selector == null) {
      if (T == num) {
        selector = (T n) => n as num;
      } else if (T == int) {
        selector = (T n) => n as int;
      } else if (T == double) {
        selector = (T n) => n as double;
      }
    }

    ArgumentError.checkNotNull(selector);

    var total = T == int ? 0 : 0.0;

    for (var n in this) {
      total += selector(n);
    }

    return total;
  }
}

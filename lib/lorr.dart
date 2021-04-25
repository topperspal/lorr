library lorr;

LorR<L, R> left<L, R>(L left) => LorR(left, null);
LorR<L, R> right<L, R>(R right) => LorR(null, right);

class LorR<L, R> {
  final L? _l;
  final R? _r;

  LorR(this._l, this._r);

  bool get isLeft => _l != null;
  bool get isRight => _r != null;

  L? get left => _l;
  R? get right => _r;
}

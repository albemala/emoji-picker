extension CaseString on String {
  String toFirstUpperCase() {
    // ignore: unnecessary_this
    return this[0].toUpperCase() + this.substring(1);
  }
}

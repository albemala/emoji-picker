extension CaseString on String {
  String toFirstUpperCase() {
    return this[0].toUpperCase() + this.substring(1);
  }
}

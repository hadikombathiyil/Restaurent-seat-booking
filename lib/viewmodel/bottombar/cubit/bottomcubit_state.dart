abstract class BottomcubitState {
  final int currentIndex;
  const BottomcubitState(this.currentIndex);
}

class BottomcubitInitial extends BottomcubitState {
  const BottomcubitInitial(int currentIndex) : super(currentIndex);
}

library Registry;

class Registry {
  List reg;
  static const DEFAULT_REG = 64;
  
  Registry() {
    reg = new List(Registry.DEFAULT_REG);
    this.clear();
  }
  
  Registry.fromSize(int size) {
    reg = new List(size);
    this.clear();
  }
  
  void clear() {
    // clear registry
    for (var i = 0; i < reg.length; i++)
      reg[i] = 0;
  }
  
  int Get(int address) {
    if (address > reg.length || address < 0)
      return null;
    return reg[address];
  }
  
  void Set(int address, int value) {
    if (address > reg.length || address < 0)
      return null;
    reg[address] = value;
  }
  
  void Exchange(int addr1, int addr2) {
      if (addr1 > reg.length || addr1 < 0 || addr2 > reg.length || addr2 < 0)
        return;
      
      var temp = reg[addr1];
      reg[addr1] = reg[addr2];
      reg[addr2] = temp;
  }
}
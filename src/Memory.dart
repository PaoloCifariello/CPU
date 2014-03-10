library Memory;

import 'Instruction.dart';
import 'dart:io';

class InstructionMemory {
  List<Instruction> mem;
  static const DEFAULT_MEM_SIZE = 1024;
  
  InstructionMemory(InstructionSet iset) {
    mem = iset.getInstructions();
  }
  
  Instruction load(int address) {
    if (address > mem.length || address < 0)
      return null;
    return mem[address];
  }
  

  void store(int address, Instruction value) {
    if (address > mem.length || address < 0)
      return null;
    mem[address] = value;
  }
}



class DataMemory {
  
  List mem;
  static const DEFAULT_MEM_SIZE = 64;
  
  
  DataMemory() {
    mem = new List(DataMemory.DEFAULT_MEM_SIZE);
    this.clear();
  }
  
  DataMemory.fromSize(int size) {
    mem = new List(size);
    this.clear();
  }
  
  DataMemory.fromFile(String path) {
    mem = new List(DataMemory.DEFAULT_MEM_SIZE);
    this.clear();
    
    List<String> data;
    File file = new File(path);
    data = file.readAsLinesSync();
    
    for (int i = 0; i < data.length; i++)
      this.store(i, int.parse(data[i]));
  }
  
  void clear() {
    // clear registry
    for (var i = 0; i < mem.length; i++)
      mem[i] = 0;  
  }
  
  int load(int address) {
    if (address > mem.length || address < 0)
      return null;
    return mem[address];
  }
  
  void store(int address, int value) {
    if (address > mem.length || address < 0)
      return null;
    mem[address] = value;
  }
  
  int length () {
    return this.mem.length;
  }
}
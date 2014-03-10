library Instruction;

import 'dart:io';

class InstructionSet {
  List<Instruction> instructions;
  int iter = 0;
  
  InstructionSet.fromFile(String path) {

    List<String> inst;
    File file = new File(path);
    inst = file.readAsLinesSync();
    
    instructions = new List<Instruction>(inst.length);
    
    for (int i = 0; i < inst.length; i++){
      List<String> current  = inst[i].split(' ');
      instructions[i] = new Instruction(current);
    }
  }
  
  Instruction next(){
    this.iter++;
    return instructions[--iter];
  }
  
  bool hasNext(){
    return (iter < instructions.length);
  }
  
  int getLength() {
    return instructions.length;
  }
  
  List<Instruction> getInstructions() {
    return this.instructions;
  }
}

class Instruction {
  String COP;
  int param1;
  int param2;
  int param3;
  
  Instruction(List<String> args) {
    if (args.length >= 1) 
      COP = args[0];
    if (args.length >= 2)
      param1 = int.parse(args[1]);
    if (args.length >= 3)
      param2 = int.parse(args[2]);
    if (args.length >= 4)
      param3 = int.parse(args[3]);
  }
}
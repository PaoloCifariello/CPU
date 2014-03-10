import 'Memory.dart';
import 'Registry.dart';
import 'Instruction.dart';
import 'dart:io';

class CPU {
  
  static const bool verboseMode = true;
  
  Registry registry;
  DataMemory dataMemory;
  InstructionMemory instructionMemory;
  File storeFile;
  
  int IC = 0;
  bool end = false;

  CPU(String instructions, String dataMem, String storePath) {
    
    this.registry = new Registry();
    this.dataMemory = new DataMemory.fromFile(dataMem);
    
    InstructionSet iset = new InstructionSet.fromFile(instructions);
    this.instructionMemory = new InstructionMemory(iset);
    
    this.storeFile = new File(storePath);
  }
  
  Instruction fetch() {
    Instruction current = instructionMemory.load(IC);
    IC++;
    return current; 
  }
  
  void execute(Instruction inst) {
    switch (inst.COP) {
      
      case 'add' :
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        registry.Set(inst.param3, par1 + par2);
        if (CPU.verboseMode)
          print ('add ' + par1.toString() + ' ' + par2.toString() + ' to ' + inst.param3.toString() );
        break;
        
      case 'sub' :
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        registry.Set(inst.param3, par1 - par2);
        if (CPU.verboseMode)
          print ('sub ' + par1.toString() + ' ' + par2.toString() + ' to ' + inst.param3.toString());
        break;

      case 'mul' : 
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        registry.Set(inst.param3, par1 * par2);
        if (CPU.verboseMode)
          print ('mul ' + par1.toString() + ' ' + par2.toString() + ' to ' + inst.param3.toString());
        break;

      case 'div' : 
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        registry.Set(inst.param3, par1 ~/ par2);
        if (CPU.verboseMode)
          print ('div ' + par1.toString() + ' ' + par2.toString() + ' to ' + inst.param3.toString());
        break;
     
      case 'load' :
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        registry.Set(inst.param3, dataMemory.load(par1 + par2));
        if (CPU.verboseMode)
          print ('load ' + dataMemory.load(par1+par2).toString() + ' to ' + inst.param3.toString());
        break;
      
      case 'store' :
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        int par = registry.Get(inst.param3);
        dataMemory.store(par1 + par2, par);
        if (CPU.verboseMode)
          print ('store ' + par.toString() + ' in ' + (par1+par2).toString() );
        break;
      
      case 'if=' :
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        if (par1 == par2)
          IC += inst.param3;
        break;

      case 'if<' :
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        if (par1 < par2)
          IC += inst.param3;
        break;

      case 'if<=' :
        int par1 = registry.Get(inst.param1);
        int par2 = registry.Get(inst.param2);
        if (par1 <= par2)
          IC += inst.param3;
        break;
 
      case 'goto' :
        if (CPU.verboseMode)
          print ('goto ' + inst.param1.toString());
        IC += inst.param1;
        break;
      
      case 'end' :
        if (CPU.verboseMode)
          print('end');
        this.writeOnFile(this.storeFile);
        setEnd();  
    }
  }
  
  void setEnd() {
    this.end = true;  
  }
  
  void writeOnFile(File toStore) {
    IOSink str = toStore.openWrite(mode: FileMode.WRITE);
    
    for (int i = 0 ; i < dataMemory.length(); i++){
      String data = dataMemory.load(i).toString() + '\n';
      str.write(data);
    }
  }
  
  void run() {
    while(!end){
      Instruction current = fetch();
      execute(current);
    }
  }
}
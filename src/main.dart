import 'CPU.dart';

main(List<String> args){
  if (args.length < 1) 
      return;
    
  CPU cpu = new CPU(args[0], args[1], args[2]);
  cpu.run();
}
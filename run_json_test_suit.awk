#!/usr/bin/awk -f
BEGIN {
  FOLDER="./soft/JSONTestSuite/test_parsing/"
  Successes = Fails = 0
  run()
}

function run(   f,cmd) {
  cmd = "ls -1 " FOLDER
  while (cmd | getline f) {
    testFile(f)
  }
  close(cmd)
  print "Successes: " Successes
  print "Fails:     " Fails
}

function testFile(f,   firstLetter,cmd,res) {
  #  print FOLDER f
  firstLetter = substr(f,1,1)
  if ("n" == firstLetter || "y" == firstLetter) {
    cmd = "./gron.awk " FOLDER f " 2>&1 >/dev/null"
    #    print cmd
    res = system(cmd)
    printf "%8s : %s\n", (res = analyzeResult(firstLetter, res)) ? "SUCCESS" : "FAIL", f
    res ? Successes++ : Fails++
    close(cmd)
  }
}

function analyzeResult(firstLetter, res) {
  return res == 0 && firstLetter == "y" || res != 0 && firstLetter == "n"
}
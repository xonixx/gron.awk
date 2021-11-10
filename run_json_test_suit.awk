#!/usr/bin/awk -f
BEGIN {
  FOLDER="./soft/JSONTestSuite/test_parsing/"
  run()
}

function run(   f,cmd) {
  cmd = "ls -1 " FOLDER
  while (cmd | getline f) {
    testFile(f)
  }
  close(cmd)
}

function testFile(f,   firstLetter,cmd,res) {
  #  print FOLDER f
  firstLetter = substr(f,1,1)
  if ("n" == firstLetter || "y" == firstLetter) {
    cmd = "./gron.awk " FOLDER f " 2>&1 >/dev/null"
    #    print cmd
    res = system(cmd)
    printf "%8s : %s\n", analyzeResult(firstLetter, res), f
    close(cmd)
  }
}

function analyzeResult(firstLetter, res) {
  if (res == 0 && firstLetter == "y")
    return "SUCCESS"
  if (res != 0 && firstLetter == "n")
    return "SUCCESS"
  return "FAIL"
}
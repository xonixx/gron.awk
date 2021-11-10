#!/usr/bin/awk -f
BEGIN {
  FOLDER="./soft/JSONTestSuite/test_parsing/"
  FOLDER1="./soft/JSONTestSuite/test_transform/"
  Successes = Fails = 0
  run()
}

function run() {
  testFolder(FOLDER)
  testFolder(FOLDER1,"y")
  print "Successes: " Successes
  print "Fails:     " Fails
}

function testFolder(folder, firstLetter,   cmd,f) {
  cmd = "ls -1 " folder
  while (cmd | getline f) {
    testFile(folder, f, firstLetter)
  }
  close(cmd)
}

function testFile(folder, f, firstLetter,   cmd,res) {
  #  print FOLDER f
  if (!firstLetter)
    firstLetter = substr(f,1,1)
  cmd = "./gron.awk " folder f " 2>&1 >/dev/null"
  #    print cmd
  res = system(cmd)
  printf "%8s : %s\n", (res = analyzeResult(firstLetter, res)) ? "SUCCESS" : "FAIL", f
  res ? Successes++ : Fails++
  close(cmd)
}

function analyzeResult(firstLetter, res) {
  return res == 0 && ("y" == firstLetter||"i" == firstLetter) || res != 0 && firstLetter == "n"
}
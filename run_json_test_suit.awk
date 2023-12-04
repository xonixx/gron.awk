#!/usr/bin/awk -f
BEGIN {
  if (!(WHAT = ENVIRON["WHAT"])) {
    if (!(AWK = ENVIRON["AWK"])) {
      AWK = "awk"
    }
  }
  FOLDER1 = "./soft/JSONTestSuite/test_parsing/"
  FOLDER2 = "./soft/JSONTestSuite/test_transform/"
  Successes = Fails = 0
  run()
}

function run() {
  testFolder(FOLDER1)
  testFolder(FOLDER2,"y")
  print "Successes: " Successes
  print "Fails:     " Fails
}

function testFolder(folder, firstLetter,   cmd,f) {
  cmd = "ls -1 " folder " | LC_COLLATE='C' sort"
  while (cmd | getline f) {
    testFile(folder, f, firstLetter)
  }
  close(cmd)
}

function testFile(folder, f, firstLetter,   cmd,res) {
  if ("n_structure_open_array_object.json" == f ||
      "n_structure_100000_opening_arrays.json" == f) {
    # cause segfault
    return
  }
  #  print FOLDER f
  if (!firstLetter)
    firstLetter = substr(f,1,1)
  if ("jq" == WHAT)
    cmd = "cat " folder f " | jq ."
  else if ("jsqry" == WHAT)
    cmd = "cat " folder f " | jsqry"
  else
    cmd = AWK " -f gron.awk " folder f
  #  print cmd
  cmd = cmd " >/dev/null 2>&1"
  #  cmd = cmd " >/dev/null"
  res = system(cmd)
  printf "%8s : %s\n", (res = analyzeResult(firstLetter, res)) ? "SUCCESS" : "FAIL", f
  res ? Successes++ : Fails++
  close(cmd)
}

function analyzeResult(firstLetter, res) {
  return res == 0 && ("y" == firstLetter || "i" == firstLetter) || res != 0 && firstLetter == "n"
}
# gron.awk

[![Run tests](https://github.com/xonixx/gron.awk/actions/workflows/run-tests.yml/badge.svg)](https://github.com/xonixx/gron.awk/actions/workflows/run-tests.yml)

Similar to [tomnomnom/gron](https://github.com/tomnomnom/gron) but in Awk.

Features true JSON parser in Awk.
 
Reasonably fast with Gawk/Mawk even on large-ish files. Slow with [BWK](https://github.com/onetrueawk/awk) on big JSON files (100K+).

Incubated from [xonixx/awk_lab](https://github.com/xonixx/awk_lab).

## Usage

Gron:
```
$ echo '{"a":[1,2,3]}' | ./gron.awk
json={}
json.a=[]
json.a[0]=1
json.a[1]=2
json.a[2]=3
```

Un-Gron:
```
$ echo '{"a":[1,2,3]}' | ./gron.awk | ./gron.awk - -u
{
  "a": [
    1,
    2,
    3
  ]
}
```

[JSON structure](https://news.ycombinator.com/item?id=25009263): 
```
$ curl -s 'https://ip-ranges.amazonaws.com/ip-ranges.json' | ./gron.awk - -s
.syncToken = "1634535194"
.createDate = "2021-10-18-05-33-14"
.prefixes[].ip_prefix = "3.5.140.0/22"
.prefixes[].region = "ap-northeast-2"
.prefixes[].service = "AMAZON"
.prefixes[].network_border_group = "ap-northeast-2"
.ipv6_prefixes[].ipv6_prefix = "2a05:d07a:a000::/40"
.ipv6_prefixes[].region = "eu-south-1"
.ipv6_prefixes[].service = "AMAZON"
.ipv6_prefixes[].network_border_group = "eu-south-1"
```
#! /usr/bin/env node
fs = require("fs");

function getMidiAlias(name) {
	var text = fs.readFileSync("/Users/michael/Library/Application Support/REAPER/reaper-midihw.ini", 'utf8')
	mysplit=text.split('\n')
	for (i=0;i<mysplit.length;++i){
		map = mysplit[i].split('=')
		if (map[1]==name){return map[0].match(/\d+/)[0]}
	}
}

console.log(getMidiAlias('qunexus'))

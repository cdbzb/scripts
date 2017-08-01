#! /usr/bin/env node

var fs = require('fs')
var argv = require('yargs')
	.help ('h')
	.array('i')
	.command ('change','change a track' )
	.command ('insert','insert a track') // -N for new instead??
	.alias ('name','n') //name
	.alias ('I','input') //analog inputs
	.default ('I',0)
	.array('I')
	.alias ('midi','i') // midi inputs
	.default ('i',0)
	.alias ('vkb','v') //vkb
	.alias ('M','recmode')
	.alias ('monmed','mm') // monitor media
	.alias ('FIPM','f') // FIPM
	.alias ('monitor','m') // m monitor input
	.alias ('pan','p') // pan
	.alias ('vol','v') // vol
	.alias ('P','parent') // master/parent send
	.alias ('p','pan') // pan
	.alias ('d','mididevice')
	.alias ('o','solo') // solo
	.describe ('P','master/parent send (bool)')
	.describe ('rm','record mode - input output none LC midi mono midiOD midiR')
	.argv;

	recModeDict={
		input:0,
		output:1,
		none:2,
		LC:3,
		midi:4,
		mono:5,
		monoLC:6,
		midiOD:7,
		midiR:8
	};

	masterDict={
		// :B_MUTE,
		h:'B_PHASE',
		// :P_TRACKNUMBER,
		o:'I_SOLO',
		f:'I_FXEN',
		a:'I_RECARM',
		I:'I_RECINPUT',
		M:'I_RECMODE',
		m:'I_RECMON',
		mm:'I_RECMONITEMS',
		// :I_AUTOMODE,
		nc:'I_NCHAN',
		s:'I_SELECTED',
		// :I_WNDH,
		// :I_FOLDERDEPTH,
		// :I_FOLDERCOMPACT,
		// :I_MIDIHWOUT,
		// :I_PERFFLAGS,
		// :I_CUSTOMCOLOR,
		// :I_HEIGHTOVERRIDE,
		// :D_VOL,
		p: 'D_PAN',
		// :D_WIDTH,
		// :D_DUALPANL,
		// :D_DUALPANR,
		// :I_PANMODE,
		// :D_PANLAW,
		// :P_ENV,
		// :B_SHOWINMIXER,
		// :B_SHOWINTCP,
		// :B_MAINSEND,
		// :B_FREEMODE,
		// :C_BEATATTACHMODE,
		// :F_MCP_FXSEND_SCALE,
		xx:'F_MCP_SENDRGN_SCALE'

	};
	

if (argv.M) {
	var recMode = recModeDict[argv.M]
	argv.M=recMode
}

//build input bitwise)
var midi = ((+argv.i) ? 4096 : ((argv.d) ? 4096 : 0 ))
var stereo = (argv.I[1] ? 1024 : 0)
var hardware = ( argv.vkb ? (62*32) : 
		( argv.d ? getMidiAlias(argv.d)*32 :
		  (( argv.midi > 0) ? 63*32 : 0 )))
if (argv.I[0] > 0) {argv.I[0] = argv.I[0]-1}
var input = (parseInt(stereo) + parseInt(argv.I[0]) + parseInt(+argv.i) + parseInt(midi)  + parseInt(hardware))
	argv.I = input // set to input
	
//	TODO: check to see whether MIDI bit should be on for vkb

console.log(JSON.stringify(argv))

for (var property in argv) {
    if (argv.hasOwnProperty(property)) {
        console.log(property, argv[property])
    }
}

function MatchTrackLua () {
	stream.write(" TrackNumber = reaper.CountTracks(0) \n"+
		"	for index = 0,(TrackNumber-1) do \n" +
				'mytrack = reaper.GetTrack(0,index)\n' +
				'local _, name = reaper.GetSetMediaTrackInfo_String(mytrack,"P_NAME","",false)\n'+
				'if string.find(  name , "' + argv.name + '") then track = reaper.GetTrack(0,index) end' + "\n" + 
				"end\n")
}

function CreateTrackLua() {
	stream.write('reaper.Main_OnCommand (40001,0)\n' +
			" track = reaper.GetSelectedTrack(0,0) \n" +
			' reaper.GetSetMediaTrackInfo_String (track,"P_NAME","' + argv.n + '" ,1)\n')
}

function GetSelectedTrackLua() {
	stream.write("track = reaper.GetSelectedTrack(0,0)\n")
}


function getMidiAlias(name) {
	var text = fs.readFileSync("/Users/michael/Library/Application Support/REAPER/reaper-midihw.ini", 'utf8')
	mysplit=text.split('\n')
	for (i=0;i<mysplit.length;++i){
		map = mysplit[i].split('=')
		if (map[1]==name){return map[0].match(/\d+/)[0]}
	}
}


var stream = fs.createWriteStream("/Users/michael/Library/Application Support/REAPER/Scripts/Codeinjector.lua");
stream.once('open', function(fd) {
	argv.c ? (argv.n ? MatchTrackLua() : GetSelectedTrackLua()) : CreateTrackLua() //set track
	for (var property in argv) {
	    if (argv.hasOwnProperty(property)) {
		if (masterDict[property]) {
			stream.write('reaper.SetMediaTrackInfo_Value(track, "' + masterDict[property] + '",' +  parseInt(+argv[property]) + ")\n");
		}
	    }
	}
	stream.end();
});

console.log (argv.top ? 'at top' : '' )
console.log( (argv.a ? 'armed' : 'not-armed') );
console.log ('name = ' + (argv.name) )
console.log ('monitor = ' + (argv.m ? "input" : "none") )
console.log ('recmode = ' +(argv.M) )
console.log ('input = ' + (argv.vkb ? 'vkb' : (argv.I ? "analog" + (argv.I) : "")) + (argv.i ? "midi" + (argv.i) : '' ))
console.log ('parent = ' + (argv.P ? "true" : "false" ) )
console.log ('recmode byte = ' + recMode)
console.log ('argv.i' + (argv.i))
console.log ('input byte = ' + input)
//1024 stereo
//4096 midi
//0 = all channels
//bits 6-10 = physical inputs
//63=all
//62=vkb
// question about multi-channel input 8192?


// dict m:I_Media:value

//reaper.SetMediaTrackInfo_Value(track,dict[key],dict[key][value])
//
//reaper.TrackList_AdjustWindows(0)
//reaper.UpdateArrange()
//

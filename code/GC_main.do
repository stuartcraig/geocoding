/*-----------------------------------------------------------------GC_main.do

- "Things to watch out for" pages

Stuart Craig
20230428
*/
args nodata

global rootdir 	"~/Dropbox/_data/geocoding"
global scGC	"${rootdir}/code"
global ddGC	"${rootdir}/deriveddata"
global rdGC	"${rootdir}/rawdata"
global oGC	"${rootdir}/output"
global tGC	"${rootdir}/temp"
adopath + ~/Dropbox/ado_shared
if "`nodata'"=="nodata" exit


/*
--------------------------------------------

Administrative boundary crosswalks

--------------------------------------------
*/

// zip2county crosswalk (s)
	qui do ${scGC}/GC_zip2county.do

// county2cbsa
// county2cz
// state key
// congressional districts


/*
--------------------------------------------

Distance matrices
- Hospital to hospital
- Hospital to zip

--------------------------------------------
*/




exit

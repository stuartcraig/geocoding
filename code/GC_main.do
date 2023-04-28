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
if "`nodata'"=="nodata" exit





e


cd ${rdGC}/hud
qui fs ZIP_COUNTY_*xlsx
foreach file in `r(files)' {
	di "`file'"
	loc dt = subinstr("`file'","ZIP_COUNTY_","",.)
	loc dt = subinstr("`dt'",".xlsx","",.)
	loc q = (real(substr("`dt'",1,2)))/3
	loc y = real(substr("`dt'",-4,4))
	di "`y'Q`q'", _c
}
exit



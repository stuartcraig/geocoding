// Zip/county files must be pulled individually off the HUD site
// https://www.huduser.gov/portal/datasets/usps_crosswalk.html
// Downloaded 4/28/2023

qui do ~/Dropbox/_data/geocoding/code/GC_main.do nodata


/*
----------------------------------------------

Raw data pull

----------------------------------------------
*/

cap mkdir ${ddGC}/zip2county
cap mkdir ${ddGC}/zip2county/Qfiles

cap confirm file ${ddGC}/zip2county/GC_zip2county_allQ.dta
if _rc!=0 {

	cd ${rdGC}/hud
	qui fs ZIP_COUNTY_*xlsx
	foreach file in `r(files)' {
	qui {

		di "`file'"
		loc dt = subinstr("`file'","ZIP_COUNTY_","",.)
		loc dt = subinstr("`dt'",".xlsx","",.)
		loc q = (real(substr("`dt'",1,2)))/3
		loc y = real(substr("`dt'",-4,4))
		cap confirm file ${ddGC}/zip2county/Qfiles/GC_zip2county_`y'Q`q'.dta
		if _rc!=0 {
			import excel using `file', first clear
			rename *, lower
			
			// Quick check to make sure we're dealing with the right file!
			preserve
				gcollapse (sum) *ratio, by(zip) fast
				foreach v of varlist *ratio {
					assert abs(`v' - 1)<0.01 | abs(`v' - 0)<0.01
				}
			restore
			
			// Prioritize based on residential address ratio 
			// (then others to break ties)
			hashsort zip -res_ratio -bus_ratio -oth_ratio
			qby zip: keep if _n==1
			keep zip county
			compress
			confirm string var zip
			confirm string var county
			save ${ddGC}/zip2county/Qfiles/GC_zip2county_`y'Q`q'.dta, replace
		}
	}
	di "`y'Q`q'", _c
	}

	// Compile everything into one YQ file
	clear
	forval y=2010/2019 {
	forval q=1/4 {
		// Any exceptions? 
		append using ${ddGC}/zip2county/Qfiles/GC_zip2county_`y'Q`q'.dta
		cap gen q = yq(`y',`q')
		if _rc!=0 qui replace q = yq(`y',`q') if missing(q)
	}
	}
	format q %tq
	drop if missing(zip)

	save ${ddGC}/zip2county/GC_zip2county_allQ.dta, replace
}


/*
----------------------------------------------

Things to watch out for: 

----------------------------------------------
*/


	use ${ddGC}/zip2county/GC_zip2county_allQ.dta, clear
	cap mkdir ${oGC}/zip2county
	cd ${oGC}/zip2county
/*
// 1. Incomplete panels
	preserve
		gcollapse (count) Nq=q, by(zip) fast
		gen Nz = 1
		gcollapse (sum) Nz, by(Nq) fast
		tw bar Nz Nq, barw(0.9) fi(100) /// 
			xtitle("Number of Quarters in the Data") ///
			ytitle("Number of Zip Codes") ylab(0(10000)40000,format(%76.0fc))
	restore
*/
// 2. Inconsistent county mappings
	*qbys zip (county): gen prob = county[1]!=county[_N]
	*keep if prob==1
	preserve
		keep zip county
		gduplicates drop
		gen Nc = 1
		gcollapse (sum) Nc, by(zip) fast
		tab Nc
		drop if Nc==1
		tw hist Nc, width(1) discrete lc(white) fi(100) ///
			xlab(2/3) freq  ///
			ytitle("Number of Zip Codes")
	restore
	
	
	
	*qbys zip (county): gen prob = county[1]!=county[_N]
	*keep if prob==1
	


exit

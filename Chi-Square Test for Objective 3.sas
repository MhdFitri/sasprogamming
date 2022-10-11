libname Project "H:\Users\Asus\Documents\Degree UiTM Seremban\PART 5\STA 610 (SAS)\Sales Project";
run;

proc import out = project.all 
datafile = "H:\Users\Asus\Documents\Degree UiTM Seremban\PART 5\STA 610 (SAS)\Project\SalesRecords.xlsx"
dbms = excel;
run;

proc format;
value profitfmt
	  low -<500000 = 'Low'
	  500000-<1000000 = 'Moderate'
	  1000000-high = 'High';
run;

data project.regions;
set project.sales;
keep region total_profit;
format total_profit profitfmt.;
run;

proc freq data = project.regions;
tables region*total_profit / expected chisq fisher;
run;

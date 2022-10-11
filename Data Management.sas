libname Project "H:\Users\Asus\Documents\Degree UiTM Seremban\PART 5\STA 610 (SAS)\Sales Project";
run;

proc import out = project.all 
datafile = "H:\Users\Asus\Documents\Degree UiTM Seremban\PART 5\STA 610 (SAS)\Project\SalesRecords.xlsx"
dbms = excel;
run;

data project.sales;
set project.all (obs=500);
keep Region Item_Type Units_Sold Total_Revenue Total_Profit;
run;

title 'Descriptor Portion for Original Sales Dataset';
proc contents data=project.sales;
run;

data project.AE;
set project.sales;
keep Region Total_Revenue;
where Region in ('Asia','Europe');
run;

title' Descriptor Portion for Asia and Europe Dataset';
proc contents data=project.AE;
run;

data project.items (keep=item_type units_sold);
set project.sales;
run;

title  'Descriptor Portion for Items dataset'
proc contents data=project.items;
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

title 'Descriptor Portion for Regions and Total Profit Dataset';
proc contents data=project.regions;
run;

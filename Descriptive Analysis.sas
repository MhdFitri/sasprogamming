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

proc print data=project.sales;
run;

title 'Distribution of Regions';
proc freq data=project.sales nlevels;
tables Region;
run;

title 'Distribution of Item Types';
proc freq data=project.sales nlevels;
tables Item_Type;
run;

title 'Distribution of Asia Region and Europe Region';
proc freq data=project.sales;
tables Region;
where Region in ('Asia','Europe');
run;


title 'Total Profit by Regions';
proc means data=project.sales;
var Total_Profit;
class Region;
run;
title 'Total Number of Units Sold by All Item Types';
proc report data=project.sales;
column Item_Type Units_Sold;
define Item_Type / group;
define Units_Sold / sum;
run;

title 'Number of Units Sold by All Item Types';
proc means data=project.sales maxdec = 2;
var units_sold;
class item_type;
run;

title1 'Total profit made by Asia Region and Europe Region';
title2 'For Each Item Type';
proc tabulate data=project.sales;
where region in ('Asia','Europe');
class region item_type;
var total_profit;
table item_type, region*total_profit;
run;


proc format;
value profitfmt
	  low -<500000 = 'Low'
	  500000-<1000000 = 'Moderate'
	  1000000-high = 'High';
run;

title 'The Distribution of Total Profit Levels by Regions';
proc freq data=project.sales;
tables Region*Total_Profit;
format Total_Profit profitfmt.;
run;

Title ‘Total revenue by Asia Region and Europe Region’;
Proc means data=project.sales maxdec = 2;
Var Total_Revenue;
Class Region;
Where Region in (‘Asia’,’Europe’);
Run;


data project.AE;
set project.sales;
keep Region Total_Revenue;
where Region in ('Asia','Europe');
run;

proc print data = project.AE;
run;

data project.items;
set project.sales;
keep item_type units_sold;
run;

title h=2 f=broadway 'The Total Number of Units Sold by Each Item Type';
proc gchart data=project.sales;
hbar3d item_type / sumvar=units_sold nostats;
run;

title h=2 f=broadway c=brown 'The Total Number of Sales Made by Each Region';
axis1 stagger label=none;
axis2 label=(a=90 'Height');
proc gchart data=project.sales;
vbar region /  maxis=axis1 raxis=axis2;
run;


proc gchart data=project.sales;
hbar3d region / sumvar=total_revenue;
format total_revenue dollar12.;
run;

title h=2 f=broadway 'The Percentage Distribution of Sales between Asia and Europe';
proc gchart data=project.sales;
pie3d region / type=percent noheading;
where region in ('Asia','Europe');
run;


title h=2 f=broadway 'Total Profit Made by Each Region';
proc gchart data=project.sales;
hbar3d region / sumvar=total_profit nostats;
format total_profit dollar12.;
run;


title h=2 f=broadway c=brown 'The Total Number of Sales Made by Each Region';
axis1 stagger label=none;
axis2 label=(a=90 'Frequency');
proc gchart data=project.sales;
vbar3d region / patternid=midpoint width=10 maxis=axis1 raxis=axis2;
run;

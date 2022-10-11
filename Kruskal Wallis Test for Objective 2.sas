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

data project.items;
set project.sales;
keep item_type units_sold;
run;

proc univariate data=project.items normal;
var units_sold;
probplot / normal (mu=est sigma=est);
run;

title 'Kruskal-Wallis Test';
proc npar1way data=project.items wilcoxon;
class item_type;
var units_sold;
run;

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

data project.AE;
set project.sales;
keep Region Total_Revenue;
where Region in ('Asia','Europe');
run;


proc univariate data=project.AE normal;
var total_revenue;
probplot / normal (mu=est sigma=est);
run;

title 'Mann-Whitney U Test';
proc npar1way data=project.AE wilcoxon;
class region;
var total_revenue;
exact Wilcoxon;
run;

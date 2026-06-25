var line1total = Number(this.getField("line1_ext total sell").valueAsString);
var line1labor = Number(this.getField("line1_labor").valueAsString);
var line1freight = Number(this.getField("line1_freight").valueAsString);
var line1misc = Number(this.getField("line1_misc").valueAsString);
var line1qty = Number(this.getField("line1_qty").valueAsString);
var line1mat = Number(this.getField("line1_material cost").valueAsString);

var line2total = Number(this.getField("line2_ext total sell").valueAsString);
var line2labor = Number(this.getField("line2_labor").valueAsString);
var line2freight = Number(this.getField("line2_freight").valueAsString);
var line2misc = Number(this.getField("line2_misc").valueAsString);
var line2qty = Number(this.getField("line2_qty").valueAsString);
var line2mat = Number(this.getField("line2_material cost").valueAsString);

var line3total = Number(this.getField("line3_ext total sell").valueAsString);
var line3labor = Number(this.getField("line3_labor").valueAsString);
var line3freight = Number(this.getField("line3_freight").valueAsString);
var line3misc = Number(this.getField("line3_misc").valueAsString);
var line3qty = Number(this.getField("line3_qty").valueAsString);
var line3mat = Number(this.getField("line3_material cost").valueAsString);

var line4total = Number(this.getField("line4_ext total sell").valueAsString);
var line4labor = Number(this.getField("line4_labor").valueAsString);
var line4freight = Number(this.getField("line4_freight").valueAsString);
var line4misc = Number(this.getField("line4_misc").valueAsString);
var line4qty = Number(this.getField("line4_qty").valueAsString);
var line4mat = Number(this.getField("line4_material cost").valueAsString);

var line5total = Number(this.getField("line5_ext total sell").valueAsString);
var line5labor = Number(this.getField("line5_labor").valueAsString);
var line5freight = Number(this.getField("line5_freight").valueAsString);
var line5misc = Number(this.getField("line5_misc").valueAsString);
var line5qty = Number(this.getField("line5_qty").valueAsString);
var line5mat = Number(this.getField("line5_material cost").valueAsString);




var numerator = 
((line1total + line2total + line3total + line4total + line5total) - 
((line1labor*line1qty) + (line1freight*line1qty) + (line1misc*line1qty) + 
(line2labor*line2qty) + (line2freight*line2qty) + (line2misc*line2qty) + 
(line3labor*line3qty) + (line3freight*line3qty) + (line3misc*line3qty) + 
(line4labor*line4qty) + (line4freight*line4qty) + (line4misc*line4qty) + 
(line5labor*line5qty) + (line5freight*line5qty) + (line5misc*line5qty)));

var denominator = 
((line1qty * line1mat) + 
(line2qty * line2mat) + 
(line3qty * line3mat) + 
(line4qty * line4mat) + 
(line5qty * line5mat));

var calculatepercent = (numerator/denominator)-1;




if (denominator !== 0){
event.value = calculatepercent;}
else{
event.value = 0;}
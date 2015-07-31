#to run on linux perl ComputerGraphics.pl x0_parameter x1_paramenter y0_parameter y1_parameter 
use strict;
use warnings;
use Data::Dumper; # for printing hash of point arrays easily
use 5.020;

#parametes passed when program is run
my ($x0,$y0,$xEnd,$yEnd) = @ARGV;

#change in x and y 
my ($dx,$dy) = (abs($xEnd - $x0), abs($yEnd - $y0));

# if absolute val of delta y greater than delta x
my $bool = abs($dy) > abs($dx); 

#switch if $dx was greater than $dy
($x0, $y0,$xEnd, $yEnd) = ($y0,$x0,$yEnd,$xEnd) if $bool;

#swap is $x0 is > $xend
($x0, $xEnd, $y0, $yEnd) = ($xEnd, $x0, $yEnd, $y0) if $x0 > $xEnd;

# if y is < $yEnd set step_for_y to one else set step_for_y to -1 for negative slope
#list_of_points is a hash of two arrays containing x and y points
my ($x,$y,$p, $step_for_y, %list_of_points) = ($x0 , $y0, $dx - $dy, ($y0 < $yEnd) ? 1 : -1, ());

do {
	#switch where x and y get pushed if dy > dx / if $bool is true
	#kind of ugly but was seeing how short I could get this
	$bool ? push(@{$list_of_points{"x_p"}}, $y) && push(@{$list_of_points{"y_p"}}, $x)
		  : push(@{$list_of_points{"x_p"}}, $x) && push(@{$list_of_points{"y_p"}},$y);
		
	$p -= $dy;
	#increase step 
	if ($p < 0){
		$y += $step_for_y;
		$p += $dx; 		
	}

} until($x++ == $xEnd);

print Dumper \%list_of_points;


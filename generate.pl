use strict;
use warnings;

my $tags = [

	'DIV',
	'A',
	'P',
	'NAV',
	'SECTION',
	'TABLE',
	'TR',
	'TD',
	'FORM',
	'INPUT',
	'TEXTAREA',

];

my $classes = [
	'.important',
	'.warning',
	'.closed',
	'.open',
];

my $ids = [
	'#slider',
	'#carousel',
	'#statusbar',
	'#navigation'
];

my $attribs = [
	'[src]',
	'[src~="http"]',
	'[type="text"]',
	'[href|="#"]'
];

my $pseudos = [
	':active',
	':hover',
	':focus',
];

my $props = [
	'font-family: arial;',
	'background: red;',
];

sub random_item
{
	return $_[0]->[int(rand(scalar(@{$_[0]})))];
}

sub random_property
{

	my ($size) = @_;

	my @properties;

	for (my $i = 0; $i < $size; ++ $i)
	{
		push @properties, random_item($props);
	}

	return @properties;

}

sub random_compound
{
	my ($size) = @_;

	my $selector = '';

	while ($selector eq '') {

		my $has_type = int(rand(100)) < 20;
		my $has_id = int(rand(100)) < 5;
		my $has_class = int(rand(100)) < 80;
		my $has_attrib = int(rand(100)) < 15;
		my $has_pseudo = int(rand(100)) < 5;

		if ($has_type) { $selector .= random_item($tags); }
		if ($has_id) { $selector .= random_item($ids); }
		if ($has_class) { $selector .= random_item($classes); }
		if ($has_attrib) { $selector .= random_item($attribs); }
		if ($has_pseudo) { $selector .= random_item($pseudos); }

	}

	return $selector;

}

sub random_complex
{
	my ($size) = @_;

	my $selector = '';

	for (my $i = 0; $i < $size; $i ++) {

		my $simple = random_compound;

		my $combinator = int(rand(100));

		if ($combinator < 5) {
			$combinator = " ~ ";
		} elsif ($combinator < 10) {
			$combinator = " > ";
		} elsif ($combinator < 20) {
			$combinator = " + ";
		} else {
			$combinator = " ";
		}

		$selector .= $combinator if ($i);

		$selector .= $simple;

	}

	return $selector;

}

sub random_selector
{
	my $size = int(rand(4)) + 1;
	return random_complex($size);

}

sub random_block
{

	my ($nesting, $n) = @_;

	my $result = '';

	$n = 0 unless $n;

	$result .= ("  " x $n) .
	      random_selector .
	      " {\n";
	my $props = int(rand(6)) + 1;
	$result .= join("", map {
		("  " x ($n + 1)) . $_ . "\n";
	} random_property($props));

	$result .= random_block($nesting, $n + 1) if ($n < $nesting);

	$result .= ("  " x $n) . "}\n";

	return $result;

}

my $scss = '';

for (my $i = 0; $i < 3000; $i ++)
{
	my $nesting = int(rand(5)) + 1;
	$scss .= random_block($nesting, 0);
}

use File::Slurp;

write_file('test/nested.scss', $scss);

system 'gulp sass';
system 'gulp postcss';

my $test2 = read_file('sass/nested.css');
my $test3 = read_file('postcss/nested.scss');

$test2 =~ s/\s*/ /g;
$test3 =~ s/\s*/ /g;

print "initial test ", (($test2 eq $test3 ? "passed" : "mismatch"), "\n");

my %results = ("postcss" => 0, "sass" => 0);

my $runs = 10;

foreach my $proc (keys %results) {
  for (my $t = 0; $t < $runs; $t ++) {
    my $out = `gulp $proc`; my $took = 0;
    $took = $1 * 1000 if $out =~ m/after (\d+(:?\.\d+)?)\s+s/;
    $took = $1 if $out =~ m/after (\d+)\s+ms/;
	$results{$proc} += $took;
    printf "$proc run %02d took %g ms\n", $t + 1, $took;
  }
}


foreach my $proc (keys %results) {
  printf "%s: %g ms\n", $proc, $results{$proc} / $runs;
}

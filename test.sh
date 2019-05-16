#!/usr/bin/env zsh
dir=.

from=20161230
to=20170105
echo -n $from to $to "(day) :"
foreach ymdh (`$dir/ymdhms.pl -f $from -t $to -s d`)
  echo -n " "$ymdh
end
echo

from=2020101021
to=2020101103
echo -n $from to $to "(hour) :"
foreach ymdh (`$dir/ymdhms.pl -f $from -t $to -s H`)
  echo -n " "$ymdh
end
echo

from=200109
valu=6
echo -n $from + $valu "(months) = "
echo `$dir/ymdhms.pl -f $from -a $valu -s m`

from=20180101
valu=-10
echo -n $from + $valu "(days) = "
echo `$dir/ymdhms.pl -f $from -a $valu -s d`

from=2018101018
valu=12
echo -n $from + $valu "(hours) = "
echo `$dir/ymdhms.pl -f $from -a $valu -s H`

from=200010302355
valu=20
echo -n $from + $valu "(minutes) = "
echo `$dir/ymdhms.pl -f $from -a $valu -s M`

from=20001030235500
valu=95
echo -n $from + $valu "(seconds) = "
echo `$dir/ymdhms.pl -f $from -a $valu -s S`



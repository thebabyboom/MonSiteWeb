<?php
$i=0;
while($i<100)
{
	$i++;
	echo($i.'&nbsp;');
	if(!($i%5))
	{
		echo('<br/>');
	}
}
?>
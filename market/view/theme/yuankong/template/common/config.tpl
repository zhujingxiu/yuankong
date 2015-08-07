<?php
$column_left  = isset($column_left) ? trim($column_left) : '';
$column_right  = isset($column_right) ? trim($column_right) : '';
 
if( !empty($column_left) && !empty($column_right) ){
		$layout = 'full';
	} elseif( empty($column_left) && !empty($column_right) ){
		$layout = 'center-right';
	}elseif( !empty($column_left) && empty($column_right) ){
		$layout = 'center-left';
	}else {
		$layout = 'center';
	}
	
	$spans = array( 'full' 			=> array('l w210','','r w290'),
					'center-right'  => array('',' l w900 ',' r w290 '), 
					'center-left'   => array(' l w210',' r w980 ',''),
					'center'		=> array('',' w ','')
	);
	$SPAN = $spans[$layout];
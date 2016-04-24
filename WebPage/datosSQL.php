<?php
	
	$cont = 0;

	if (!$enlace = mysql_connect('localhost', 'root')) {
	    echo 'No pudo conectarse a mysql';
	    exit;
	}

	if (!mysql_select_db('datos', $enlace)) {
	    echo 'No pudo seleccionar la base de datos';
	    exit;
	}

	$sql = 'SELECT * FROM datos ORDER BY ID DESC LIMIT 10';
	$resultado = mysql_query($sql);
	if (!$resultado) {
	    echo "Error de BD, no se pudo consultar la base de datos\n";
	    echo "Error MySQL: ' . mysql_error()";
	    exit;
	}
	echo "<table border = '1'> \n"; 
	echo "<tr><td>Temperatura (C)</td><td>Presion (hPa)</td><td>Altitud (m)</td><td>Fecha</td><td>Predicción</td></tr> \n";
	while (($fila = mysql_fetch_assoc($resultado))) {
		if($fila["Prediccion"] < -150){
			$pred = "Mal tiempo";
		}else if($fila["Prediccion"] >= -150 && $fila["Prediccion"] > 150){
			$pred = "Tiempo inestable";
		}else
			$pred = "Buen tiempo";
		$fecha = substr($fila["Fecha"], 0,4)."-".substr($fila["Fecha"], 4,2)."-".substr($fila["Fecha"], 6,2)."\t".substr($fila["Fecha"], 8,2).":".substr($fila["Fecha"], 10,2);
		echo "<tr><td>".$fila["Temperatura"]."</td><td>".$fila["Presion"]."</td><td>".$fila["Altitud"]."</td><td>".$fecha."</td><td>".$pred."</td></tr> \n";
		echo "\r\n";
	}
		
	mysql_free_result($resultado);
?>
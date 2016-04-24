<?php  
function Conectarse()  
{  
   if (!($link=mysql_connect("localhost","carlos","turbonasa")))  
   {  
      echo "Error conectando a la base de datos.";  
      exit();  
   }
   if (!mysql_select_db("n_base",$link))  
   {  
      echo "Error seleccionando la base de datos.";  
      exit();  
   }  
   echo $link;
   return $link;  
}  
?>  
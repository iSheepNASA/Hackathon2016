import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;
import processing.serial.*;
Serial puerto;
MySQL base;
float temp;
  int pres, alt;
  String mes;
  String dia;
  String hora;
  String minuto;
  String fecha;
  boolean flag=false;
  int altitud_actual=847; //altitud del mapa NASA
  int p0=101325; //presion a nivel del mar en un dia despejado
  float coefAlt=0.12; //coeficiente presion altitud

void setup(){
  System.out.println(Serial.list()[0]);
  String user     = "carlos";
  String pass     = "turbonasa";
  String database = "datos";
  String table    = "datos";
  String name     = "192.168.0.100:3306";
base = new MySQL( this, name, database, user, pass );

puerto=new Serial(this, Serial.list()[0], 9600);
//System.out.println(puerto.available());
}

void draw(){
  int[] cad = new int[6];  
  float prevision;
  int cuenta=0;
  for(int i=0;i<6;i++){
      if(puerto.available()>0){
        cad[i]=puerto.read();
        System.out.println(cad[i]);
        cuenta++;
      }
  }
   //System.out.println(cuenta);
   if(cuenta>0){
     temp = cad[0] + cad[1]*0.1;
     pres = cad[2]*1000 + cad[3]*10;
     alt = cad[4]*100 + cad[5];
     if(month()>=0 && month() < 10){
       mes = "0" + month();
     }else{
       mes = month()+"";
     }
     if(day()>=0 && day() < 10){
       dia = "0" + day();
     }else{
       dia = day()+"";
     }
     if(hour()>=0 && hour() < 10){
       hora = "0" + hour();
     }else{
       hora = hour()+"";
     }
     if(minute()>=0 && minute() < 10){
       minuto = "0" + minute();
     }else{
       minuto = minute()+"";
     }
     fecha = year()+""+mes+""+dia+""+hora+""+minuto;
     altitud_actual=alt;//solo si no hay altitud de gps
     prevision=p0-(pres+(altitud_actual*coefAlt*100));
     /*
     System.out.println("Previsio");
     System.out.println(prevision);
     System.out.println("Previsio");
     */
     if(flag){
       actualizarBase(temp,pres,alt,fecha,prevision);
     }else{
       flag=true;
     }
     
   }
}

void actualizarBase(float temp,int pres,int  alt, String hora, float prevision){
  if(base.connect()){
     System.out.println("success");
     base.execute("INSERT INTO datos (Temperatura, Presion, Altitud, Fecha, Prediccion) VALUES ("+ temp +", "+ pres +", "+ alt +", "+ fecha +", "+prevision +")"); 
   
 }else{
     System.out.println("error");
   }

}

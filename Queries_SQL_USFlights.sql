/* 
1.Quantitat de registres de la taula de vols:*/
SELECT COUNT(flightID) FROM Flights;

/* 
2.Retard promig de sortida i arribada segons l’aeroport origen.*/
SELECT Flights.Origin, AVG(Flights.ArrDelay) as prom_arribades, AVG(Flights.DepDelay) as prom_sortides
FROM USAirlineFlights2.Flights GROUP BY Flights.Origin ORDER BY Flights.Origin ASC;

/* 
3.Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. 
A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files):*/
SELECT Flights.Origin as ORIGEN, Flights.colYear as AÑO, Flights.colMonth as MES, ROUND(AVG(Flights.ArrDelay) ,0) as avg_Delay
FROM USAirlineFlights2.Flights GROUP BY Flights.Origin, Flights.colYear, Flights.colMonth 
ORDER BY Flights.Origin, Flights.colYear, Flights.colMonth ASC;

/* 
4.Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen (mateixa consulta que 
abans i amb el mateix ordre). Però a més, ara volen que en comptes del codi de l’aeroport 
es mostri el nom de la ciutat.*/
SELECT USAirports.City, Flights.colYear as AÑO, Flights.colMonth as MES, ROUND(AVG(Flights.ArrDelay) ,4) as avg_Delay
FROM USAirlineFlights2.Flights 
JOIN USAirlineFlights2.USAirports ON Flights.Origin=USAirports.IATA 
GROUP BY USAirports.City, Flights.colYear, Flights.colMonth
ORDER BY USAirports.City, Flights.colYear, Flights.colMonth ASC;

/* 
5.Les companyies amb més vols cancelats,per mesos i any. A més, han d’estar ordenades de forma que 
les companyies amb més cancel·lacions apareguin les primeres.*/
SELECT Flights.UniqueCarrier, Flights.colYear, Flights.colMonth, AVG(Flights.ArrDelay) as avg_delay, 
SUM(Flights.Cancelled) as total_cancelled FROM USAirlineFlights2.Flights 
GROUP BY Flights.UniqueCarrier, Flights.colYear, Flights.colMonth
ORDER BY total_cancelled DESC;

/* 
6.L’identificador dels 10 avions que més distància han recorregut fent vols.*/
SELECT Flights.TailNum, SUM(Flights.Distance) AS Total_Distance FROM USAirlineFlights2.Flights
WHERE Flights.TailNum!="" GROUP BY Flights.TailNum ORDER BY SUM(Flights.Distance) DESC LIMIT 10;

/* 
7.Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben 
al seu destí amb un retràs promig major de 10 minuts.*/
SELECT UniqueCarrier, AVG(ArrDelay) FROM Flights
GROUP BY UniqueCarrier HAVING AVG(ArrDelay) > 10 ORDER BY AVG(ArrDelay) DESC;
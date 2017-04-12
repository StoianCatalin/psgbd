CREATE OR REPLACE PACKAGE points AS
    TYPE coordinate IS record
    (
    longitude NUMBER(30, 10),
    latitude NUMBER(30, 10)
    );
    TYPE coordinates IS TABLE OF coordinate INDEX BY PLS_INTEGER;
    FUNCTION returnAllPoints(p_id_interesArea NUMBER) RETURN coordinates;
    FUNCTION computeArea(p_id_interesArea NUMBER) RETURN NUMBER; --se va apela ca points.computeArea(id-ul unui interesArea) pentru a returna aria punctelor.
    FUNCTION computeDistance(finalCoordinates coordinates) RETURN NUMBER;
    FUNCTION returnDistanceBetweenTwoPoints(p_id_locPoint1 NUMBER, p_id_locPoint2 NUMBER) RETURN NUMBER; -- se va apela ca points.returnDistanceBetweenTwoPoints(2 id-uri din locationPoints
--pentru a calcula distanta (in km) intre 2 puncte.
END points;

/

CREATE OR REPLACE PACKAGE BODY points AS

	FUNCTION returnAllPoints(p_id_interesArea NUMBER)
	RETURN coordinates
	AS
			CURSOR locationPointsList IS
				SELECT longitude, latitude FROM locationPoints
					WHERE interesArea_fk = p_id_interesArea;
			longitude NUMBER(30, 10);
			latitude NUMBER(30, 10);
			finalCoordinates coordinates;
			counter NUMBER := 1;
			exists_interesArea NUMBER;
	BEGIN
			SELECT count(*) INTO exists_interesArea FROM interesAreas WHERE id = p_id_interesArea;

			IF(exists_interesArea <> 1) 
			THEN
				RAISE exceptions.not_a_entity_id;
			END IF;

			OPEN locationPointsList;
			LOOP 
				FETCH locationPointsList INTO longitude, latitude;
				EXIT WHEN locationPointsList%NOTFOUND;
				finalCoordinates(counter).longitude := longitude;
				finalCoordinates(counter).latitude := latitude;
				counter := counter + 1;
			END LOOP;
			RETURN finalCoordinates;
			EXCEPTION 
			WHEN exceptions.not_a_user THEN
  				raise_application_error (-20003, 'The interesArea id: ' || p_id_interesArea || ' does not exist in our atabase');
	END returnAllPoints;

	FUNCTION radians(degree NUMBER) 
	RETURN NUMBER
	AS
	BEGIN
			RETURN degree /(180/ACOS(-1));
	END radians;

	FUNCTION computeArea(p_id_interesArea NUMBER)
	RETURN NUMBER
	AS
			finalCoordinates coordinates := returnAllPoints(p_id_interesArea);
			area NUMBER(30, 10) := 0.0;
	BEGIN
			FOR i IN finalCoordinates.FIRST..finalCoordinates.LAST - 1 LOOP
				area := area + RADIANS (finalCoordinates(i+1).longitude - finalCoordinates(i).longitude) * (2 + SIN(RADIANS (finalCoordinates(i).latitude)) + SIN(RADIANS (finalCoordinates(i+1).latitude)));
			END LOOP;
			area := ABS (area * 6371 * 6371 / 2);
			RETURN area;
	END computeArea;

	FUNCTION computeDistance(finalCoordinates coordinates)
	RETURN NUMBER
	AS
			distance NUMBER(30, 10);
			R NUMBER := 6371; --raza globului
			dLat NUMBER(30, 10);
			dLon NUMBER(30, 10);
			a NUMBER(30, 10);
			c NUMBER(30, 10);
			d NUMBER(30, 10);
	BEGIN
			dLat := RADIANS(finalCoordinates(2).latitude - finalCoordinates(1).latitude);
			dLon := RADIANS(finalCoordinates(2).longitude - finalCoordinates(1).longitude);
			a := SIN (dLat / 2) * SIN (dLat / 2) + COS (RADIANS (finalCoordinates(1).latitude)) * COS (RADIANS (finalCoordinates(2).latitude)) * SIN (dLon / 2) * SIN (dLon / 2);
			c := 2 * ATAN2 (SQRT (a), SQRT (1-a));
			d := R * c;
			RETURN d;
	END computeDistance;

	FUNCTION returnDistanceBetweenTwoPoints(p_id_locPoint1 NUMBER, p_id_locPoint2 NUMBER)
	RETURN NUMBER
	AS
			CURSOR locationPointsList IS
				SELECT longitude, latitude FROM locationPoints
					WHERE id IN (p_id_locPoint1, p_id_locPoint2);
			longitude NUMBER(30, 10);
			latitude NUMBER(30, 10);
			finalCoordinates coordinates;
			counter NUMBER := 1;
			distance NUMBER(30, 10);
			exists_locationPoints NUMBER;
	BEGIN
			SELECT count(*) INTO exists_locationPoints FROM locationPoints WHERE id in (p_id_locPoint1, p_id_locPoint2);

			IF (exists_locationPoints <> 2)
			THEN
				RAISE exceptions.not_a_entity_id;
			END IF;

			OPEN locationPointsList;
			LOOP 
				FETCH locationPointsList INTO longitude, latitude;
				EXIT WHEN locationPointsList%NOTFOUND;
				finalCoordinates(counter).longitude := longitude;
				finalCoordinates(counter).latitude := latitude;
				counter := counter + 1;
			END LOOP;
			distance := computeDistance(finalCoordinates);
			RETURN distance;
			EXCEPTION 
			WHEN exceptions.not_a_user THEN
  				raise_application_error (-20003, 'The arguments do not exist in our atabase');
	END returnDistanceBetweenTwoPoints;
END points;






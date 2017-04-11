CREATE OR REPLACE PACKAGE user
AS
	FUNCTION insertUser(name VARCHAR2, email VARCHAR2, password VARCHAR2, type NUMBER, facebook VARCHAR2, photo VARCHAR2, birthdate DATE) RETURN NUMBER;
	FUNCTION updatePassword(email VARCHAR2, newPassword VARCHAR2) RETURN NUMBER;
	FUNCTION logIn(email VARCHAR2, password VARCHAR2) RETURN NUMBER;
END user;

CREATE OR REPLACE PACKAGE BODY user
IS 

	FUNCTION insertUser(name VARCHAR2, email VARCHAR2, password VARCHAR2, type NUMBER, facebook VARCHAR2, photo VARCHAR2, birthdate DATE)
	RETURN NUMBER;
	AS
		v_counter NUMBER;
	BEGIN
		SELECT count(*) INTO v_counter FROM utilizatori WHERE utilizatori.email = email;
		IF(v_counter <> 0) 
		THEN
			RETURN 0; --urmeaza sa returneze exceptie
		END IF;
		INSERT INTO utilizatori VALUES(NULL, name, email, password, type, facebook, photo, birthdate, sysdate);
		RETURN 1;
	END insertUser;

	FUNCTION updatePassword(email VARCHAR2, newPassword VARCHAR2)
	RETURN NUMBER
	AS
		v_counter NUMBER;
	BEGIN
		SELECT count(*) INTO v_counter FROM utilizatori WHERE utilizatori.email = email;
		IF(v_counter <> 1) 
		THEN
			RETURN 0; --urmeaza sa returneze exceptie
		END IF;
		UPDATE utilizatori SET utilizatori.password = newPassword WHERE utilizatori.email = email;
		RETURN 1;
	END updatePassword;

	FUNCTION logIn(email VARCHAR2, password VARCHAR2) 
	RETURN NUMBER
	AS
		v_counter NUMBER;
	BEGIN
		SELECT count(*) INTO v_counter FROM utilizatori WHERE utilizatori.email = email AND utilizatori.password = password;
		IF(v_counter <> 1) 
		THEN
			RETURN 0; --urmeaza sa returneze exceptie
		END IF;

		RETURN 1;
	END logIn;
END user;

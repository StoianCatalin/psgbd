CREATE OR REPLACE PACKAGE userOperations
AS
	FUNCTION insertUser(name VARCHAR2, p_email VARCHAR2, password VARCHAR2, type NUMBER, facebook VARCHAR2, photo VARCHAR2, birthdate DATE) RETURN NUMBER;
	FUNCTION updatePassword(p_email VARCHAR2, newPassword VARCHAR2) RETURN NUMBER;
	FUNCTION logIn(p_email VARCHAR2, p_password VARCHAR2) RETURN NUMBER;
END userOperations;

/

CREATE OR REPLACE PACKAGE BODY userOperations AS

	FUNCTION insertUser(name VARCHAR2, p_email VARCHAR2, password VARCHAR2, type NUMBER, facebook VARCHAR2, photo VARCHAR2, birthdate DATE)
	RETURN NUMBER
  AS
    v_counter NUMBER(5);
	BEGIN
		SELECT count(*) INTO v_counter FROM utilizatori WHERE utilizatori.email = p_email;
		IF(v_counter <> 0) 
		THEN
			RAISE exceptions.not_a_user;
		END IF;

		IF(p_email NOT LIKE '%@%.%') 
		THEN
			RAISE exceptions.not_a_valid_parameter;
		END IF;

		INSERT INTO utilizatori VALUES(NULL, name, p_email, password, type, facebook, photo, birthdate, sysdate);
		COMMIT;
		RETURN 1;
		EXCEPTION 
		WHEN exceptions.not_a_user THEN
  			raise_application_error (-20002, 'The user with email ' || p_email || ' already exists in our database');
  		WHEN exceptions.not_a_valid_parameter THEN
  			raise_application_error (-20005, 'The email ' || p_email || ' is not a valid one.');
	END insertUser;

	FUNCTION updatePassword(p_email VARCHAR2, newPassword VARCHAR2)
	RETURN NUMBER
  AS
		v_counter NUMBER;
	BEGIN
		SELECT count(*) INTO v_counter FROM utilizatori WHERE utilizatori.email = p_email;
		IF(v_counter <> 1) 
		THEN
			RAISE exceptions.not_a_user;
			RETURN 0;
		END IF;
		UPDATE utilizatori SET utilizatori.password = newPassword WHERE utilizatori.email = p_email;
		RETURN 1;
		EXCEPTION 
		WHEN exceptions.not_a_user THEN
  			raise_application_error (-20002, 'The user with email ' || p_email || ' is not in our database');
	END updatePassword;

	FUNCTION logIn(p_email VARCHAR2, p_password VARCHAR2) 
	RETURN NUMBER
	AS
		v_counter NUMBER := 0;
	BEGIN
		SELECT count(*) INTO v_counter FROM utilizatori WHERE utilizatori.email = p_email AND utilizatori.password = p_password;
		IF(v_counter <> 1) 
		THEN
			RAISE exceptions.not_a_user;
			RETURN 0;
		END IF;

		RETURN 1;
	EXCEPTION 
		WHEN exceptions.not_a_user THEN
  			raise_application_error (-20002, 'The user with email ' || p_email || ' is not in our database');
	END logIn;
END userOperations;
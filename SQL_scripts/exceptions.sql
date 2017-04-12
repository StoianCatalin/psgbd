CREATE OR REPLACE PACKAGE exceptions AS
	not_a_user EXCEPTION;
	not_a_entity_id EXCEPTION;
	action_not_completed EXCEPTION;
	not_a_valid_parameter EXCEPTION;
END exceptions;

/

CREATE OR REPLACE PACKAGE BODY exceptions
IS
	not_a_user EXCEPTION;
	PRAGMA EXCEPTION_INIT(not_a_user, -20002);
	not_a_entity_id EXCEPTION;
	PRAGMA EXCEPTION_INIT(not_a_entity_id, -20003);
	action_not_completed EXCEPTION;
	PRAGMA EXCEPTION_INIT(action_not_completed, -20004);
	not_a_valid_parameter EXCEPTION;
	PRAGMA EXCEPTION_INIT(not_a_valid_parameter, -20005);
END exceptions;
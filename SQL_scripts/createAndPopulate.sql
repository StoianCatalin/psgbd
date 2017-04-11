drop table utilizatori CASCADE CONSTRAINTS;

drop table locationPoints CASCADE CONSTRAINTS;

drop table notifications CASCADE CONSTRAINTS;

drop table interesAreas CASCADE CONSTRAINTS;

drop table interesPoints CASCADE CONSTRAINTS;

drop table objects CASCADE CONSTRAINTS;

drop table relatives CASCADE CONSTRAINTS;

drop trigger utilizatori_insert;

drop trigger locationPoints_insert;

drop trigger notifications_insert;

drop trigger interesAreas_insert;

drop trigger interesPoints_insert;

drop trigger objects_insert;

drop trigger relatives_insert;

drop sequence locationPoints_sequence;

drop sequence notifications_sequece;

drop sequence interesAreas_sequence;

drop sequence interesPoints_sequence;

drop sequence objects_sequence;

drop sequence relatives_sequence;

drop sequence utilizatori_sequence;


create table utilizatori(
id NUMBER(5) NOT NULL,
name VARCHAR2(60) NOT NULL,
email VARCHAR2(40) NOT NULL,
password VARCHAR2(50) NOT NULL,
type NUMBER(2) NOT NULL,
facebook VARCHAR2(50),
photo VARCHAR2(50),
birthDate DATE,
createdDate TIMESTAMP,
PRIMARY KEY(id));
/


create table notifications(
id NUMBER(5) NOT NULL,
parent_fk NUMBER(5) NOT NULL,
child_fk NUMBER(5) NOT NULL,
type NUMBER(2) NOT NULL,
message VARCHAR2(200),
createdDate TIMESTAMP NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(parent_fk) REFERENCES utilizatori(id),
FOREIGN KEY(child_fk) REFERENCES utilizatori(id)
);
/


create table interesAreas(
id NUMBER(5) NOT NULL,
parent_fk NUMBER(5) NOT NULL,
name VARCHAR2(30) NOT NULL,
createdDate TIMESTAMP NOT NULL,
updatedDate TIMESTAMP DEFAULT NULL,
PRIMARY KEY(id),
FOREIGN KEY(parent_fk) REFERENCES utilizatori(id)
);
/

create table locationPoints(
id NUMBER(5) NOT NULL,
utilizatori_fk NUMBER(5) NOT NULL,
longitude NUMBER(30, 10) NOT NULL,
latitude NUMBER(30, 10) NOT NULL,
createdDate TIMESTAMP NOT NULL,
interesArea_fk NUMBER(5),
PRIMARY KEY(id),
FOREIGN KEY (utilizatori_fk) REFERENCES utilizatori(id),
FOREIGN KEY (interesArea_fk) REFERENCES interesAreas(id)
);
/



create table interesPoints(
id NUMBER(5) NOT NULL,
interesArea_fk NUMBER(5) NOT NULL,
longitude NUMBER(30, 10) NOT NULL,
latitude NUMBER(30, 10) NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(interesArea_fk) REFERENCES interesAreas(id)
);
/


create table objects(
id NUMBER(5) NOT NULL,
name VARCHAR2(30) NOT NULL,
height NUMBER(30, 10) NOT NULL,
width NUMBER(30, 10) NOT NULL,
weight NUMBER(30, 10) NOT NULL,
notification_fk NUMBER(5) NOT NULL,
dangerLevel NUMBER(2) NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(notification_fk) REFERENCES notifications(id)
);
/

create table relatives(
parent_fk NUMBER(5) NOT NULL,
child_fk NUMBER(5) NOT NULL,
FOREIGN KEY (parent_fk) REFERENCES utilizatori(id),
FOREIGN KEY (child_fk) REFERENCES utilizatori(id)
);
/

CREATE SEQUENCE utilizatori_sequence
START WITH 1
INCREMENT BY 1
CACHE 20000;
/

CREATE OR REPLACE TRIGGER utilizatori_insert
BEFORE INSERT ON utilizatori
FOR EACH ROW
BEGIN
SELECT utilizatori_sequence.nextval
INTO :new.id
FROM DUAL;
END;
/

CREATE SEQUENCE locationPoints_sequence
START WITH 1
INCREMENT BY 1
CACHE 20000;
/

CREATE OR REPLACE TRIGGER locationPoints_insert
BEFORE INSERT ON utilizatori
FOR EACH ROW
BEGIN
SELECT locationPoints_sequence.nextval
INTO :new.id
FROM DUAL;
END;
/

CREATE SEQUENCE notifications_sequence
START WITH 1
INCREMENT BY 1
CACHE 20000;
/


CREATE OR REPLACE TRIGGER notifications_insert
BEFORE INSERT ON utilizatori
FOR EACH ROW
BEGIN
SELECT notifications_sequence.nextval
INTO :new.id
FROM DUAL;
END;
/

CREATE SEQUENCE interesAreas_sequence
START WITH 1
INCREMENT BY 1
CACHE 20000;
/

CREATE OR REPLACE TRIGGER interesAreas_insert
BEFORE INSERT ON utilizatori
FOR EACH ROW
BEGIN
SELECT interesAreas_sequence.nextval
INTO :new.id
FROM DUAL;
END;
/

CREATE SEQUENCE interesPoints_sequence
START WITH 1
INCREMENT BY 1
CACHE 20000;
/

CREATE OR REPLACE TRIGGER interesPoints_insert
BEFORE INSERT ON utilizatori
FOR EACH ROW
BEGIN
SELECT interesPoints_sequence.nextval
INTO :new.id
FROM DUAL;
END;
/

CREATE SEQUENCE objects_sequence
START WITH 1
INCREMENT BY 1
CACHE 20000;
/

CREATE OR REPLACE TRIGGER objects_insert
BEFORE INSERT ON utilizatori
FOR EACH ROW
BEGIN
SELECT objects_sequence.nextval
INTO :new.id
FROM DUAL;
END;
/

set serveroutput on;
DECLARE

v_email varchar2(40);
v_password varchar2(64);
v_type NUMBER(2, 0);
v_photo varchar2(50);
v_birthdate DATE;

CURSOR utilizatori IS
  SELECT name, username FROM users;
  
v_name users.name%type;
v_username users.username%type;
BEGIN
OPEN utilizatori;
LOOP
  FETCH utilizatori INTO v_name, v_username;
  EXIT WHEN utilizatori%NOTFOUND;
  v_email := v_username || '@info.uaic.ro';
  v_password := v_username;
  v_type := 1;
  select TO_DATE(
              TRUNC(
                   DBMS_RANDOM.VALUE(TO_CHAR(DATE '1997-01-01','J')
                                    ,TO_CHAR(DATE '1997-12-31','J')
                                    )
                    ),'J'
               ) into v_birthdate FROM DUAL;
INSERT INTO utilizatori(id, name, email, password, type, facebook, photo, birthdate, createddate) VALUES(null, v_name, v_email, v_password, (select dbms_random.value(1,2) num from dual), v_username || '.facebook.com', v_username || '.photos.com', v_birthdate, sysdate);
END LOOP;
END;

/

declare

v_id NUMBER(5, 0) := 1;
v_longitude NUMBER(30, 10);
v_latitude NUMBER(30, 10);
v_utilizator NUMBER(5, 0);

begin

while (v_id < 12000)

loop

select dbms_random.value(0, 10000) into v_longitude from dual;
select dbms_random.value(0, 10000) into v_latitude from dual;
select cast(dbms_random.value(6001, 11199) as NUMBER(5, 0)) into v_utilizator from dual;


INSERT INTO locationpoints values(v_id, v_utilizator, v_longitude, v_latitude, sysdate);

v_id := v_id +1;


end loop;

commit;
end;
/


--bloc pentru popularea tabelei relatives
declare
cursor parent is select id from utilizatori where type = 1;
cursor child is select id from utilizatori where type = 2;
v_id_child utilizatori.id%type;
v_id_parent utilizatori.id%type;
v_id INTEGER := 1;
v_count INTEGER;

begin

open parent;
open child;
  loop
    fetch parent into v_id_parent;
    fetch child into v_id_child;
    exit when parent%notfound or child%notfound;
    INSERT INTO relatives values(v_id_parent, v_id_child);
  end loop;

end;

/

--pachet pentru a lua numele parintelui / copilului

CREATE OR REPLACE PACKAGE relativesConnection IS
	FUNCTION getChildName(p_parentId INTEGER) RETURN VARCHAR2;
	FUNCTION getParentName(p_childId INTEGER) RETURN VARCHAR2;
END relativesConnection;


/

CREATE OR REPLACE PACKAGE BODY relativesConnection IS

FUNCTION getChildName(p_parentId INTEGER) RETURN VARCHAR2 as
	v_childId INTEGER;
	v_childName VARCHAR2(30);
	BEGIN
	SELECT child_fk INTO v_childId FROM relatives WHERE parent_fk = p_parentId;
	SELECT name INTO v_childName FROM utilizatori WHERE id = v_childId;
	RETURN v_childName;
END getChildName;

FUNCTION getParentName(p_childId INTEGER) RETURN VARCHAR2 as
	v_parentId INTEGER;
	v_parentName VARCHAR2(30);
	BEGIN
	SELECT parent_fk INTO v_parentId FROM relatives WHERE child_fk = p_childId;
	SELECT name INTO v_parentName  FROM utilizatori WHERE id = v_parentId;
	RETURN v_parentName;
END getParentName;

END relativesConnection;
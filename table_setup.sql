/*
 *  File name:  setup.sql
 *  Function:   to create the initial database schema for the CMPUT 391 project,
 *              Winter Term, 2015
 *  Author:     Prof. Li-Yan Yuan
 */
DROP TABLE family_doctor;
DROP TABLE pacs_images;
DROP TABLE radiology_record;
DROP TABLE users;
DROP TABLE persons;

/*
 *  To store the personal information
 */
CREATE TABLE persons (
   person_id int,
   first_name varchar(24),
   last_name  varchar(24),
   address    varchar(128),
   email      varchar(128),
   phone      char(10),
   PRIMARY KEY(person_id),
   UNIQUE (email)
);

/*
 *  To store the log-in information
 *  Note that a person may have been assigned different user_name(s), depending
 *  on his/her role in the log-in  
 */
CREATE TABLE users (
   user_name varchar(24),
   password  varchar(24),
   class     char(1),
   person_id int,
   date_registered date,
   CHECK (class in ('a','p','d','r')),
   PRIMARY KEY(user_name),
   FOREIGN KEY (person_id) REFERENCES persons
);

/*
 *  to indicate who is whose family doctor.
 */
CREATE TABLE family_doctor (
   doctor_id    int,
   patient_id   int,
   FOREIGN KEY(doctor_id) REFERENCES persons,
   FOREIGN KEY(patient_id) REFERENCES persons,
   PRIMARY KEY(doctor_id,patient_id)
);

/*
 *  to store the radiology records
 */
CREATE TABLE radiology_record (
   record_id   int,
   patient_id  int,
   doctor_id   int,
   radiologist_id int,
   test_type   varchar(24),
   prescribing_date date,
   test_date    date,
   diagnosis    varchar(128),
   description   varchar(1024),
   PRIMARY KEY(record_id),
   FOREIGN KEY(patient_id) REFERENCES persons,
   FOREIGN KEY(doctor_id) REFERENCES  persons,
   FOREIGN KEY(radiologist_id) REFERENCES  persons
);

/*
 *  to store the pacs images
 */
CREATE TABLE pacs_images (
   record_id   int,
   image_id    int,
   thumbnail   blob,
   regular_size blob,
   full_size    blob,
   PRIMARY KEY(record_id,image_id),
   FOREIGN KEY(record_id) REFERENCES radiology_record
);

/* Create Admin */
INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (1, 'Random', 'Guy', 'Canada', 'phoboy@ualberta.ca', '7800000000');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (2, 'Some', 'Dude', '123 Street', 'fakeemail@mail.com', '7805553333');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (3, 'Blah', 'Bla', '143 Street', 'realgmail@mail.com', '7803253334');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (4, 'Bugs', 'Bunny', 'Looney', 'toon@tele.com', '0000000000');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (5, 'doc', 'two', '123 Street', 'doc@mail.com', '1111111111');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (6, 'doc', 'three', '143 Street', 'doc2@mail.com', '2222222222');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (7, 'doc2', 'three', '143 Street', 'doc23@mail.com', '2222222222');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (8, 'radi', 'ologis', '143 Street', 'radi@mail.com', '1234567890');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (9, 'rad', 'ologis', '143 Street', 'radio@mail.com', '3333333333');
INSERT INTO persons values (10, 'Bob0', 'Smith', '123 apple st.', 'Bob@bob.ca', '4039912288');
INSERT INTO persons values (11, 'Bob1', 'Smith', '123 apple st.', 'Bob1@bob.ca', '4039912288');
INSERT INTO persons values (12, 'Bob2', 'Smith', '123 apple st.', 'Bob2@bob.ca', '4039912288');
INSERT INTO persons values (13, 'Bob3', 'Smith', '123 apple st.', 'Bob3@bob.ca', '4039912288');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(1, 2, 5, 8, 'X-Ray', to_date('02/01/2012', 'DD/MM/YYYY'), to_date('02/01/2014', 'DD/MM/YYYY'), 'Rib Fracture', 'Two rib bones on right side');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(2, 2, 6, 9, 'Ultra Sound', to_date('31/03/2014', 'DD/MM/YYYY'), to_date('31/03/2014', 'DD/MM/YYYY'), 'Tumor', 'Stomach Tumor of 2 cm');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(3, 3, 6, 9, 'Ultra Sound', to_date('02/02/2014', 'DD/MM/YYYY'), to_date('02/02/2014', 'DD/MM/YYYY'), 'Stone', 'Stone of 2 cm in right kidney');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(4, 3, 4, 9, 'X- Ray', to_date('28/03/2014', 'DD/MM/YYYY'), to_date('28/03/2014', 'DD/MM/YYYY'), 'Elbow Fracture', 'Fracture of Right Elbow');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(5, 4, 6, 9, 'X-Ray', to_date('04/12/2013', 'DD/MM/YYYY'), to_date('04/12/2013', 'DD/MM/YYYY'), 'Femur', 'Fracture of 4 cm');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(6, 5, 5, 9, 'MRI', to_date('23/03/2014', 'DD/MM/YYYY'), to_date('23/03/2014', 'DD/MM/YYYY'), 'Stone', 'Inside Gall Bladder');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(7, 6, 5, 9, 'MRI', to_date('23/02/2014', 'DD/MM/YYYY'), to_date('23/02/2014', 'DD/MM/YYYY'), 'Stone', 'Inside Gall Bladder');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(8, 7, 5, 9, 'MRI', to_date('23/01/2014', 'DD/MM/YYYY'), to_date('23/01/2014', 'DD/MM/YYYY'), 'Stone', 'Inside Gall Bladder');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(9, 8, 5, 9, 'MRI', to_date('26/03/2014', 'DD/MM/YYYY'), to_date('26/03/2014', 'DD/MM/YYYY'), 'Stone', 'Inside Gall Bladder');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(10, 9, 5, 9, 'MRI', to_date('23/03/2013', 'DD/MM/YYYY'), to_date('23/03/2013', 'DD/MM/YYYY'), 'Stone', 'Inside Gall Bladder');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(11, 10, 12, 13, 'MRI', to_date('23/03/2013', 'DD/MM/YYYY'), to_date('23/03/2013', 'DD/MM/YYYY'), 'Stone', 'Inside Gall Bladder');

INSERT INTO users values('admin', 'admin', 'a', 1, TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO users values('doctor', 'doctor', 'd', 2, TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO users values('radio', 'radio', 'r', 3, TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO users values('patient', 'patient', 'p', 4, TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO users values('t1', 't1', 'd', 12, TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO users values('t2', 't2', 'p', 10, TO_DATE('2003/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO family_doctor values(4, 1);

INSERT INTO family_doctor values(4, 3);

CREATE SEQUENCE pic_id_sequence;

CREATE INDEX myindex1 ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX myindex2 ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX myindex3 ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;
CREATE INDEX myindex4 ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;

set serveroutput on
declare
  job number;
begin
  dbms_job.submit(job, 'ctx_ddl.sync_index(''myindex1'');',
                  interval=>'SYSDATE+1/1440');
  commit;
  dbms_output.put_line('job '||job||' has been submitted.');
end;
/

set serveroutput on
declare
  job number;
begin
  dbms_job.submit(job, 'ctx_ddl.sync_index(''myindex2'');',
                  interval=>'SYSDATE+1/1440');
  commit;
  dbms_output.put_line('job '||job||' has been submitted.');
end;
/

set serveroutput on
declare
  job number;
begin
  dbms_job.submit(job, 'ctx_ddl.sync_index(''myindex3'');',
                  interval=>'SYSDATE+1/1440');
  commit;
  dbms_output.put_line('job '||job||' has been submitted.');
end;
/

set serveroutput on
declare
  job number;
begin
  dbms_job.submit(job, 'ctx_ddl.sync_index(''myindex4'');',
                  interval=>'SYSDATE+1/1440');
  commit;
  dbms_output.put_line('job '||job||' has been submitted.');
end;
/

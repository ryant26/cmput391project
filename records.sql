INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (1, 'Random', 'Guy', 'Canada', 'phoboy@ualberta.ca', '7800000000');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (2, 'Some', 'Dude', '123 Street', 'fakeemail@mail.com', '7805553333');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (3, 'Blah', 'Bla', '143 Street', 'realgmail@mail.com', '7803253334');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (4, 'Bugs', 'Bunny', 'Looney', 'toon@tele.com', '0000000000');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (5, 'doc', 'two', '123 Street', 'doc@mail.com', '1111111111');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (6, 'doc', 'three', '143 Street', 'doc2@mail.com', '2222222222');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (8, 'radi', 'ologis', '143 Street', 'radi@mail.com', '1234567890');

INSERT INTO persons (person_id, first_name, last_name, address, email, phone) VALUES (9, 'rad', 'ologis', '143 Street', 'radio@mail.com', '3333333333');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(1, 2, 5, 8, 'X-Ray', to_date('02/01/2012', 'DD/MM/YYYY'), to_date('02/01/2014', 'DD/MM/YYYY'), 'Rib Fracture', 'Two rib bones on right side');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(2, 2, 6, 9, 'Ultra Sound', to_date('31/03/2014', 'DD/MM/YYYY'), to_date('31/03/2014', 'DD/MM/YYYY'), 'Tumor', 'Stomach Tumor of 2 cm');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(3, 3, 6, 9, 'Ultra Sound', to_date('02/02/2014', 'DD/MM/YYYY'), to_date('02/02/2014', 'DD/MM/YYYY'), 'Stone', 'Stone of 2 cm in right kidney');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(4, 3, 4, 9, 'X- Ray', to_date('28/03/2014', 'DD/MM/YYYY'), to_date('28/03/2014', 'DD/MM/YYYY'), 'Elbow Fracture', 'Fracture of Right Elbow');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(5, 4, 6, 9, 'X-Ray', to_date('04/12/2013', 'DD/MM/YYYY'), to_date('04/12/2013', 'DD/MM/YYYY'), 'Femur', 'Fracture of 4 cm');

insert into radiology_record(record_id,patient_id,doctor_id,radiologist_id,test_type,prescribing_date,test_date,diagnosis, description) values(6, 4, 5, 9, 'MRI', to_date('23/03/2014', 'DD/MM/YYYY'), to_date('23/03/2014', 'DD/MM/YYYY'), 'Stone', 'Inside Gall Bladder');


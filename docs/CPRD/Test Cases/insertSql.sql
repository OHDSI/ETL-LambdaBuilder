TRUNCATE TABLE cprd_native_test.patient;
TRUNCATE TABLE cprd_native_test.practice;
TRUNCATE TABLE cprd_native_test.staff;
TRUNCATE TABLE cprd_native_test.clinical;
TRUNCATE TABLE cprd_native_test.immunisation;
TRUNCATE TABLE cprd_native_test.referral;
TRUNCATE TABLE cprd_native_test.test;
TRUNCATE TABLE cprd_native_test.therapy;
TRUNCATE TABLE cprd_native_test.consultation;
TRUNCATE TABLE cprd_native_test.additional;
TRUNCATE TABLE cprd_native_test.batchnumbers;
TRUNCATE TABLE cprd_native_test.bnfcodes;
TRUNCATE TABLE cprd_native_test.commondosages;
TRUNCATE TABLE cprd_native_test.daysupply_decodes;
TRUNCATE TABLE cprd_native_test.daysupply_modes;
TRUNCATE TABLE cprd_native_test.entity;
TRUNCATE TABLE cprd_native_test.lookup;
TRUNCATE TABLE cprd_native_test.lookuptype;
TRUNCATE TABLE cprd_native_test.medical;
TRUNCATE TABLE cprd_native_test.packtype;
TRUNCATE TABLE cprd_native_test.product;
TRUNCATE TABLE cprd_native_test.scoringmethod;
-- 311: Practice_id=301, region=13, id is care_site_id
INSERT INTO cprd_native_test.practice(pracid, region, uts, lcd) VALUES ('311', '13', '2000-01-01', '2016-12-31');
-- 1111: Patient has Medical records that collapse in the Condition Era table
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('1111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('1111', '2012-01-01', '2014-06-12', '6', '2591944', '1058', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('1111', '2012-01-02', '2014-06-12', '6', '2591944', '1058', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('1058', 'F563500');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('898', 'K17y000');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('100895', 'N22y700');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('45999', 'J040.14');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('11531', 'P00..00');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('35968', 'PB2z.00');
-- 2111: Read clinical condition with visit, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('2111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('2111', '2012-01-01', '2014-06-12', '6', '2591944', '1058', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('2111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 3111: Read clinical condition, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('3111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('3111', '2012-03-01', '2014-06-12', '6', '2591944', '898', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('3111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 4111: Read clinical condition outside observation period, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('4111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('4111', '2009-03-01', '2014-06-12', '6', '4111', '898', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, consid, staffid, duration) VALUES ('4111', '2009-03-01', '2014-06-12', '9', '4111', '9001', '0');
-- 5111: Read immunisation condition, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('5111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('5111', '2011-03-01', '2014-06-12', '6', '2591944', '45999', '1001', '4', '2', '0');
-- 6111: Read referral condition, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('6111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.referral(patid, eventdate, sysdate, constype, medcode, staffid, source, nhsspec, fhsaspec, inpatient, attendance, urgency) VALUES ('6111', '2011-03-01', '2002-08-02', '4', '11531', '1001', '1', '0', '0', '3', '0', '0');
-- 7111: Read test condition with no visit, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('7111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('7111', '2011-03-01', '1001', '2014-06-12', '2', '35968', '215', '9', '96.000', '0.000', '0');
-- 8111: Read clinical condition that occurs in 2099, record removed
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('8111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('8111', '2099-01-01', '2014-06-12', '6', '2591944', '1058', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('8111', '2099-01-01', '2014-06-12', '9', '9001', '0');
-- 9111: Read test condition occurs in 2099, record removed
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('9111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('9111', '2099-03-01', '1001', '2014-06-12', '2', '35968', '215', '9', '96.000', '0.000', '0');
-- 10111: drug era with 2 drug records, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('10111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('10111', '2012-01-01', '2015-08-03', '2', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '20', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('10111', '2012-01-01', '2014-06-12', '9', '9001', '0');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('10111', '2012-01-20', '2015-08-03', '2', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '30', '0', '1', '1');
-- 11111: drug era with multilex drug code id is person_id
INSERT INTO cprd_native_test.product(prodcode, gemscriptcode, productname, bnf, bnf_with_dots, bnfchapter) VALUES ('2232', '90473020', 'Ibuprofen lysine 400mg tablets', '00000000', '00.00.00.00', 'Unknown');
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('11111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('11111', '2012-01-31', '2015-08-03', '2232', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '30', '0', '1', '1');
INSERT INTO cprd_native_test.product(prodcode, gemscriptcode, bnf, bnf_with_dots, bnfchapter) VALUES ('2', '58976020', '00000000', '00.00.00.00', 'Unknown');
INSERT INTO cprd_native_test.product(prodcode, gemscriptcode, bnf, bnf_with_dots, bnfchapter) VALUES ('9999', '93680020', '00000000', '00.00.00.00', 'Unknown');
INSERT INTO cprd_native_test.product(prodcode, gemscriptcode, bnf, bnf_with_dots, bnfchapter) VALUES ('46190', '99978020', '00000000', '00.00.00.00', 'Unknown');
-- 12111: testing the lookup for numdays does correct end date start+28 days, id is person_id
INSERT INTO cprd_native_test.daysupply_decodes(prodcode, daily_dose, qty, numpacks, numdays) VALUES ('2', '0.000', '1', '0', '29');
INSERT INTO cprd_native_test.commondosages(dosageid, dosage_text, daily_dose, dose_number, dose_frequency, dose_interval, choice_of_dose, dose_max_average, change_dose, dose_duration) VALUES ('2', '<OTHER>', '0', '1.000', '1.000', '1.000', '0', '0', '0', '0.000');
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('12111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('12111', '2012-01-01', '2015-08-03', '2', '9001', '2', '55', '1', '0', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('12111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 13111: testing when there is no lookup available default to start dte, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('13111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('13111', '2012-01-01', '2015-08-03', '42', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '0', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('13111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 14111: The drug records comes in without a valid days supply, no lookup in DAYSSUPPLY_DECODES, no lookups in DAYSSUPPLY_MODES, assume 1 day duration.Id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('14111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('14111', '2012-01-01', '2015-08-03', '9999', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '0', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('14111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 15111: testing end date: You have a THERAPY.NUMDAYS = 40. Id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('15111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('15111', '2012-01-01', '2015-08-03', '2', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '40', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('15111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 16111: testing end date: You have a THERAPY.NUMDAYS = 366 - show correct to 29 days using lookup. Id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('16111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('16111', '2012-01-01', '2015-08-03', '2', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '366', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('16111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 17111: Test visit_occurrence_id: Drug is written to DRUG_EXPOSURE. Id is person_Id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('17111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('17111', '2012-03-12', '2015-08-03', '2', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '366', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('17111', '2012-03-12', '2014-06-12', '9', '9001', '0');
-- 18111: Drug date does exist within a valid observation period but does not have a consultation date. Id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('18111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('18111', '2012-01-01', '2015-08-03', '2', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '366', '0', '1', '1');
-- 19111: PRODCODE = -1 - invalid.
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('19111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('19111', '2012-01-01', '2015-08-03', '-1', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '366', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('19111', '2012-01-01', '2014-06-12', '9', '9001', '0');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('72', '65F5.00');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('28', '6564.00');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('58', '65B..00');
-- 20111: Invalid status, id = person_Id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('20111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('20111', '2012-01-01', '2014-07-09', '4', '72', '1001', '1', '2', '4', '0', '1', '3', '1', '0');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('1', '65M2.00');
-- 21111: valid immunization with visit, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('21111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('21111', '2012-01-01', '2014-07-09', '4', '1', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('21111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 22111: valid immunization without visit - null visit_occur_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('22111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('22111', '2012-01-01', '2014-07-09', '4', '1', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 23111: Read  outside observation period, id = person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('23111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('23111', '2009-03-01', '2014-06-12', '6', '2591944', '1', '1001', '4', '2', '0');
-- 24111: immunization read code condition goes into conditions, id = person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('24111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('24111', '2009-03-01', '2014-07-09', '4', '1058', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 25111: valid read from clinical, id = patient$person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('25111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('25111', '2010-03-01', '2014-06-12', '6', '2591944', '1', '1001', '4', '2', '0');
-- 26111: valid read from referral, id = person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('26111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.referral(patid, eventdate, sysdate, constype, medcode, staffid, source, nhsspec, fhsaspec, inpatient, attendance, urgency) VALUES ('26111', '2010-03-01', '2002-08-02', '4', '1', '1001', '1', '0', '0', '3', '0', '0');
-- 27111: valid read from test, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('27111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('27111', '2010-03-01', '1001', '2014-06-12', '2', '1', '215', '9', '96.000', '0.000', '0');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('202', '65A..00');
-- 28111: valid entry, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('28111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('28111', '2010-03-01', '2014-06-12', '6', '2591944', '202', '1001', '4', '2', '0');
-- 29111: valid entry, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('29111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('29111', '2010-03-01', '2014-06-12', '6', '2591944', '202', '1001', '4', '2', '0');
-- 30111: immunization record in future, record removed
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('30111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('30111', '2099-01-01', '2014-07-09', '4', '1', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 31111: Drug date occurs in 2099, record removed
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('31111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('31111', '2099-01-01', '2015-08-03', '2', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '366', '0', '1', '1');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('25169', '9b20.00');
-- 32111: valid entry for device exposure, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('32111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('32111', '2012-01-01', '2014-07-09', '4', '25169', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 33111: You have a valid PRODCODE but doesnt get an VOCAB mapping.PRODCODE = 46190. Id is person_Id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('33111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.therapy(patid, eventdate, sysdate, prodcode, staffid, dosageid, bnfcode, qty, numdays, numpacks, packtype, issueseq) VALUES ('33111', '2012-01-01', '2015-08-03', '46190', '9001', 'c3040f6f7053ae833d9031302c4aff91b685705bbb6dbea198f5dc82fca8106a', '55', '1', '366', '0', '1', '1');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('33111', '2012-01-01', '2014-06-12', '9', '9001', '0');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('445', '424Z.00');
-- 34111: testing without hes to give visit_occurrence_id is null - clinical procedure without visit, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('34111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('34111', '2012-01-01', '2014-06-12', '6', '2591944', '445', '1001', '4', '2', '0');
-- 35111: Now test gold observation outside patient observation to exclude
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('35111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('35111', '2009-01-01', '2014-06-12', '6', '2591944', '445', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('35111', '2009-01-01', '2014-06-12', '9', '9001', '0');
-- 36111: immunisation procedure, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('36111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('36111', '2011-03-01', '2014-07-09', '4', '445', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 37111: referral procedure, id is person_Id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('37111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.referral(patid, eventdate, sysdate, constype, medcode, staffid, source, nhsspec, fhsaspec, inpatient, attendance, urgency) VALUES ('37111', '2011-03-01', '2002-08-02', '4', '445', '1001', '1', '0', '0', '3', '0', '0');
-- 38111: test procedure, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('38111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('38111', '2011-03-01', '1001', '2014-06-12', '2', '445', '215', '9', '96.000', '0.000', '0');
-- 39111: test observation record 4 fields no range values, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('39111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data4) VALUES ('39111', '2012-01-01', '1001', '2014-06-12', '2', '445', '220', '25', '0');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data4) VALUES ('220', 'Full blood count', 'Test', 'Haematology', '4', 'Qualifier', 'TQU', 'Normal range from', 'Normal range to', 'Normal range basis');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('1172', '85', '25', 'Normal');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name, description) VALUES ('85', 'TQU', 'dfbdfb');
-- 40111: test observation record 4 fields range low test, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('40111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data2, data4) VALUES ('40111', '2012-01-01', '1001', '2014-06-12', '2', '445', '220', '25', '1.2', '0');
-- 41111: test observation record 4 fields range high test, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('41111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data3, data4) VALUES ('41111', '2012-01-01', '1001', '2014-06-12', '2', '445', '220', '25', '4.3', '0');
-- 42111: test observation record 7 fields, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('42111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data2, data3, data4, data5, data6, data7) VALUES ('42111', '2012-01-01', '1001', '2014-06-12', '2', '4', '173', '3', '14.3', '56', '0', '11.5', '16.5', '0');
INSERT INTO cprd_native_test.medical(medcode, read_code, description) VALUES ('4', '42VZ.00', 'Haemoglobin estimation');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data3lkup, data4, data4lkup, data5, data6, data7, data7lkup) VALUES ('173', 'Haemoglobin', 'Test', 'Haematology', '7', 'Operator', 'OPR', 'Value', 'Unit of measure', 'SUM', 'Qualifier', 'TQU', 'Normal range from', 'Normal range to', 'Normal range basis', 'POP');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('609', '56', '3', '=');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name, description) VALUES ('56', 'OPR', 'afdafa');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('911', '83', '56', 'g/dL');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name, description) VALUES ('83', 'SUM', 'gdfhdh');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('1147', '85', '0', 'Data Not Entered');
-- 43111: test observation record enttype=284, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('43111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data2, data3, data4, data7, data8_date) VALUES ('43111', '2012-01-01', '1001', '2014-06-12', '2', '4', '284', '3', '14', '61', '0', '0', '1998-12-17');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data3lkup, data4, data4lkup, data5, data6, data7, data7lkup, data8, data8lkup) VALUES ('284', 'Maternity ultra sound scan', 'Test', 'Maternity', '8', 'Operator', 'OPR', 'Estimated size in wks', 'Unit of measure', 'SUM', 'Qualifier', 'TQU', 'Normal range from', 'Normal range to', 'Normal range basis', 'POP', 'Expected delivery date', 'dd/mm/yyyy');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('916', '83', '61', 'IU/L');
-- 44111: test observation record enttype=311, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('44111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data2, data3, data4, data7) VALUES ('44111', '2012-01-01', '1001', '2014-06-12', '2', '4', '311', '3', '120', '71', '0', '1');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data3lkup, data4, data4lkup, data5, data6, data7, data7lkup) VALUES ('311', 'PF current', 'Test', 'Asthma', '7', 'Operator', 'OPR', 'Value', 'Unit of measure', 'SUM', 'Qualifier', 'TQU', 'Normal range from', 'Normal range to', 'Peak flow device', 'PFD');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('641', '58', '1', 'Wright');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name, description) VALUES ('58', 'PFD', 'Peak flow...');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('926', '83', '71', 'L/min');
-- 45111: test observation record enttype=154, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('45111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data2, data3, data4, data7, data8_value) VALUES ('45111', '2012-01-01', '1001', '2014-06-12', '2', '4', '154', '3', '1', '0', '0', '0', '24');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data3lkup, data4, data4lkup, data5, data6, data7, data7lkup, data8) VALUES ('154', 'Alpha fetoprotein', 'Test', 'Maternity', '8', 'Operator', 'OPR', 'Value', 'Unit of measure', 'SUM', 'Qualifier', 'TQU', 'Normal range from', 'Normal range to', 'Normal range basis', 'POP', 'Weeks');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('855', '83', '0', 'No data Entered');
-- 46111: 1) additional observation, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('46111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data2, data3, data4, data5, data5lkup, data6, data6lkup, data7, data7lkup) VALUES ('1', 'Blood pressure', 'Clinical', 'Examination Findings', '7', 'Diastolic', 'Systolic', 'Korotkoff', 'Event Time', 'Laterality', 'LAT', 'Posture', 'POS', 'Cuff', 'CUF');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data2_value, data3_value, data5_value) VALUES ('46111', '1', '35', '80', '160', '5', '3');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('46111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '35');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('46111', '2010-01-01', '2014-06-12', '9', '1001', '0');
INSERT INTO cprd_native_test.practice(pracid, region, uts, lcd) VALUES ('222', '5', '2001-02-12', '2011-11-11');
-- 47222: 201222: obs_period start should be uts and obs_period_end should be tod.
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, tod, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('47222', '0', '1', '169', '0', '6', '6894', '2', '0', '0', '1948-07-05', '2000-10-26', '0', '0', '0', '2010-01-01', '0', '1', '222', '1972-01-01', '2015-01-14', '2018-12-11');
-- 48222: 202222: obs_period start should be crd and obs_period_end should be lcd since tod is null.
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, deathdate, accept, pracid, birth_date, start_date, end_date) VALUES ('48222', '0', '1', '169', '0', '6', '6894', '2', '0', '0', '1948-07-05', '2005-10-26', '0', '0', '0', '0', '2010-12-31', '1', '222', '1972-01-01', '2015-01-14', '2018-12-11');
-- 49222: 203222: patient deleted tod<uts.
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, tod, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('49222', '0', '1', '169', '0', '6', '6894', '2', '0', '0', '1948-07-05', '2000-10-26', '0', '0', '0', '1997-01-01', '0', '1', '222', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('98196', '65PT.11');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('35209', 'Q116.00');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('1137', 'R100.00');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('70038', 'Z5A6200');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('14612', '657E.00');
INSERT INTO cprd_native_test.medical(medcode, read_code, description) VALUES ('1942', 'M240012', 'Hair loss');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('28844', '66Ya.00');
-- 50111:  clinical procedure with visit
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('50111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('50111', '2012-01-01', '2014-06-12', '6', '2591944', '98196', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('50111', '2012-01-01', '2014-06-12', '9', '9001', '0');
-- 51111:  clinical procedure without visit
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('51111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('51111', '2012-03-01', '2014-06-12', '6', '2591944', '98196', '1001', '4', '2', '0');
-- 52111:  clinical procedure outside observation period
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('52111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('52111', '2009-03-01', '2014-06-12', '6', '2591944', '1137', '1001', '4', '2', '0');
-- 53111: immunisation procedure
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('53111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('53111', '2011-03-01', '2014-07-09', '4', '1137', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 54111: referral procedure
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('54111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.referral(patid, eventdate, sysdate, constype, medcode, staffid, source, nhsspec, fhsaspec, inpatient, attendance, urgency) VALUES ('54111', '2011-03-01', '2002-08-02', '4', '1137', '1001', '1', '0', '0', '3', '0', '0');
-- 55111: test procedure
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('55111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, consid, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('55111', '2011-03-01', '4244', '1001', '2014-06-12', '2', '1137', '216', '9', '96.000', '0.000', '0');
-- 56111: observation not mapped
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('56111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, consid, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('56111', '2011-03-01', '4245', '1001', '2014-06-12', '2', '70038', '216', '9', '96.000', '0.000', '0');
-- 57111: Read clinical medical history condition non-mapped
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('57111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('57111', '2011-01-01', '2014-06-12', '6', '2591944', '70038', '1001', '4', '2', '0');
-- 58111: Read referral medical history condition non-mapped
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('58111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.referral(patid, eventdate, sysdate, constype, medcode, staffid, source, nhsspec, fhsaspec, inpatient, attendance, urgency) VALUES ('58111', '2011-01-01', '2002-08-02', '4', '70038', '1001', '1', '0', '0', '3', '0', '0');
-- 59111: Read test medical history condition non-mapped
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('59111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('59111', '2011-01-01', '1001', '2014-06-12', '2', '70038', '215', '9', '96.000', '0.000', '0');
-- 60111: Read immunisatoin medical history condition non-mapped
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('60111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('60111', '2011-01-01', '2014-07-09', '4', '70038', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 61111: test observation record 4 fields
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('61111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data2, data3, data4, data7) VALUES ('61111', '2012-01-01', '1001', '2014-06-12', '2', '98196', '215', '9', '28.8', '114', '0', '0');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data4) VALUES ('215', 'Clotting tests', 'Test', 'Haematology', '4', 'Qualifier', 'TQU', 'Normal range from', 'Normal range to', 'Normal range basis');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('1156', '85', '9', 'Normal');
-- 62111: test observation record 7 fields
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('62111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, staffid, sysdate, constype, medcode, enttype, data1, data2, data3, data4, data5, data6, data7) VALUES ('62111', '2012-01-01', '1001', '2014-06-12', '2', '28844', '412', '3', '3.7', '8', '1', '3.4', '5.1', '0');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data3lkup, data4, data4lkup, data5, data6, data7, data7lkup) VALUES ('412', 'Airway ...', 'Test', 'Oter Pathology Tests', '7', 'Operator', 'OPR', 'Value', 'Unit of measure', 'SUM', 'Qualifier', 'TQU', 'Normal range from', 'Normal range to', 'Normal range basis', 'POP');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('856', '56', '3', '=');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('1155', '83', '8', '%');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('1407', '85', '1', 'High');
INSERT INTO cprd_native_test.product(prodcode, gemscriptcode, productname, bnf, bnf_with_dots, bnfchapter) VALUES ('42', '72487020', 'Simvastatin 10mg tablets', '00000000', '00.00.00.00', 'Unknown');
INSERT INTO cprd_native_test.medical(medcode, read_code, description) VALUES ('1942', 'M240012', 'Hair loss');
-- 63111: 1) additional observation 
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('63111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data2lkup, data3, data3lkup, data4, data4lkup, data5, data5lkup) VALUES ('21', 'Allergy', 'Clinical', 'Allergy', '5', 'Drug Code', 'Product Dictionary', 'Reaction Type', 'RCT', 'Severity', 'SEV', 'Certainty', 'CER', 'Read Code For Reaction', 'Medical Dictionary');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('706', '69', '2', 'Intolerance');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name, description) VALUES ('69', 'RCT', 'Reaction Type');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data2_value, data3_value, data4_value, data5_value) VALUES ('63111', '21', '35', '42', '2', '3', '3', '1942');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('63111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '35');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('63111', '2010-01-01', '2014-06-12', '9', '1001', '0');
-- 64111: 1) dates 
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('64111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data3, data3lkup, data4, data4lkup) VALUES ('461', 'Repeat Medication Review', 'Clinical', 'Miscellaneous', '4', 'Due date', 'dd/mm/yyyy', 'Seen by', 'Review date', 'dd/mm/yyyy', 'Next review date', 'dd/mm/yyyy');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data1_date, data2_value, data3_date, data4_date) VALUES ('64111', '461', '42', '1.000', '2007-07-08', '0.000', '2007-01-08', '2007-07-09');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('64111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '42');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('64111', '2010-01-01', '2014-06-12', '9', '1001', '0');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('100977', '1JJ..00');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('10302', '3888.00');
-- 65111: scores with 0 mapping
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('65111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name) VALUES ('69', 'P_N');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('905', '69', '0', 'Data Not Entered');
INSERT INTO cprd_native_test.scoringmethod(code, scoring_method) VALUES ('1', 'PHQ-9');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data2_value, data3_value, data4_value) VALUES ('65111', '372', '45', '15', '100977', '1', '0');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('65111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '45');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('65111', '2010-01-01', '2014-06-12', '9', '1001', '0');
-- 66111: scores mapped
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('66111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data2_value, data3_value) VALUES ('66111', '372', '45', '500', '10302', '0');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('66111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '45');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('66111', '2010-01-01', '2014-06-12', '9', '1001', '0');
-- 67111: scores mapped, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('67111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data2, data2lkup, data3, data3lkup, data4, data4lkup) VALUES ('372', 'Scoring test result', 'Clinical', 'Diagnostic Tests', '4', 'Result of test', 'Condition', 'Medical Dictionary', 'Scoring Methodology', 'Scoring', 'Qualifier', 'P_N');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data2_value, data3_value) VALUES ('67111', '372', '45', '500', '7913', '1373');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('67111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '45');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('67111', '2010-01-01', '2014-06-12', '9', '1001', '0');
-- 68111: additional observation 114-2, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('68111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data1lkup, data2, data2lkup, data3, data4) VALUES ('114', 'Preg out', 'Clinical', 'Maternity', '2', 'Discharge Date', 'dd/mm/yyyy', 'Birth Status', 'LIV', 'Normal range to', 'Normal range basis');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('556', '47', '3', 'Miscarriage');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name, description) VALUES ('47', 'LIV', 'Birth Type');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data1_date, data2_value, data3_value) VALUES ('68111', '114', '35', '1.000', '2003-12-07', '3', '1373');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('68111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '35');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('68111', '2010-01-01', '2014-06-12', '9', '1001', '0');
-- 69111: additional observation 60-1 with SUM, id is person_id
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('69111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.entity(code, description, filetype, category, data_fields, data1, data2, data2lkup, data3, data3lkup, data4) VALUES ('60', 'Ante-natal booking', 'Clinical', 'Maternity', '3', 'Weeks gestation', 'Unit of measure', 'SUM', 'Type of booking', 'MBO', 'Normal range basis');
INSERT INTO cprd_native_test.additional(patid, enttype, adid, data1_value, data2_value, data3_value) VALUES ('69111', '60', '35', '8', '147', '1373');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('1002', '81', '147', 'Week');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('69111', '2010-01-01', '2014-06-12', '6', '2591944', '1', '0', '4', '2', '35');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('69111', '2010-01-01', '2014-06-12', '9', '1001', '0');
INSERT INTO cprd_native_test.practice(pracid, region, uts, lcd) VALUES ('111', '5', '2010-01-01', '2013-01-01');
INSERT INTO cprd_native_test.practice(pracid, region, uts, lcd) VALUES ('113', '5', '2014-01-01', '2012-12-01');
-- 70111: accept is 0 so should be deleted
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('70111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '0', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 71111: valid
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('71111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 72111: invalid: delete because crd 2013-01-01 > deathdate 2012-01-01
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, deathdate, accept, pracid, birth_date, start_date, end_date) VALUES ('72111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2013-01-01', '0', '0', '0', '0', '2012-01-01', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 73111: invalid: delete because crd 2013-01-01 > todate 2011-05-03
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, tod, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('73111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2013-01-01', '0', '0', '0', '2011-05-03', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 74113: invalid: delete because uts 2014-01-01 > lcd 2012-12-01
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('74113', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '113', '1972-01-01', '2015-01-14', '2018-12-11');
-- 75111: valid but mob =0 then MONTH_OF_BIRTH=NULL
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('75111', '0', '1', '199', '0', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 76111: invalid year of birth 74
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('76111', '0', '1', '74', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 77111: valid gender female
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('77111', '0', '2', '195', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 78111: invalid not entered gender
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('78111', '0', '0', '195', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 79111: invalid Indeterminate gender
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('79111', '0', '3', '195', '6', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
-- 80111: invalid unknown gender
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('80111', '0', '4', '195', '6', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('48653', '7J46z00');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('45832', '7414200');
INSERT INTO cprd_native_test.medical(medcode, read_code) VALUES ('69651', '744C.00');
-- 81111: Read clinical procedure with visit
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('81111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('81111', '2012-01-01', '2014-06-12', '6', '2591944', '48653', '1001', '4', '2', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, staffid, duration) VALUES ('81111', '2012-01-01', '2014-06-12', '9', '1001', '0');
-- 82111: clinical procedure without visit
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('82111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('82111', '2012-03-01', '2014-06-12', '6', '2591944', '45832', '1001', '4', '2', '0');
-- 83111: clinical procedure outside observation period
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('83111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.clinical(patid, eventdate, sysdate, constype, consid, medcode, staffid, episode, enttype, adid) VALUES ('83111', '2009-03-01', '2014-06-12', '6', '2591944', '69651', '1001', '4', '2', '0');
-- 84111: immunisation procedure
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('84111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.immunisation(patid, eventdate, sysdate, constype, medcode, staffid, immstype, stage, status, compound, source, reason, method, batch) VALUES ('84111', '2011-03-01', '2014-07-09', '4', '69651', '1001', '1', '2', '1', '0', '1', '3', '1', '0');
-- 85111: referral procedure
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('85111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.referral(patid, eventdate, sysdate, constype, medcode, staffid, source, nhsspec, fhsaspec, inpatient, attendance, urgency) VALUES ('85111', '2011-03-01', '2002-08-02', '4', '69651', '1001', '1', '0', '0', '3', '0', '0');
-- 86111: test procedure
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('86111', '0', '1', '199', '1', '6', '6894', '2', '0', '0', '1948-07-05', '2010-01-01', '0', '0', '0', '0', '1', '111', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.test(patid, eventdate, consid, staffid, sysdate, constype, medcode, enttype, data1, data3, data4, data7) VALUES ('86111', '2011-03-01', '6489', '1001', '2014-06-12', '2', '69651', '215', '9', '96.000', '0.000', '0');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('942', '76', '2', 'Partner');
INSERT INTO cprd_native_test.lookuptype(lookup_type_id, name, description) VALUES ('76', 'ROL', 'Role of Staff');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('943', '76', '68', 'Radiographer');
INSERT INTO cprd_native_test.lookup(lookup_id, lookup_type_id, code, text) VALUES ('944', '76', '0', 'Data Not Entered');
-- 87: valid GP: role=2 (Partner); provider_concept_id=38004446 id is provider_id
INSERT INTO cprd_native_test.staff(staffid, gender, role) VALUES ('1001', '0', '2');
-- 88: valid GP: role=68 (Radiographer ); provider_concept_id=38004675 id is provider_id
INSERT INTO cprd_native_test.staff(staffid, gender, role) VALUES ('88', '0', '68');
-- 89: valid GP: role=0 (Data Not Entered ) provider concept_id=38004514 id is provider_id
INSERT INTO cprd_native_test.staff(staffid, gender, role) VALUES ('89', '0', '0');
INSERT INTO cprd_native_test.practice(pracid, region, uts, lcd) VALUES ('555', '11', '2013-01-01', '2013-12-31');
-- 90555: Multiple consides on the same date but no event record, no visit created.
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, tod, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('90555', '0', '1', '172', '0', '6', '6894', '2', '0', '0', '1948-07-05', '2013-01-01', '0', '0', '0', '2013-12-31', '0', '1', '555', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, consid, staffid, duration) VALUES ('90555', '2013-02-01', '2014-06-12', '9', '1', '500', '0');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, consid, staffid, duration) VALUES ('90555', '2013-02-01', '2014-06-12', '9', '2', '600', '0');
-- 91555: eventdate in CLINICAL is NULL	No VISIT_OCCURRENCE record created
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, tod, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('91555', '0', '1', '172', '0', '6', '6894', '2', '0', '0', '1948-07-05', '2013-01-01', '0', '0', '0', '2013-12-31', '0', '1', '555', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.consultation(patid, sysdate, constype, consid, duration) VALUES ('91555', '2014-06-12', '9', '1', '0');
-- 92555: IMMUNISATION record occurs outside of a valid OBSERVATION_PERIOD, VISIT_OCCURRENCE record still created
INSERT INTO cprd_native_test.patient(patid, vmid, gender, yob, mob, marital, famnum, chsreg, prescr, capsup, frd, crd, regstat, reggap, internal, tod, toreason, accept, pracid, birth_date, start_date, end_date) VALUES ('92555', '0', '1', '172', '0', '6', '6894', '2', '0', '0', '1948-07-05', '2013-01-01', '0', '0', '0', '2013-12-31', '0', '1', '555', '1972-01-01', '2015-01-14', '2018-12-11');
INSERT INTO cprd_native_test.consultation(patid, eventdate, sysdate, constype, consid, duration) VALUES ('92555', '2012-01-01', '2014-06-12', '9', '1', '0');
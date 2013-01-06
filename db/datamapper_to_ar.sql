insert into authentication_users (id, system, name, email_address, password_digest, phone_number, created_at, updated_at) select id, system, name, email_address, password_digest, phone_number, created_at, updated_at from ltbi.authentication_users;
insert into authentication_roles (id, system, name, `desc`, created_at, updated_at) select  id, system, name, `desc`, created_at, updated_at from ltbi.authentication_roles;
insert into authentication_user_roles (id, user_id, role_id, created_at, updated_at) select id, user_id, role_id, NOW(), NOW() from ltbi.authentication_user_roles;

insert into sms_message_templates select * from ltbi.sms_message_templates;
insert into sms_messages (id, subscriber_id, parent_id, status, phone_number, body, sid, created_at, updated_at, checkup_id) select id, subscriber_id, parent_id, case status when 1 then 'unknown' when 2 then 'received' when 3 then 'sending' when 4 then 'sent' when 5 then 'failed' when 6 then 'read' end, phone_number, body, sid, created_at, updated_at, patient_record_id from ltbi.sms_messages;
insert into sms_subscribers (id, active, phone_number, created_at, updated_at, patient_id) select s.id, s.active, s.phone_number, s.created_at, s.updated_at, p.id from ltbi.sms_subscribers s inner join ltbi.weltel_patients p on s.id = p.subscriber_id;

insert into weltel_patients (id, clinic_id, active, user_name, study_number, contact_phone_number, created_at, updated_at) select id, clinic_id, active, user_name, study_number, contact_phone_number, created_at, updated_at from ltbi.weltel_patients;
insert into weltel_clinics select * from ltbi.weltel_clinics;
delete from weltel_clinics where id = 1;
insert into weltel_responses (id, name, value, created_at, updated_at) select id, name, case value when 1 then 'positive' when 2 then 'negative' end, created_at, updated_at from ltbi.weltel_responses;
insert into weltel_checkups (id, patient_id, current, created_on, status, contact_method, created_at, updated_at) select id, patient_id, active, created_on, case status when 1 then 'open' when 2 then 'closed' end, '', created_at, updated_at from ltbi.weltel_patient_records;
insert into weltel_results (id, checkup_id, user_id, initial, current, value, created_at) select id, patient_record_id, user_id, false, active, case value when 2 then 'unknown' when 3 then 'positive' when 4 then 'negative' when 5 then 'late' end, created_at from ltbi.weltel_patient_record_states where value != 1;

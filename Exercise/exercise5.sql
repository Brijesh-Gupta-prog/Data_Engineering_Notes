use snowflake_learning_db;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    head_doctor_id INT
);
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
years_of_experience INT,
    phone VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);  

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
  phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(200),
    registration_date DATE
);
  


CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_time TIME,
   status VARCHAR(20),
    appointment_type VARCHAR(50),
    notes VARCHAR(500),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
); 



CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY,
    appointment_id INT,
    treatment_name VARCHAR(200),
    treatment_date DATE,
    cost DECIMAL(10, 2),
  status VARCHAR(20),
    description VARCHAR(500),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);  



CREATE TABLE medications (
    medication_id INT PRIMARY KEY,
    treatment_id INT,
    medication_name VARCHAR(200),
    dosage VARCHAR(100),
    frequency VARCHAR(50),
    duration_days INT,
    cost DECIMAL(10, 2),
    FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);


CREATE TABLE lab_results (
    lab_result_id INT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    test_name VARCHAR(200),
    test_date DATE,
    result_value DECIMAL(10, 2),
    unit VARCHAR(20),
    reference_range VARCHAR(100),
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

INSERT INTO departments VALUES (1, 'Cardiology', 'Building A, Floor 2', NULL);
INSERT INTO departments VALUES (2, 'Neurology', 'Building A, Floor 3', NULL);
INSERT INTO departments VALUES (3, 'Orthopedics', 'Building B, Floor 1', NULL);
INSERT INTO departments VALUES (4, 'Pediatrics', 'Building B, Floor 2', NULL);
INSERT INTO departments VALUES (5, 'Emergency', 'Building C, Ground Floor', NULL);
INSERT INTO departments VALUES (6, 'Oncology', 'Building A, Floor 4', NULL);
INSERT INTO departments VALUES (7, 'Dermatology', 'Building B, Floor 3', NULL);
INSERT INTO departments VALUES (8, 'Psychiatry', 'Building C, Floor 2', NULL);
INSERT INTO doctors VALUES (1, 'John', 'Smith', 'Cardiologist', 1, 15, '555-0101', 'john.smith@hospital.com', '2010-03-15');
INSERT INTO doctors VALUES (2, 'Sarah', 'Johnson', 'Neurologist', 2, 12, '555-0102', 'sarah.j@hospital.com', '2012-06-20');
INSERT INTO doctors VALUES (3, 'Michael', 'Brown', 'Orthopedic Surgeon', 3, 20, '555-0103', 'michael.b@hospital.com', '2005-01-10');
INSERT INTO doctors VALUES (4, 'Emily', 'Davis', 'Pediatrician', 4, 8, '555-0104', 'emily.d@hospital.com', '2016-08-05');
INSERT INTO doctors VALUES (5, 'David', 'Wilson', 'Emergency Medicine', 5, 10, '555-0105', 'david.w@hospital.com', '2014-02-28');
INSERT INTO doctors VALUES (6, 'Lisa', 'Anderson', 'Oncologist', 6, 18, '555-0106', 'lisa.a@hospital.com', '2007-11-12');
INSERT INTO doctors VALUES (7, 'Robert', 'Taylor', 'Dermatologist', 7, 14, '555-0107', 'robert.t@hospital.com', '2010-09-22');
INSERT INTO doctors VALUES (8, 'Jennifer', 'Martinez', 'Psychiatrist', 8, 9, '555-0108', 'jennifer.m@hospital.com', '2015-04-18');
INSERT INTO doctors VALUES (9, 'William', 'Garcia', 'Cardiologist', 1, 11, '555-0109', 'william.g@hospital.com', '2013-07-30');
INSERT INTO doctors VALUES (10, 'Amanda', 'Lee', 'Neurologist', 2, 7, '555-0110', 'amanda.l@hospital.com', '2017-10-15');

UPDATE departments SET head_doctor_id = 1 WHERE department_id = 1;
UPDATE departments SET head_doctor_id = 2 WHERE department_id = 2;
UPDATE departments SET head_doctor_id = 3 WHERE department_id = 3;
UPDATE departments SET head_doctor_id = 4 WHERE department_id = 4;
UPDATE departments SET head_doctor_id = 5 WHERE department_id = 5;
UPDATE departments SET head_doctor_id = 6 WHERE department_id = 6;
UPDATE departments SET head_doctor_id = 7 WHERE department_id = 7;
UPDATE departments SET head_doctor_id = 8 WHERE department_id = 8;

INSERT INTO patients VALUES (1, 'James', 'Miller', '1985-05-12', 'Male', '555-1001', 'james.m@email.com', '123 Main St', '2020-01-15');
INSERT INTO patients VALUES (2, 'Mary', 'Thompson', '1990-08-22', 'Female', '555-1002', 'mary.t@email.com', '456 Oak Ave', '2020-02-10');
INSERT INTO patients VALUES (3, 'Robert', 'White', '1978-11-03', 'Male', '555-1003', 'robert.w@email.com', '789 Pine Rd', '2019-12-05');
INSERT INTO patients VALUES (4, 'Patricia', 'Harris', '1992-03-18', 'Female', '555-1004', 'patricia.h@email.com', '321 Elm St', '2021-03-20');
INSERT INTO patients VALUES (5, 'John', 'Martin', '1988-07-25', 'Male', '555-1005', 'john.m@email.com', '654 Maple Dr', '2020-05-12');
INSERT INTO patients VALUES (6, 'Jennifer', 'Garcia', '1995-01-30', 'Female', '555-1006', 'jennifer.g@email.com', '987 Cedar Ln', '2021-01-08');
INSERT INTO patients VALUES (7, 'Michael', 'Rodriguez', '1982-09-14', 'Male', '555-1007', 'michael.r@email.com', '147 Birch Way', '2019-11-22');
INSERT INTO patients VALUES (8, 'Linda', 'Lewis', '1991-04-07', 'Female', '555-1008', 'linda.l@email.com', '258 Spruce Ct', '2020-07-30');
INSERT INTO patients VALUES (9, 'William', 'Walker', '1975-12-19', 'Male', '555-1009', 'william.w@email.com', '369 Willow St', '2019-09-15');
INSERT INTO patients VALUES (10, 'Elizabeth', 'Hall', '1987-06-28', 'Female', '555-1010', 'elizabeth.h@email.com', '741 Ash Ave', '2020-04-25');
INSERT INTO patients VALUES (11, 'Richard', 'Allen', '1993-02-11', 'Male', '555-1011', 'richard.a@email.com', '852 Poplar Rd', '2021-02-14');
INSERT INTO patients VALUES (12, 'Susan', 'Young', '1989-10-05', 'Female', '555-1012', 'susan.y@email.com', '963 Hickory Dr', '2020-08-18');
INSERT INTO patients VALUES (13, 'Joseph', 'King', '1984-08-16', 'Male', '555-1013', 'joseph.k@email.com', '159 Cherry Ln', '2020-06-10');
INSERT INTO patients VALUES (14, 'Jessica', 'Wright', '1996-05-23', 'Female', '555-1014', 'jessica.w@email.com', '357 Walnut St', '2021-04-05');
INSERT INTO patients VALUES (15, 'Thomas', 'Lopez', '1980-03-09', 'Male', '555-1015', 'thomas.l@email.com', '468 Chestnut Ave', '2019-10-28');
INSERT INTO patients VALUES (16, 'Sarah', 'Hill', '1994-07-31', 'Female', '555-1016', 'sarah.h@email.com', '579 Sycamore Rd', '2020-11-12');
INSERT INTO patients VALUES (17, 'Charles', 'Scott', '1977-12-14', 'Male', '555-1017', 'charles.s@email.com', '680 Magnolia Dr', '2019-08-20');
INSERT INTO patients VALUES (18, 'Nancy', 'Green', '1992-09-26', 'Female', '555-1018', 'nancy.g@email.com', '791 Dogwood Ln', '2020-09-22');
INSERT INTO patients VALUES (19, 'Christopher', 'Adams', '1986-01-17', 'Male', '555-1019', 'christopher.a@email.com', '802 Redwood St', '2020-12-30');
INSERT INTO patients VALUES (20, 'Karen', 'Baker', '1991-11-08', 'Female', '555-1020', 'karen.b@email.com', '913 Fir Ct', '2021-05-15');



INSERT INTO appointments VALUES (1, 1, 1, '2024-01-15', '09:00:00', 'Completed', 'Consultation', 'Regular checkup');
INSERT INTO appointments VALUES (2, 2, 2, '2024-01-16', '10:30:00', 'Completed', 'Follow-up', 'Follow-up on previous treatment');
INSERT INTO appointments VALUES (3, 3, 3, '2024-01-17', '14:00:00', 'Completed', 'Consultation', 'Knee pain evaluation');
INSERT INTO appointments VALUES (4, 4, 4, '2024-01-18', '11:00:00', 'Completed', 'Checkup', 'Annual pediatric checkup');
INSERT INTO appointments VALUES (5, 5, 1, '2024-01-19', '15:30:00', 'Completed', 'Consultation', 'Heart condition review');
INSERT INTO appointments VALUES (6, 6, 7, '2024-01-20', '09:30:00', 'Completed', 'Consultation', 'Skin rash examination');
INSERT INTO appointments VALUES (7, 7, 2, '2024-01-21', '13:00:00', 'Completed', 'Follow-up', 'Neurological follow-up');
INSERT INTO appointments VALUES (8, 8, 8, '2024-01-22', '10:00:00', 'Completed', 'Consultation', 'Mental health assessment');
INSERT INTO appointments VALUES (9, 9, 3, '2024-01-23', '16:00:00', 'Completed', 'Consultation', 'Back pain consultation');
INSERT INTO appointments VALUES (10, 10, 5, '2024-01-24', '08:00:00', 'Completed', 'Emergency', 'Emergency visit');
INSERT INTO appointments VALUES (11, 11, 6, '2024-01-25', '14:30:00', 'Completed', 'Consultation', 'Oncology consultation');
INSERT INTO appointments VALUES (12, 12, 1, '2024-01-26', '11:30:00', 'Completed', 'Follow-up', 'Cardiac follow-up');
INSERT INTO appointments VALUES (13, 13, 4, '2024-01-27', '09:00:00', 'Completed', 'Checkup', 'Child wellness check');
INSERT INTO appointments VALUES (14, 14, 7, '2024-01-28', '15:00:00', 'Completed', 'Consultation', 'Acne treatment');
INSERT INTO appointments VALUES (15, 15, 2, '2024-01-29', '10:30:00', 'Completed', 'Consultation', 'Headache evaluation');
INSERT INTO appointments VALUES (16, 16, 3, '2024-01-30', '13:30:00', 'Completed', 'Follow-up', 'Post-surgery follow-up');
INSERT INTO appointments VALUES (17, 17, 5, '2024-02-01', '08:30:00', 'Completed', 'Emergency', 'Chest pain emergency');
INSERT INTO appointments VALUES (18, 18, 8, '2024-02-02', '12:00:00', 'Completed', 'Follow-up', 'Therapy session');
INSERT INTO appointments VALUES (19, 19, 1, '2024-02-03', '16:30:00', 'Completed', 'Consultation', 'Hypertension check');
INSERT INTO appointments VALUES (20, 20, 6, '2024-02-04', '09:00:00', 'Completed', 'Follow-up', 'Treatment progress review');
INSERT INTO appointments VALUES (21, 1, 9, '2024-02-05', '11:00:00', 'Scheduled', 'Follow-up', 'Cardiac follow-up');
INSERT INTO appointments VALUES (22, 2, 10, '2024-02-06', '14:00:00', 'Scheduled', 'Consultation', 'New consultation');
INSERT INTO appointments VALUES (23, 3, 3, '2024-02-07', '10:00:00', 'Cancelled', 'Follow-up', 'Patient cancelled');
INSERT INTO appointments VALUES (24, 4, 4, '2024-02-08', '15:00:00', 'Scheduled', 'Checkup', 'Regular checkup');
INSERT INTO appointments VALUES (25, 5, 1, '2024-02-09', '09:30:00', 'No-Show', 'Follow-up', 'Patient did not show');
INSERT INTO appointments VALUES (26, 6, 7, '2024-02-10', '13:00:00', 'Scheduled', 'Follow-up', 'Treatment follow-up');
INSERT INTO appointments VALUES (27, 7, 2, '2024-02-11', '11:30:00', 'Scheduled', 'Consultation', 'New symptoms');
INSERT INTO appointments VALUES (28, 8, 8, '2024-02-12', '16:00:00', 'Scheduled', 'Follow-up', 'Therapy continuation');
INSERT INTO appointments VALUES (29, 9, 3, '2024-02-13', '08:00:00', 'Scheduled', 'Consultation', 'Pain management');
INSERT INTO appointments VALUES (30, 10, 5, '2024-02-14', '12:30:00', 'Scheduled', 'Emergency', 'Urgent care');





INSERT INTO treatments VALUES (1, 1, 'ECG Test', '2024-01-15', 150.00, 'Completed', 'Electrocardiogram performed');
INSERT INTO treatments VALUES (2, 2, 'MRI Scan', '2024-01-16', 800.00, 'Completed', 'Brain MRI completed');
INSERT INTO treatments VALUES (3, 3, 'X-Ray', '2024-01-17', 120.00, 'Completed', 'Knee X-ray taken');
INSERT INTO treatments VALUES (4, 4, 'Vaccination', '2024-01-18', 50.00, 'Completed', 'Annual vaccination given');
INSERT INTO treatments VALUES (5, 5, 'Echocardiogram', '2024-01-19', 300.00, 'Completed', 'Heart ultrasound completed');
INSERT INTO treatments VALUES (6, 6, 'Skin Biopsy', '2024-01-20', 250.00, 'Completed', 'Biopsy sample taken');
INSERT INTO treatments VALUES (7, 7, 'CT Scan', '2024-01-21', 600.00, 'Completed', 'Head CT scan completed');
INSERT INTO treatments VALUES (8, 8, 'Therapy Session', '2024-01-22', 200.00, 'Completed', 'One hour therapy session');
INSERT INTO treatments VALUES (9, 9, 'Physical Therapy', '2024-01-23', 180.00, 'In Progress', 'Back rehabilitation');
INSERT INTO treatments VALUES (10, 10, 'Emergency Treatment', '2024-01-24', 500.00, 'Completed', 'Emergency care provided');
INSERT INTO treatments VALUES (11, 11, 'Chemotherapy', '2024-01-25', 2000.00, 'In Progress', 'First cycle of chemotherapy');
INSERT INTO treatments VALUES (12, 12, 'Stress Test', '2024-01-26', 200.00, 'Completed', 'Cardiac stress test');
INSERT INTO treatments VALUES (13, 13, 'Blood Test', '2024-01-27', 80.00, 'Completed', 'Complete blood count');
INSERT INTO treatments VALUES (14, 14, 'Laser Treatment', '2024-01-28', 400.00, 'Completed', 'Acne laser treatment');
INSERT INTO treatments VALUES (15, 15, 'EEG Test', '2024-01-29', 350.00, 'Completed', 'Electroencephalogram');
INSERT INTO treatments VALUES (16, 16, 'Surgery Follow-up', '2024-01-30', 150.00, 'Completed', 'Post-operative care');
INSERT INTO treatments VALUES (17, 17, 'Emergency Surgery', '2024-02-01', 5000.00, 'Completed', 'Emergency procedure');
INSERT INTO treatments VALUES (18, 18, 'Group Therapy', '2024-02-02', 100.00, 'Completed', 'Group session');
INSERT INTO treatments VALUES (19, 19, 'Blood Pressure Monitor', '2024-02-03', 75.00, 'Completed', '24-hour monitoring');
INSERT INTO treatments VALUES (20, 20, 'Radiation Therapy', '2024-02-04', 1500.00, 'In Progress', 'Radiation treatment');
INSERT INTO treatments VALUES (21, 21, 'Cardiac Catheterization', '2024-02-05', 3000.00, 'Scheduled', 'Scheduled procedure');
INSERT INTO treatments VALUES (22, 22, 'Neurological Exam', '2024-02-06', 250.00, 'Scheduled', 'Comprehensive exam');
INSERT INTO treatments VALUES (23, 24, 'Vaccination', '2024-02-08', 50.00, 'Scheduled', 'Scheduled vaccination');
INSERT INTO treatments VALUES (24, 26, 'Follow-up Treatment', '2024-02-10', 200.00, 'Scheduled', 'Treatment continuation');
INSERT INTO treatments VALUES (25, 27, 'Diagnostic Test', '2024-02-11', 300.00, 'Scheduled', 'Diagnostic procedure');


INSERT INTO treatments VALUES (1, 1, 'ECG Test', '2024-01-15', 150.00, 'Completed', 'Electrocardiogram performed');
INSERT INTO treatments VALUES (2, 2, 'MRI Scan', '2024-01-16', 800.00, 'Completed', 'Brain MRI completed');
INSERT INTO treatments VALUES (3, 3, 'X-Ray', '2024-01-17', 120.00, 'Completed', 'Knee X-ray taken');
INSERT INTO treatments VALUES (4, 4, 'Vaccination', '2024-01-18', 50.00, 'Completed', 'Annual vaccination given');
INSERT INTO treatments VALUES (5, 5, 'Echocardiogram', '2024-01-19', 300.00, 'Completed', 'Heart ultrasound completed');
INSERT INTO treatments VALUES (6, 6, 'Skin Biopsy', '2024-01-20', 250.00, 'Completed', 'Biopsy sample taken');
INSERT INTO treatments VALUES (7, 7, 'CT Scan', '2024-01-21', 600.00, 'Completed', 'Head CT scan completed');
INSERT INTO treatments VALUES (8, 8, 'Therapy Session', '2024-01-22', 200.00, 'Completed', 'One hour therapy session');
INSERT INTO treatments VALUES (9, 9, 'Physical Therapy', '2024-01-23', 180.00, 'In Progress', 'Back rehabilitation');
INSERT INTO treatments VALUES (10, 10, 'Emergency Treatment', '2024-01-24', 500.00, 'Completed', 'Emergency care provided');
INSERT INTO treatments VALUES (11, 11, 'Chemotherapy', '2024-01-25', 2000.00, 'In Progress', 'First cycle of chemotherapy');
INSERT INTO treatments VALUES (12, 12, 'Stress Test', '2024-01-26', 200.00, 'Completed', 'Cardiac stress test');
INSERT INTO treatments VALUES (13, 13, 'Blood Test', '2024-01-27', 80.00, 'Completed', 'Complete blood count');
INSERT INTO treatments VALUES (14, 14, 'Laser Treatment', '2024-01-28', 400.00, 'Completed', 'Acne laser treatment');
INSERT INTO treatments VALUES (15, 15, 'EEG Test', '2024-01-29', 350.00, 'Completed', 'Electroencephalogram');
INSERT INTO treatments VALUES (16, 16, 'Surgery Follow-up', '2024-01-30', 150.00, 'Completed', 'Post-operative care');
INSERT INTO treatments VALUES (17, 17, 'Emergency Surgery', '2024-02-01', 5000.00, 'Completed', 'Emergency procedure');
INSERT INTO treatments VALUES (18, 18, 'Group Therapy', '2024-02-02', 100.00, 'Completed', 'Group session');
INSERT INTO treatments VALUES (19, 19, 'Blood Pressure Monitor', '2024-02-03', 75.00, 'Completed', '24-hour monitoring');
INSERT INTO treatments VALUES (20, 20, 'Radiation Therapy', '2024-02-04', 1500.00, 'In Progress', 'Radiation treatment');
INSERT INTO treatments VALUES (21, 21, 'Cardiac Catheterization', '2024-02-05', 3000.00, 'Scheduled', 'Scheduled procedure');
INSERT INTO treatments VALUES (22, 22, 'Neurological Exam', '2024-02-06', 250.00, 'Scheduled', 'Comprehensive exam');
INSERT INTO treatments VALUES (23, 24, 'Vaccination', '2024-02-08', 50.00, 'Scheduled', 'Scheduled vaccination');
INSERT INTO treatments VALUES (24, 26, 'Follow-up Treatment', '2024-02-10', 200.00, 'Scheduled', 'Treatment continuation');
INSERT INTO treatments VALUES (25, 27, 'Diagnostic Test', '2024-02-11', 300.00, 'Scheduled', 'Diagnostic procedure');



INSERT INTO medications VALUES (1, 1, 'Aspirin', '81mg', 'Once daily', 30, 15.00);
INSERT INTO medications VALUES (2, 2, 'Gabapentin', '300mg', 'Three times daily', 60, 45.00);
INSERT INTO medications VALUES (3, 3, 'Ibuprofen', '400mg', 'Twice daily', 14, 12.00);
INSERT INTO medications VALUES (4, 4, 'Vitamin D', '1000 IU', 'Once daily', 90, 20.00);
INSERT INTO medications VALUES (5, 5, 'Lisinopril', '10mg', 'Once daily', 30, 25.00);
INSERT INTO medications VALUES (6, 6, 'Hydrocortisone Cream', '1%', 'Apply twice daily', 14, 18.00);
INSERT INTO medications VALUES (7, 7, 'Topiramate', '50mg', 'Twice daily', 30, 55.00);
INSERT INTO medications VALUES (8, 8, 'Sertraline', '50mg', 'Once daily', 90, 30.00);
INSERT INTO medications VALUES (9, 9, 'Naproxen', '500mg', 'Twice daily', 21, 22.00);
INSERT INTO medications VALUES (10, 10, 'Morphine', '5mg', 'As needed', 7, 35.00);
INSERT INTO medications VALUES (11, 11, 'Paclitaxel', '175mg/m2', 'Every 3 weeks', 180, 500.00);
INSERT INTO medications VALUES (12, 12, 'Metoprolol', '25mg', 'Twice daily', 30, 28.00);
INSERT INTO medications VALUES (13, 13, 'Amoxicillin', '250mg', 'Three times daily', 10, 15.00);
INSERT INTO medications VALUES (14, 14, 'Tretinoin', '0.05%', 'Apply once daily', 60, 40.00);
INSERT INTO medications VALUES (15, 15, 'Sumatriptan', '50mg', 'As needed', 30, 60.00);
INSERT INTO medications VALUES (16, 16, 'Acetaminophen', '500mg', 'Every 6 hours', 7, 8.00);
INSERT INTO medications VALUES (17, 17, 'Antibiotics', '500mg', 'Four times daily', 10, 25.00);
INSERT INTO medications VALUES (18, 18, 'Escitalopram', '10mg', 'Once daily', 90, 32.00);
INSERT INTO medications VALUES (19, 19, 'Amlodipine', '5mg', 'Once daily', 30, 20.00);
INSERT INTO medications VALUES (20, 20, 'Cisplatin', '75mg/m2', 'Every 3 weeks', 180, 600.00);
INSERT INTO medications VALUES (21, 21, 'Clopidogrel', '75mg', 'Once daily', 90, 50.00);
INSERT INTO medications VALUES (22, 22, 'Levetiracetam', '500mg', 'Twice daily', 60, 48.00);
INSERT INTO medications VALUES (23, 24, 'Vitamin B12', '1000mcg', 'Once daily', 30, 15.00);
INSERT INTO medications VALUES (24, 24, 'Iron Supplement', '65mg', 'Once daily', 60, 12.00);
INSERT INTO medications VALUES (25, 25, 'Prednisone', '20mg', 'Once daily', 14, 18.00);
INSERT INTO lab_results VALUES (1, 1, 1, 'Cholesterol', '2024-01-15', 180.00, 'mg/dL', '100-200', 'Normal');
INSERT INTO lab_results VALUES (2, 2, 2, 'MRI Brain', '2024-01-16', 0.00, 'N/A', 'Normal', 'Normal');
INSERT INTO lab_results VALUES (3, 3, 3, 'X-Ray Knee', '2024-01-17', 0.00, 'N/A', 'Normal', 'Normal');
INSERT INTO lab_results VALUES (4, 4, 4, 'CBC', '2024-01-18', 7.5, 'million/uL', '4.5-11.0', 'Normal');
INSERT INTO lab_results VALUES (5, 5, 5, 'Echocardiogram', '2024-01-19', 65.00, '%', '55-70', 'Normal');
INSERT INTO lab_results VALUES (6, 6, 6, 'Biopsy Result', '2024-01-20', 0.00, 'N/A', 'Benign', 'Normal');
INSERT INTO lab_results VALUES (7, 7, 7, 'CT Head', '2024-01-21', 0.00, 'N/A', 'Normal', 'Normal');
INSERT INTO lab_results VALUES (8, 8, 8, 'Psychological Assessment', '2024-01-22', 65.00, 'Score', '50-70', 'Normal');
INSERT INTO lab_results VALUES (9, 9, 9, 'Physical Therapy Assessment', '2024-01-23', 75.00, 'Score', '60-80', 'Normal');
INSERT INTO lab_results VALUES (10, 10, 10, 'Emergency Blood Work', '2024-01-24', 140.00, 'mg/dL', '70-100', 'Abnormal');
INSERT INTO lab_results VALUES (11, 11, 11, 'Tumor Marker', '2024-01-25', 45.00, 'ng/mL', '0-35', 'Abnormal');
INSERT INTO lab_results VALUES (12, 12, 12, 'Stress Test Result', '2024-01-26', 85.00, '%', '>80', 'Normal');
INSERT INTO lab_results VALUES (13, 13, 13, 'Complete Blood Count', '2024-01-27', 8.2, 'million/uL', '4.5-11.0', 'Normal');
INSERT INTO lab_results VALUES (14, 14, 14, 'Skin Analysis', '2024-01-28', 0.00, 'N/A', 'Normal', 'Normal');
INSERT INTO lab_results VALUES (15, 15, 15, 'EEG Result', '2024-01-29', 0.00, 'N/A', 'Normal', 'Normal');
INSERT INTO lab_results VALUES (16, 16, 16, 'Post-Surgery Check', '2024-01-30', 0.00, 'N/A', 'Normal', 'Normal');
INSERT INTO lab_results VALUES (17, 17, 17, 'Emergency Lab', '2024-02-01', 95.00, 'mg/dL', '70-100', 'Normal');
INSERT INTO lab_results VALUES (18, 18, 18, 'Mental Health Score', '2024-02-02', 58.00, 'Score', '50-70', 'Normal');
INSERT INTO lab_results VALUES (19, 19, 19, 'Blood Pressure 24h', '2024-02-03', 135.00, 'mmHg', '90-120', 'Abnormal');
INSERT INTO lab_results VALUES (20, 20, 20, 'Cancer Marker', '2024-02-04', 38.00, 'ng/mL', '0-35', 'Abnormal');
INSERT INTO lab_results VALUES (21, 1, 21, 'Cardiac Enzymes', '2024-02-05', 25.00, 'U/L', '0-30', 'Normal');
INSERT INTO lab_results VALUES (22, 2, 22, 'Neurological Panel', '2024-02-06', 0.00, 'N/A', 'Pending', 'Normal');
INSERT INTO lab_results VALUES (23, 4, 24, 'Vitamin Levels', '2024-02-08', 35.00, 'ng/mL', '30-100', 'Normal');
INSERT INTO lab_results VALUES (24, 6, 26, 'Follow-up Test', '2024-02-10', 0.00, 'N/A', 'Pending', 'Normal');
INSERT INTO lab_results VALUES (25, 7, 27, 'Diagnostic Panel', '2024-02-11', 0.00, 'N/A', 'Pending', 'Normal');



--1.1

SELECT
    patient_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    date_of_birth,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_DATE()) AS age,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_DATE()) < 18 THEN 'Child'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_DATE()) BETWEEN 18 AND 64 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category
FROM patients;

--1.2

SELECT
    a.appointment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    a.appointment_date,
    a.appointment_type,
    CASE
        WHEN a.appointment_type = 'Emergency' THEN 'High'
        WHEN a.appointment_type = 'Consultation' THEN 'Medium'
        ELSE 'Low'
    END AS priority_level
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;


--1.3

SELECT
    treatment_id,
    treatment_name,
    cost,
    CASE
        WHEN cost < 200 THEN 'Low'
        WHEN cost BETWEEN 200 AND 999 THEN 'Medium'
        WHEN cost BETWEEN 1000 AND 2999 THEN 'High'
        ELSE 'Very High'
    END AS cost_category
FROM treatments
ORDER BY cost DESC;




--1.4

SELECT
    lr.lab_result_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    lr.test_name,
    lr.result_value,
    lr.status,
    CASE
        WHEN lr.status = 'Critical' THEN 'Critical'
        WHEN lr.status = 'Abnormal' THEN 'Warning'
        WHEN lr.status = 'Normal' THEN 'Normal'
        ELSE 'Pending'
    END AS severity,
    CASE
        WHEN lr.status = 'Critical' THEN 'Yes'
        ELSE 'No'
    END AS immediate_attention
FROM lab_results lr
JOIN patients p ON lr.patient_id = p.patient_id;

--1.5

SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    d.YEARS_OF_EXPERIENCE,
    CASE
        WHEN d.YEARS_OF_EXPERIENCE < 5 THEN 'Junior'
        WHEN d.YEARS_OF_EXPERIENCE BETWEEN 5 AND 9 THEN 'Mid-Level'
        WHEN d.YEARS_OF_EXPERIENCE BETWEEN 10 AND 14 THEN 'Senior'
        ELSE 'Expert'
    END AS experience_level,
    dept.department_name
FROM doctors d
JOIN departments dept ON d.department_id = dept.department_id;


--2.1

WITH yearly_reg AS (
    SELECT
        YEAR(registration_date) AS reg_year,
        COUNT(*) AS patient_count
    FROM patients
    GROUP BY YEAR(registration_date)
)
SELECT
    reg_year,
    patient_count,
    CASE
        WHEN LAG(patient_count) OVER (ORDER BY reg_year) IS NULL THEN 'New'
        WHEN patient_count > LAG(patient_count) OVER (ORDER BY reg_year) THEN 'Increasing'
        WHEN patient_count < LAG(patient_count) OVER (ORDER BY reg_year) THEN 'Decreasing'
        ELSE 'Stable'
    END AS registration_trend
FROM yearly_reg
ORDER BY reg_year;


--2.2

SELECT
    medication_id,
    medication_name,
    cost AS original_cost,
    CASE
        WHEN cost >= 100 THEN 0.10
        WHEN cost >= 50 THEN 0.05
        ELSE 0
    END AS discount_rate,
    cost - (cost *
        CASE
            WHEN cost >= 100 THEN 0.10
            WHEN cost >= 50 THEN 0.05
            ELSE 0
        END
    ) AS final_cost
FROM medications;



--2.3

SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
    SUM(CASE WHEN a.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_appointments,
    SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) AS no_show_appointments,
    ROUND(
        (SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) * 100.0) /
        COUNT(a.appointment_id), 2
    ) AS completion_rate,
    CASE
        WHEN (SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) * 100.0) /
             COUNT(a.appointment_id) >= 80 THEN 'Excellent'
        WHEN (SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) * 100.0) /
             COUNT(a.appointment_id) >= 60 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS performance_status
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name;


--3.1


SELECT
    dept.department_name,
    COUNT(DISTINCT d.doctor_id) AS number_of_doctors,
    ROUND(AVG(d.YEARS_OF_EXPERIENCE), 2) AS avg_experience_years,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments
FROM departments dept
LEFT JOIN doctors d ON dept.department_id = d.department_id
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY dept.department_name
ORDER BY number_of_doctors DESC;



--3.2

SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
    SUM(CASE WHEN a.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_appointments,
    COALESCE(SUM(t.cost), 0) AS total_treatment_cost,
    ROUND(AVG(t.cost), 2) AS avg_treatment_cost
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
LEFT JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(a.appointment_id) > 1;



--3.3

SELECT
    YEAR(appointment_date) AS year,
    MONTH(appointment_date) AS month,
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_appointments,
    SUM(CASE WHEN status = 'No-Show' THEN 1 ELSE 0 END) AS no_show_appointments,
    ROUND(
        (SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END) * 100.0) /
        COUNT(*), 2
    ) AS completion_rate
FROM appointments
GROUP BY YEAR(appointment_date), MONTH(appointment_date)
ORDER BY year, month;



--3.4


SELECT
    dept.department_name,
    COUNT(t.treatment_id) AS number_of_treatments,
    SUM(t.cost) AS total_cost,
    ROUND(AVG(t.cost), 2) AS avg_cost,
    MIN(t.cost) AS min_cost,
    MAX(t.cost) AS max_cost,
    MAX(t.treatment_name) AS most_expensive_treatment
FROM treatments t
JOIN appointments a ON t.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON d.department_id = dept.department_id
GROUP BY dept.department_name;



--3.5

SELECT
    m.medication_name,
    COUNT(p.medication_id) AS number_of_prescriptions,
    SUM(m.cost) AS total_cost,
    ROUND(AVG(m.cost), 2) AS avg_cost_per_prescription,
    SUM(p.duration_days) AS total_duration_days,
    ROUND(AVG(p.duration_days), 2) AS avg_duration_days
FROM prescriptions p
JOIN medications m ON p.medication_id = m.medication_id
GROUP BY m.medication_name
ORDER BY number_of_prescriptions DESC;



--4.1

SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    a.appointment_id,
    a.appointment_date,
    ROW_NUMBER() OVER (
        PARTITION BY p.patient_id
        ORDER BY a.appointment_date
    ) AS appointment_number,
    DATEDIFF(
        'day',
        LAG(a.appointment_date) OVER (
            PARTITION BY p.patient_id
            ORDER BY a.appointment_date
        ),
        a.appointment_date
    ) AS days_since_previous_appointment
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
ORDER BY p.patient_id, a.appointment_date;




--4.2


SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS completed_appointments,
    RANK() OVER (ORDER BY COUNT(a.appointment_id) DESC) AS rank_no,
    DENSE_RANK() OVER (ORDER BY COUNT(a.appointment_id) DESC) AS dense_rank_no,
    PERCENT_RANK() OVER (ORDER BY COUNT(a.appointment_id)) AS percent_rank
FROM doctors d
LEFT JOIN appointments a
    ON d.doctor_id = a.doctor_id AND a.status = 'Completed'
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization
ORDER BY rank_no;



--4.3


SELECT
    treatment_date,
    treatment_name,
    cost,
    SUM(cost) OVER (
        PARTITION BY treatment_date
    ) AS daily_total,
    SUM(cost) OVER (
        ORDER BY treatment_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    ROUND(
        AVG(cost) OVER (
            ORDER BY treatment_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS running_average
FROM treatments
ORDER BY treatment_date;



--4.4


SELECT *
FROM (
    SELECT
        dept.department_name,
        t.treatment_name,
        t.cost,
        RANK() OVER (
            PARTITION BY dept.department_name
            ORDER BY t.cost DESC
        ) AS dept_rank
    FROM treatments t
    JOIN appointments a ON t.appointment_id = a.appointment_id
    JOIN doctors d ON a.doctor_id = d.doctor_id
    JOIN departments dept ON d.department_id = dept.department_id
) ranked
WHERE dept_rank <= 3
ORDER BY department_name, dept_rank;



--4.5

SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    t.treatment_date,
    t.treatment_name,
    t.cost,
    LAG(t.cost) OVER (
        PARTITION BY p.patient_id
        ORDER BY t.treatment_date
    ) AS previous_cost,
    LEAD(t.cost) OVER (
        PARTITION BY p.patient_id
        ORDER BY t.treatment_date
    ) AS next_cost,
    t.cost - LAG(t.cost) OVER (
        PARTITION BY p.patient_id
        ORDER BY t.treatment_date
    ) AS cost_change,
    CASE
        WHEN LAG(t.cost) OVER (
            PARTITION BY p.patient_id
            ORDER BY t.treatment_date
        ) IS NULL THEN 'First Treatment'
        WHEN t.cost > LAG(t.cost) OVER (
            PARTITION BY p.patient_id
            ORDER BY t.treatment_date
        ) THEN 'Increasing'
        WHEN t.cost < LAG(t.cost) OVER (
            PARTITION BY p.patient_id
            ORDER BY t.treatment_date
        ) THEN 'Decreasing'
        ELSE 'Stable'
    END AS cost_trend
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN treatments t ON a.appointment_id = t.appointment_id
ORDER BY p.patient_id, t.treatment_date;



--4.6

SELECT
    department_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    ROUND(
        total_revenue * 100.0 / SUM(total_revenue) OVER (), 2
    ) AS percent_of_total_revenue,
    SUM(total_revenue) OVER (
        ORDER BY total_revenue DESC
    ) AS cumulative_revenue,
    NTILE(4) OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_quartile
FROM (
    SELECT
        dept.department_name,
        SUM(t.cost) AS total_revenue
    FROM departments dept
    JOIN doctors d ON dept.department_id = d.department_id
    JOIN appointments a ON d.doctor_id = a.doctor_id
    JOIN treatments t ON a.appointment_id = t.appointment_id
    GROUP BY dept.department_name
) dept_revenue;


--4.7

SELECT
    appointment_date,
    COUNT(*) AS daily_appointments,
    ROUND(
        AVG(COUNT(*)) OVER (
            ORDER BY appointment_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3_days,
    ROUND(
        AVG(COUNT(*)) OVER (
            ORDER BY appointment_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_7_days,
    ROUND(
        AVG(COUNT(*)) OVER (
            ORDER BY appointment_date
            ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_30_days
FROM appointments
GROUP BY appointment_date
ORDER BY appointment_date;



--5.1

WITH patient_summary AS (
    SELECT
        p.patient_id,
        CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
        TIMESTAMPDIFF(YEAR, p.date_of_birth, CURRENT_DATE()) AS age,
        COUNT(a.appointment_id) AS total_appointments,
        SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
        SUM(t.cost) AS total_cost,
        MAX(a.appointment_date) AS last_appointment_date
    FROM patients p
    LEFT JOIN appointments a 
        ON p.patient_id = a.patient_id
    LEFT JOIN treatments t 
        ON a.appointment_id = t.appointment_id
    GROUP BY 
        p.patient_id, 
        p.first_name, 
        p.last_name, 
        p.date_of_birth
)

SELECT
    patient_id,
    patient_name,
    CASE
        WHEN age < 18 THEN 'Child'
        WHEN age < 65 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category,
    total_appointments,
    ROUND(
        completed_appointments * 100.0 / NULLIF(total_appointments, 0), 
        2
    ) AS completion_rate,
    CASE
        WHEN completed_appointments * 100.0 / NULLIF(total_appointments, 0) >= 80 THEN 'Excellent'
        WHEN completed_appointments * 100.0 / NULLIF(total_appointments, 0) >= 60 THEN 'Good'
        ELSE 'Poor'
    END AS appointment_status,
    total_cost,
    CASE
        WHEN total_cost < 1000 THEN 'Low'
        WHEN total_cost < 5000 THEN 'Medium'
        ELSE 'High'
    END AS cost_category,
    last_appointment_date,
    DATEDIFF(day, last_appointment_date, CURRENT_DATE()) AS days_since_last_appointment,
    CASE
        WHEN last_appointment_date IS NULL THEN 'No Visits'
        WHEN DATEDIFF(day, last_appointment_date, CURRENT_DATE()) <= 30 THEN 'Active'
        WHEN DATEDIFF(day, last_appointment_date, CURRENT_DATE()) <= 90 THEN 'Inactive'
        ELSE 'Dormant'
    END AS patient_status,
    RANK() OVER (ORDER BY total_cost DESC) AS treatment_cost_rank
FROM patient_summary;



--5.2

SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    CASE
        WHEN d.years_of_experience < 5 THEN 'Junior'
        WHEN d.years_of_experience < 10 THEN 'Mid-Level'
        WHEN d.years_of_experience < 15 THEN 'Senior'
        ELSE 'Expert'
    END AS experience_level,
    COUNT(a.appointment_id) AS total_appointments,
    ROUND(SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) * 100.0 /
          COUNT(a.appointment_id), 2) AS completion_rate,
    CASE
        WHEN SUM(CASE WHEN a.status='Completed' THEN 1 ELSE 0 END) * 100.0 /
             COUNT(a.appointment_id) >= 80 THEN 'Excellent'
        WHEN SUM(CASE WHEN a.status='Completed' THEN 1 ELSE 0 END) * 100.0 /
             COUNT(a.appointment_id) >= 60 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS performance_rating,
    ROUND(AVG(t.cost),2) AS avg_treatment_cost,
    SUM(t.cost) AS total_revenue,
    RANK() OVER (ORDER BY SUM(t.cost) DESC) AS revenue_rank,
    PERCENT_RANK() OVER (ORDER BY SUM(t.cost)) AS revenue_percentile,
    COUNT(DISTINCT a.patient_id) AS patient_count,
    ROUND(COUNT(a.appointment_id) * 1.0 /
          COUNT(DISTINCT a.patient_id),2) AS avg_appointments_per_patient
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
LEFT JOIN treatments t ON a.appointment_id = t.appointment_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization, d.years_of_experience;



--5.3


SELECT
    t.treatment_id,
    t.treatment_name,
    dept.department_name,
    t.cost,
    AVG(t.cost) OVER (PARTITION BY t.treatment_name) AS avg_cost,
    CASE
        WHEN t.cost > AVG(t.cost) OVER (PARTITION BY t.treatment_name) THEN 'Above Average'
        WHEN t.cost < AVG(t.cost) OVER (PARTITION BY t.treatment_name) THEN 'Below Average'
        ELSE 'Average'
    END AS cost_deviation,
    CASE
        WHEN t.cost > AVG(t.cost) OVER (PARTITION BY t.treatment_name) * 1.5 THEN 'High Anomaly'
        WHEN t.cost < AVG(t.cost) OVER (PARTITION BY t.treatment_name) * 0.5 THEN 'Low Anomaly'
        ELSE 'Normal'
    END AS anomaly_flag,
    PERCENT_RANK() OVER (PARTITION BY t.treatment_name ORDER BY t.cost) AS cost_percentile
FROM treatments t
JOIN appointments a ON t.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN departments dept ON d.department_id = dept.department_id;



--5.4

WITH monthly_data AS (
    SELECT
        dept.department_name,
        TO_VARCHAR(a.appointment_date, 'YYYY-MM') AS year_month,
        COUNT(a.appointment_id) AS total_appointments,
        SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
        SUM(t.cost) AS total_revenue
    FROM departments dept
    JOIN doctors d 
        ON dept.department_id = d.department_id
    JOIN appointments a 
        ON d.doctor_id = a.doctor_id
    LEFT JOIN treatments t 
        ON a.appointment_id = t.appointment_id
    GROUP BY 
        dept.department_name,
        TO_VARCHAR(a.appointment_date, 'YYYY-MM')
)

SELECT
    department_name,
    year_month,
    total_appointments,
    completed_appointments,
    ROUND(
        completed_appointments * 100.0 / NULLIF(total_appointments, 0), 
        2
    ) AS completion_rate,
    total_revenue,
    total_revenue 
        - LAG(total_revenue) OVER (
            PARTITION BY department_name 
            ORDER BY year_month
        ) AS revenue_change,
    CASE
        WHEN total_revenue > LAG(total_revenue) OVER (
            PARTITION BY department_name 
            ORDER BY year_month
        ) THEN 'Increase'
        WHEN total_revenue < LAG(total_revenue) OVER (
            PARTITION BY department_name 
            ORDER BY year_month
        ) THEN 'Decrease'
        ELSE 'Stable'
    END AS revenue_trend,
    RANK() OVER (
        PARTITION BY year_month 
        ORDER BY total_revenue DESC
    ) AS revenue_rank,
    SUM(total_revenue) OVER (
        PARTITION BY department_name 
        ORDER BY year_month
    ) AS cumulative_revenue,
    ROUND(
        total_revenue / NULLIF(total_appointments, 0), 
        2
    ) AS avg_revenue_per_appointment
FROM monthly_data;

--5.5

SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    CASE
        WHEN DATEDIFF(year, p.date_of_birth, CURRENT_DATE) < 18 THEN 'Child'
        WHEN DATEDIFF(year, p.date_of_birth, CURRENT_DATE) < 65 THEN 'Adult'
        ELSE 'Senior'
    END AS age_category,
    SUM(CASE WHEN lr.status = 'Abnormal' THEN 1 ELSE 0 END) AS abnormal_results,
    SUM(CASE WHEN lr.status = 'Critical' THEN 1 ELSE 0 END) AS critical_results,
    CASE
        WHEN SUM(CASE WHEN lr.status = 'Critical' THEN 1 ELSE 0 END) > 0
          OR SUM(CASE WHEN lr.status = 'Abnormal' THEN 1 ELSE 0 END) >= 3 THEN 'High Risk'
        WHEN SUM(CASE WHEN lr.status = 'Abnormal' THEN 1 ELSE 0 END) IN (1, 2) THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level,
    SUM(t.cost) AS total_treatment_cost,
    RANK() OVER (ORDER BY SUM(t.cost) DESC) AS cost_rank,
    SUM(CASE WHEN a.appointment_type = 'Emergency' THEN 1 ELSE 0 END) AS emergency_visits,
    MAX(a.appointment_date) AS last_appointment_date,
    DATEDIFF(day, MAX(a.appointment_date), CURRENT_DATE) AS days_since_last_visit,
    CASE
        WHEN SUM(CASE WHEN lr.status = 'Critical' THEN 1 ELSE 0 END) > 0 THEN 'Immediate Follow-up'
        WHEN SUM(CASE WHEN lr.status = 'Abnormal' THEN 1 ELSE 0 END) >= 1 THEN 'Schedule Follow-up'
        ELSE 'Regular Monitoring'
    END AS recommended_action
FROM patients p
LEFT JOIN lab_results lr 
    ON p.patient_id = lr.patient_id
LEFT JOIN appointments a 
    ON p.patient_id = a.patient_id
LEFT JOIN treatments t 
    ON a.appointment_id = t.appointment_id
GROUP BY 
    p.patient_id,
    p.first_name,
    p.last_name,
    p.date_of_birth;

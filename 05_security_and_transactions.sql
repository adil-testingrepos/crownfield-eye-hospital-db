7. Database Roles and Privileges
Purpose: Create roles for four types of users and assign suitable permissions.
Role	Access
Administrator	Read, add, update, and delete records
Doctor	View clinicians and manage appointments
Receptionist	Manage patient and clinic records
Patient	View permitted clinic and medicine information
Create the roles
CREATE ROLE IF NOT EXISTS 'ClinicAdmin';
CREATE ROLE IF NOT EXISTS 'DoctorRole';
CREATE ROLE IF NOT EXISTS 'ReceptionRole';
CREATE ROLE IF NOT EXISTS 'PatientRole';
Administrator
GRANT SELECT, INSERT, UPDATE, DELETE
ON EyeClinicDB.*
TO 'ClinicAdmin';
Doctor
GRANT SELECT
ON EyeClinicDB.CLINICIAN
TO 'DoctorRole';

GRANT SELECT, INSERT, UPDATE
ON EyeClinicDB.APPOINTMENT
TO 'DoctorRole';
Receptionist
GRANT SELECT, INSERT, UPDATE
ON EyeClinicDB.PATIENT
TO 'ReceptionRole';

GRANT SELECT
ON EyeClinicDB.CLINIC
TO 'ReceptionRole';
Patient
GRANT SELECT
ON EyeClinicDB.MEDICINE
TO 'PatientRole';

GRANT SELECT
ON EyeClinicDB.CLINIC
TO 'PatientRole';
Explanation: Roles limit access according to each user's responsibilities. Patient access to personal appointment information must be restricted so that patients cannot see other people's medical records.
8. Protect Sensitive Data Using Hashing
Purpose: Store password hashes in a separate table.
-- 1. Create the UserPasswords table for secure credential hashing
CREATE TABLE IF NOT EXISTS UserPasswords (
    UserID VARCHAR(10) PRIMARY KEY,
    PasswordHash VARCHAR(255) NOT NULL
);

-- 2. Insert a demonstration hash using SHA-256
INSERT INTO UserPasswords (UserID, PasswordHash)
VALUES ('OP001', SHA2('ClinicPass2026', 256));

-- 3. Check and verify the password login match
SELECT UserID, 'Login Successful' AS AuthStatus
FROM UserPasswords
WHERE UserID = 'OP001'
AND PasswordHash = SHA2('ClinicPass2026', 256);




Explanation: Hashing stores a transformed password value instead of the original password. For real applications, use a password-specific algorithm such as bcrypt or Argon2id rather than plain SHA-256.

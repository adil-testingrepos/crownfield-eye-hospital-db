1. Aggregate Query Using GROUP BY and HAVING
Purpose: Find medicine records that are linked to more than one appointment.
SELECT MedicineID, COUNT(PrescriptionID) AS TotalPrescribed
FROM PrescriptionItem
GROUP BY MedicineID
HAVING COUNT(PrescriptionID) > 1;


Explanation: The query groups records by medicine and counts how many appointments each medicine is linked to. It displays only medicines used in more than one appointment.
2. INNER JOIN Across Four Tables
Purpose: Display medicine names, appointment IDs, patient IDs, and diagnoses.
SELECT P.PatientName, A.AppointmentID, C.ClinicianName, M.MedicineName
FROM Patient P
JOIN Appointment A ON P.PatientID = A.PatientID
JOIN Clinician C ON A.ClinicianID = C.ClinicianID
JOIN Prescription PR ON A.AppointmentID = PR.AppointmentID
JOIN PrescriptionItem PI ON PR.PrescriptionID = PI.PrescriptionID
JOIN Medicine M ON PI.MedicineID = M.MedicineID;


Explanation: This query joins the MEDICINE, APPOINTMENT_MEDICINE, APPOINTMENT, and PATIENT tables to show which medicines are associated with which patients' appointments.
3. LEFT JOIN to Find Clinicians Without Appointments
Purpose: Find clinicians who do not have any appointments recorded.
SELECT C.ClinicianID, C.ClinicianName
FROM Clinician C
LEFT JOIN Appointment A ON C.ClinicianID = A.ClinicianID
WHERE A.AppointmentID IS NULL;



Explanation: The query lists clinicians who have no matching appointment record.
4. Subquery to Find Clinics With Above-Average Appointments
Purpose: Find clinics that have more appointments than the average number of appointments per clinic.
WITH ClinicCounts AS (
    SELECT ClinicID, COUNT(*) AS ApptCount
    FROM Appointment
    GROUP BY ClinicID
)
SELECT ClinicID, ApptCount
FROM ClinicCounts
WHERE ApptCount > (SELECT AVG(ApptCount) FROM ClinicCounts);


Explanation: The inner query counts appointments for each clinic. The outer query displays clinics whose appointment count is greater than the average.

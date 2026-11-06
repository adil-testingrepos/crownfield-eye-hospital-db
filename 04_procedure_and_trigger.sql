5. Stored Procedure to Find Medicines for an Appointment
Purpose: Create a procedure that displays the medicines linked to a selected appointment.
DELIMITER //
CREATE PROCEDURE GetPatientAppointments(IN inputPatientID VARCHAR(10))
BEGIN
    SELECT A.AppointmentID, A.AppointmentDate, Cl.ClinicName, Cn.ClinicianName
    FROM Appointment A
    JOIN Clinic Cl ON A.ClinicID = Cl.ClinicID
    JOIN Clinician Cn ON A.ClinicianID = Cn.ClinicianID
    WHERE A.PatientID = inputPatientID;
END //
DELIMITER ;
-- Execution:
-- CALL GetPatientAppointments('OP001');


Explanation: The procedure accepts an appointment ID and displays the medicine records associated with that appointment.
6. Trigger to Check Appointment Priority
Purpose: Prevent appointments from being inserted with an invalid priority.
DELIMITER //
CREATE TRIGGER ValidateFollowUpPriority
BEFORE INSERT ON FollowUpPlan
FOR EACH ROW
BEGIN
    IF NEW.Priority NOT IN ('Routine', 'High', 'Urgent') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Priority must be Routine, High, or Urgent.';
    END IF;
END //
DELIMITER ;



Explanation: The trigger checks that the priority is Routine, High, or Urgent before saving a new appointment.

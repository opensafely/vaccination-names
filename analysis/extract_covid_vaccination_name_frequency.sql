SELECT
    VaccinationName_ID,
    VaccinationName,
    CEILING(COUNT(VaccinationName) / 100.0) * 100 AS Frequency
FROM Vaccination
WHERE
    VaccinationName_ID IN (
        SELECT VaccinationName_ID
        FROM
            VaccinationReference
        WHERE VaccinationContent = 'SARS-2 Coronavirus'
    ) AND
    Patient_ID NOT IN (
        SELECT Patient_ID FROM PatientsWithTypeOneDissent
    )
GROUP BY VaccinationName_ID, VaccinationName
ORDER BY Frequency DESC;

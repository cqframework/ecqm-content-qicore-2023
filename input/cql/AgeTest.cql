library AgeTest

using QICore version '4.1.1'

valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307' 

parameter "Measurement Period" Interval<DateTime> default Interval[@2022-01-01T00:00:00.000Z, @2023-01-01T00:00:00.000Z)

context Patient

define AgeTest: AgeInYearsAt(date from start of "Measurement Period")

//define "Encounter with Age Range":
//  ["Encounter": "Encounter Inpatient"] EncounterInpatient
//    where AgeInYearsAt(date from start of EncounterInpatient.period) in Interval[ 8, 65 )

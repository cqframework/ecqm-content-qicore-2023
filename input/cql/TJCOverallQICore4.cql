library TJCOverallQICore4 version '6.0.000'
/* Copied from MADiE on 1-12-2023 from 'context Patient' onwards */
/*
@update: BTR 2023-01-14 -> Updated for connectathon 23

@update: BTR 2020-03-31 ->
Incremented version to 5.0.000
Updated FHIR version to 4.0.1

@update: BTR 2021-07-02 ->
Incremented GCL version to 6.0.000
Applied 2021 AU changes

@update: BTR 2022-05-26 ->
Refresh from 2022 AU
*/

using QICore version '4.1.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include CQMCommon version '1.1.000' called CQMCommon
include SupplementalDataElements version '3.0.000' called SDE
include QICoreCommon version '1.3.000' called QICoreCommon 

valueset "Comfort Measures": 'http://cts.nlm.nih.gov/fhir/ValueSet/1.3.6.1.4.1.33895.1.3.0.45'
valueset "Discharge To Acute Care Facility": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.87'
valueset "Discharged to Health Care Facility for Hospice Care": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.207'
valueset "Discharged to Home for Hospice Care": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.209'
valueset "Emergency Department Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292'
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307'
valueset "Hemorrhagic Stroke": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.212'
valueset "Ischemic Stroke": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.247'
valueset "Left Against Medical Advice": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.308'
valueset "Non-Elective Inpatient Encounter": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.424'
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143'
valueset "Patient Expired": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.309'

parameter "Measurement Period" Interval<DateTime> default Interval[@2022-01-01T00:00:00.0, @2023-01-01T00:00:00.0) 
  
context Patient

define "Non Elective Inpatient Encounter":
  ["Encounter": "Non-Elective Inpatient Encounter"] NonElectiveEncounter
		where CQMCommon."LengthInDays"(NonElectiveEncounter.period) <= 120
      and NonElectiveEncounter.period ends during day of "Measurement Period"
      /* this does not work but above works ... and E.period ends during day of "Measurement Period" */

define "All Stroke Encounter":
  "Non Elective Inpatient Encounter" NonElectiveEncounter
    where (CQMCommon."PrincipalDiagnosis"(NonElectiveEncounter).code in "Hemorrhagic Stroke"
        or CQMCommon."PrincipalDiagnosis"(NonElectiveEncounter).code in "Ischemic Stroke")
        
  
define "Ischemic Stroke Encounter":
  "Encounter with Principal Diagnosis and Age" EncounterWithAge
		where CQMCommon."PrincipalDiagnosis"(EncounterWithAge).code in "Ischemic Stroke"

define "Ischemic Stroke Encounters with Discharge Disposition":
  "Ischemic Stroke Encounter" IschemicStrokeEncounter
		where IschemicStrokeEncounter.hospitalization.dischargeDisposition in "Discharge To Acute Care Facility"
			or IschemicStrokeEncounter.hospitalization.dischargeDisposition in "Left Against Medical Advice"
			or IschemicStrokeEncounter.hospitalization.dischargeDisposition in "Patient Expired"
			or IschemicStrokeEncounter.hospitalization.dischargeDisposition in "Discharged to Home for Hospice Care"
			or IschemicStrokeEncounter.hospitalization.dischargeDisposition in "Discharged to Health Care Facility for Hospice Care"

/* ORIG     where AgeInYearsAt(date from start of AllStrokeEncounter.period)>= 18 */
/*FIX current problem with AgeInYearsAt required a modified approach - refer to https://github.com/cqframework/ecqm-content-qicore-2022/issues 6*/
define "Encounter with Principal Diagnosis and Age":
  "All Stroke Encounter" AllStrokeEncounter
    where CalculateAgeInYearsAt ( Patient.birthDate, date from start of AllStrokeEncounter.period ) >= 18

define "Comfort Measures during Hospitalization":
  "Ischemic Stroke Encounter" IschemicStrokeEncounter
    with "Intervention Comfort Measures" ComfortMeasure
     such that Coalesce(start of QICoreCommon.ToInterval(ComfortMeasure.performed), ComfortMeasure.authoredOn) during CQMCommon."HospitalizationWithObservation"(IschemicStrokeEncounter)

define "Encounter with Comfort Measures during Hospitalization":
  "Ischemic Stroke Encounter" IschemicStrokeEncounter
    with "Intervention Comfort Measures" ComfortMeasure
     such that Coalesce(start of QICoreCommon."ToInterval"(ComfortMeasure.performed), ComfortMeasure.authoredOn) during CQMCommon."HospitalizationWithObservation" ( IschemicStrokeEncounter )

define "Intervention Comfort Measures":
  ( ["ServiceRequest"] P
      where P.code in "Comfort Measures"
        and P.intent = 'order'
        and P.status in { 'active', 'on-hold', 'completed'}
  )
    union ( ["Procedure": "Comfort Measures"] InterventionPerformed
        where InterventionPerformed.status in { 'completed', 'in-progress' }
    )
define function "TruncateTime"(Value DateTime ):
  DateTime(year from Value, month from Value, day from Value, 0, 0, 0, 0, timezoneoffset from Value)

define function "CalendarDayOfOrDayAfter"(StartValue DateTime ):
  Interval["TruncateTime"(StartValue), "TruncateTime"(StartValue + 2 days))

define function "HospitalizationWithObservationLengthofStay"(Encounter "Encounter"):
  CQMCommon."LengthInDays"(CQMCommon."HospitalizationWithObservation"(Encounter))
library ChildrenWhoHaveDentalDecayorCavitiesFHIR version '0.0.001'

/*
This content is a work in progress and should not be considered a final specification
or recommendation for guidance. Tests are available for this content.
*/

using QICore version '4.1.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include SupplementalDataElements version '3.0.000' called SDE
include CQMCommon version '1.0.000' called CQMCommon
include HospiceQICore4 version '3.0.000' called Hospice
include StatusFHIR version '1.0.0' called Status
include QICoreCommon version '1.2.000' called QICoreCommon

valueset "Clinical Oral Evaluation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.125.12.1003' 
valueset "Dental Caries": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.125.12.1004' 

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2023-01-01T00:00:00.000Z, @2024-01-01T00:00:00.000Z)

context Patient

define "Initial Population":
  // AgeInMonthsAt(date from start of "Measurement Period") >= 6
  //     and AgeInYearsAt(date from start of "Measurement Period") <=20
    CalculateAgeInMonthsAt(Patient.birthDate, date from start of "Measurement Period") >= 6
       and CalculateAgeInYearsAt(Patient.birthDate, date from start of "Measurement Period") <=20
       and exists "Qualifying Encounters"

define "Qualifying Encounters":
  (Status."Finished Encounter"([Encounter: "Clinical Oral Evaluation"])) ValidEncounter
        where QICoreCommon."ToInterval"(ValidEncounter.period) during day of "Measurement Period"

define "Denominator":
  "Initial Population"

define "Denominator Exclusions":
  Hospice."Has Hospice Services"

define "Numerator":
  exists ((Status."Active Condition"( [Condition: "Dental Caries"])) DentalCaries
        where QICoreCommon."ToPrevalenceInterval"(DentalCaries) overlaps "Measurement Period"
          )

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"


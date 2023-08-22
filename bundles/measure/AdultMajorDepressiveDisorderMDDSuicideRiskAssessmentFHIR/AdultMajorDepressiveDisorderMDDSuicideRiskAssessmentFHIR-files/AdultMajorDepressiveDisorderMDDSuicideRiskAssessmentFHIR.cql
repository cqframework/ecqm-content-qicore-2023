library AdultMajorDepressiveDisorderMDDSuicideRiskAssessmentFHIR version '0.0.004'

using QICore version '4.1.1'

include SupplementalDataElements version '3.4.000' called SDE
include QICoreCommon version '1.5.000' called QICoreCommon
include CQMCommon version '1.4.000' called CQMCommon
include FHIRHelpers version '4.3.000' called FHIRHelpers

codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "LOINC": 'http://loinc.org'
codesystem "ActCode": 'http://terminology.hl7.org/CodeSystem/v3-ActCode'

valueset "Emergency Department Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1010'
valueset "Ethnicity": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.837'
valueset "Major Depressive Disorder Active": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1491'
valueset "Office Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1001'
valueset "ONC Administrative Sex": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1'
valueset "Outpatient Consultation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1008'
valueset "Payer": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3591'
valueset "Psych Visit Diagnostic Evaluation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1492'
valueset "Psych Visit Psychotherapy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1496'
valueset "Psychoanalysis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.1141'
valueset "Race": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.114222.4.11.836'
valueset "Telehealth Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.101.12.1031'

code "Birth date": '21112-8' from "LOINC" display 'Birth date'
code "Suicide risk assessment (procedure)": '225337009' from "SNOMEDCT" display 'Suicide risk assessment (procedure)'
code "AMB": 'AMB' from "ActCode" display 'Ambulatory'

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2024-01-01T00:00:00.0, @2025-01-01T00:00:00.0)

context Patient

define "Initial Population":
  "New or Recurrent Major Depressive Disorder Encounter" NewOrRecurrentMDDEncounter
    where "AgeInYearsAt"(date from start of "Measurement Period") >= 17

define "Denominator":
  "Initial Population"

define "Numerator":
  "New or Recurrent Major Depressive Disorder Encounter" NewOrRecurrentMDDEncounter
    with ["Procedure": "Suicide risk assessment (procedure)"] SuicideRiskAssessment
      such that SuicideRiskAssessment.status = 'completed'
        and QICoreCommon."ToInterval" ( SuicideRiskAssessment.performed ) during NewOrRecurrentMDDEncounter.period

define "New or Recurrent Major Depressive Disorder Encounter":
  "Major Depressive Disorder Encounter" NewOrRecurrentMDDEncounter
    without "Major Depressive Disorder Encounter" PriorMDDEpisodeEncounter
      such that ( PriorMDDEpisodeEncounter !~ NewOrRecurrentMDDEncounter
          and PriorMDDEpisodeEncounter.period ends 104 days or less before day of start of NewOrRecurrentMDDEncounter.period
      )
    where NewOrRecurrentMDDEncounter.period during "Measurement Period"

define "Major Depressive Disorder Encounter":
  ( ["Encounter": "Psych Visit Diagnostic Evaluation"]
    union ["Encounter": "Emergency Department Visit"]
    union ["Encounter": "Office Visit"]
    union ["Encounter": "Outpatient Consultation"]
    union ["Encounter": "Psych Visit Psychotherapy"]
    union ["Encounter": "Psychoanalysis"]
    union ["Encounter": "Telehealth Services"] ) ValidEncounter
    where ValidEncounter.status = 'finished'
      and ValidEncounter.class ~ "AMB"
      and ( ValidEncounter.reasonCode in "Major Depressive Disorder Active"
          or exists ( ( CQMCommon."EncounterDiagnosis" ( ValidEncounter ) ) EncounterDiagnosis
              where EncounterDiagnosis.code in "Major Depressive Disorder Active"
          )
      )

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"
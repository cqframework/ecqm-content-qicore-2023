library Test

using QICore version '4.1.1'

include FHIRHelpers version '4.0.013'

include MATGlobalCommonFunctionsQICore4 version '7.0.000' called Global
include CumulativeMedicationDurationQICore4 version '2.0.000' called CMD

valueset "Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'
valueset "Present on Admission or Clinically Undetermined": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1147.197'
valueset "Immune Modulators": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.124'

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2019-01-01T00:00:00.0, @2020-01-01T00:00:00.0)

context Patient

/*
https://oncprojectracking.healthit.gov/support/projects/CQLIT/issues/CQLIT-315

How do we make use of the DiagnosisPresentOnAdmission extension to determine whether
a diagnosis was present on admission?

http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-encounter-diagnosisPresentOnAdmission
*/

//define "Encounter With Diabetes Diagnosis Present on Admission":
//  Global."Inpatient Encounter" IPEncounter
//    where exists (IPEncounter.diagnosis Diagnosis
//      where (singleton from ([Condition] C where C.id = Global.GetId(Diagnosis.condition.reference))).code in "Diabetes"
//        and Global.GetExtension(Diagnosis, 'http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-encounter-diagnosisPresentOnAdmission').value in Global."Present on Admission or Clinically Undetermined"
//    )

/*
Potential improvement?
*/

//define "EncounterDiagnosis":
//  Global."Inpatient Encounter" IPEncounter
//    return IPEncounter.diagnosis

//define "Encounter With Diabetes Diagnosis Present on Admission (2)":
//  Global."Inpatient Encounter" IPEncounter
//    where exists ((Global.PresentOnAdmissionDiagnosis(IPEncounter)) POADiagnosis
//      where POADiagnosis.code in "Diabetes"
//    )

define "Encounter With Diabetes Diagnosis Present on Admission (3)":
  Global."Inpatient Encounter" IPEncounter
    where exists (IPEncounter.diagnosis D
      where Global.GetCondition(D.condition).code in "Diabetes"
        and D.diagnosisPresentOnAdmission in "Present on Admission or Clinically Undetermined"
    )


/*
https://oncprojectracking.healthit.gov/support/projects/CQLIT/issues/CQLIT-332

For QICore on VSCode: Global.PrincipalDiagnosis returns a Condition but cannot access the code of that Condition. 
It gets a java error anytime '.code' is appended to the return from Global.PrincipalDiagnosis. Should I be able to 
directly access the code from the return? Or do I have to search all of the Conditions again and tie them by id to 
Encounter again, and then access the code?
*/

define "All Stroke Encounter":
 Global."Inpatient Encounter" IPEncounter
   where IPEncounter.principalDiagnosis().code in "Diabetes"



define "Date Filter Expression":
  [Condition] C
    where C.onset = Today()

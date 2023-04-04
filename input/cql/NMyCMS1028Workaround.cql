library NMyCMS1028Workaround version '1.1.000'

using QICore version '4.1.1'

include PCMaternal version '5.0.000' called PCMaternal
include CQMCommon version '1.0.000' called CQMCommon

valueset "Blood Transfusion": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.213'
valueset "COVID 19 Confirmed": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.373' 
valueset "Patient Expired": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.309' 
valueset "Present on Admission = No or Unable To Determine": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.370' 
valueset "Present On Admission = Yes or Exempt": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.63' 
valueset "Respiratory Conditions Related to COVID 19": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.376' 
valueset "Respiratory Support Procedures Related to COVID 19": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.379' 
valueset "Severe Maternal Morbidity Diagnoses": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.255'
valueset "Severe Maternal Morbidity Procedures": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.256'

context Patient

define "Delivery Encounters with Blood Transfusion":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      with ["Procedure": "Blood Transfusion"] BloodTransfusion
        such that BloodTransfusion.status = 'completed'
          and BloodTransfusion.performed starts during day of PCMaternal."HospitalizationWithEDOBTriageObservation" ( TwentyWeeksPlusEncounter )


define "Delivery Encounters with Severe Obstetric Complications (Excluding Blood Transfusions)":
  "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure (Excluding Blood Transfusion)"
                  union "Delivery Encounters with Expiration"

define "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation":
  "Delivery Encounters with Calculated Gestational Age Greater than or Equal to 20 Weeks"
            union "Delivery Encounters with Estimated Gestational Age Assessment Greater than or Equal to 20 Weeks"
            
define "Delivery Encounters with Calculated Gestational Age Greater than or Equal to 20 Weeks":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
                  where PCMaternal."CalculatedGestationalAge" ( DeliveryEncounter ) >= 20

define "Delivery Encounters with Estimated Gestational Age Assessment Greater than or Equal to 20 Weeks":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
                  where PCMaternal."CalculatedGestationalAge" ( DeliveryEncounter ) is null
                    and ( PCMaternal."LastEstimatedGestationalAge" ( DeliveryEncounter ) >= 20 weeks )
                    
define "Delivery Encounters with Expiration":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
        where TwentyWeeksPlusEncounter.hospitalization.dischargeDisposition in "Patient Expired"

define "Delivery Encounters with Severe Obstetric Complications":
  "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure (Excluding Blood Transfusion)"
                  union "Delivery Encounters with Expiration"
                  union "Delivery Encounters with Blood Transfusion"

define "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure (Excluding Blood Transfusion)":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Severe Maternal Morbidity Diagnoses"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present on Admission = No or Unable To Determine"
      )
        or exists ( ["Procedure": "Severe Maternal Morbidity Procedures"] EncounterProcedures
            where EncounterProcedures.status = 'completed' and  EncounterProcedures.performed starts during day of PCMaternal."HospitalizationWithEDOBTriageObservation" ( TwentyWeeksPlusEncounter )
        )

define "Delivery Encounters with COVID and Respiratory Condition or Procedure":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( CQMCommon."EncounterDiagnosis" ( TwentyWeeksPlusEncounter ) ) EncounterDiagnoses
        where EncounterDiagnoses.code in "COVID 19 Confirmed"
          and ( ( exists ( CQMCommon."EncounterDiagnosis" ( TwentyWeeksPlusEncounter ) ) EncounterDiagnoses
                where EncounterDiagnoses.code in "Respiratory Conditions Related to COVID 19"
            )
              or exists ( ["Procedure": "Respiratory Support Procedures Related to COVID 19"] EncounterProcedures
                  where EncounterProcedures.status = 'completed' and  EncounterProcedures.performed  starts during day of PCMaternal."HospitalizationWithEDOBTriageObservation" ( TwentyWeeksPlusEncounter )
              )
          )

define function "FirstLabTestWithEncounterId"(LabList List<QICore.Observation> ):
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" Encounter
    let FirstLab: First(LabList Lab
  //(first resulted value 24 hours prior to start of encounter and before time of delivery)
        where Lab.issued during Interval[start of PCMaternal."HospitalizationWithEDOBTriageObservation"(Encounter)- 1440 minutes, PCMaternal."LastTimeOfDelivery"(Encounter))
          and Lab.status in { 'final', 'amended', 'corrected' }
  //      and Lab.category in { "laboratory"}
   // and (Lab.category C where C ~ QICoreCommon."laboratory") 
        sort by issued
    )
    return {
      EncounterId: Encounter.id,
      FirstResult: FirstLab.value as Quantity,
      Timing: FirstLab.issued
    }
    
define function "FirstPhysicalExamWithEncounterId"(ExamList List<QICore.Observation> ):
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" Encounter
    let FirstExam: First(ExamList Exam
  //(first resulted value 24 hours prior to start of encounter and before time of delivery)
        where Exam.issued during Interval[start of PCMaternal."HospitalizationWithEDOBTriageObservation"(Encounter)- 1440 minutes, PCMaternal."LastTimeOfDelivery"(Encounter))
          and Exam.status in { 'final', 'amended', 'corrected' }
  //and (Exam.category V where V~QICoreCommon."vital-signs")
        sort by issued
    )
    return {
      EncounterId: Encounter.id,
      FirstResult: FirstExam.value as Quantity,
      Timing: FirstExam.issued
    }
    
    
define function "LengthInHours"(Value Interval<DateTime> ):
  //hours between start of Value and
  //end of Value 
  ( duration in minutes between start of Value and 
    end of Value
  ) / 60
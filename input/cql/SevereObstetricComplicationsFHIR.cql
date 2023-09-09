library SevereObstetricComplicationsFHIR version '0.0.007'

using QICore version '4.1.1'

include CQMCommon version '1.4.000' called CQMCommon
include FHIRHelpers version '4.3.000' called FHIRHelpers
include SupplementalDataElements version '3.4.000' called SDE
include PCMaternal version '5.10.000' called PCMaternal
include QICoreCommon version '1.5.000' called QICoreCommon

codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "PresentOnAdmission": 'https://www.cms.gov/Medicare/Medicare-Fee-for-Service-Payment/HospitalAcqCond/Coding'

valueset "20 to 42 Plus Weeks Gestation": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.67'
valueset "Acute or Persistent Asthma": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.271'
valueset "Anemia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.323'
valueset "Autoimmune Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.311'
valueset "Bariatric Surgery": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.317'
valueset "Bleeding Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.287'
valueset "Blood Transfusion": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.213'
valueset "Cardiac Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.341'
valueset "COVID 19 Confirmed": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.373'
valueset "Delivery Procedures": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.59'
valueset "Economic Housing Instability": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.292'
valueset "ED Visit and OB Triage": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.369'
valueset "Emergency Department Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292'
valueset "Gastrointestinal Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.338'
valueset "Gestational Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.269'
valueset "Hematocrit lab test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.114'
valueset "HIV in Pregnancy Childbirth and Puerperium": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.272'
valueset "Hypertension": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.332'
valueset "Long Term Anticoagulant Use": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.366'
valueset "Mental Health Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.314'
valueset "Mild or Moderate Preeclampsia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.329'
valueset "Morbid or Severe Obesity": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.290'
valueset "Multiple Pregnancy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.284'
valueset "Neuromuscular Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.308'
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143'
valueset "Patient Expired": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.309'
valueset "Placenta Previa": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.35'
valueset "Placental Abruption": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.305'
valueset "Placental Accreta Spectrum": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.302'
valueset "Preexisting Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.275'
valueset "Present on Admission is No or Unable To Determine": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.370'
valueset "Present On Admission is Yes or Exempt": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.63'
valueset "Preterm Birth": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.299'
valueset "Previous Cesarean": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.278'
valueset "Pulmonary Hypertension": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.281'
valueset "Renal Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.335'
valueset "Respiratory Conditions Related to COVID 19": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.376'
valueset "Respiratory Support Procedures Related to COVID 19": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.379'
valueset "Severe Maternal Morbidity Diagnoses": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.255'
valueset "Severe Maternal Morbidity Procedures": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.256'
valueset "Severe Preeclampsia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.327'
valueset "Substance Abuse": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.320'
valueset "Thyrotoxicosis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.296'
valueset "Venous Thromboembolism in Pregnancy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.363'
valueset "White blood cells count lab test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.129'

parameter "Measurement Period" Interval<DateTime>
  default Interval[@2024-01-01T00:00:00.0, @2025-01-01T00:00:00.0)

context Patient

define "Initial Population":
  PCMaternal."Delivery Encounter with Age Range"

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

define "Stratification Encounter":
  "Numerator"
    except "Denominator Exclusion"

define "Denominator Exclusion":
  "Delivery Encounters with COVID and Respiratory Condition or Procedure"

define "Stratum 1":
  //This logic identifies a subset of the numerator population with severe obstetric complications excluding cases where transfusion was the only severe obstetric complication.
  
  "Stratification Encounter"
    intersect "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions"

define "Delivery Encounters with Severe Obstetric Complications Excluding Blood Transfusions":
  "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure Excluding Blood Transfusion"
    union "Delivery Encounters with Expiration"

define "Numerator":
  "Delivery Encounters with Severe Obstetric Complications"

define "Delivery Encounters with Calculated Gestational Age Greater than or Equal to 20 Weeks":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
    where DeliveryEncounter.calculatedGestationalAge ( ) >= 20

define "Delivery Encounters with Estimated Gestational Age Assessment Greater than or Equal to 20 Weeks":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
    where DeliveryEncounter.calculatedGestationalAge ( ) is null
      and ( DeliveryEncounter.lastEstimatedGestationalAge ( ) >= 20 weeks )

define "Variable Calculated Gestational Age":
  //This definition establishes a variable of CGA (Calculated Gestational Age).  CGA is a supplemental data element to store the calculated gestational age result from the "CalculatedGestationalAge" function.  The data element enables the capturing and saving of the CGA for data analysis post data receipt. Hospitals do not need to submit any additional data to comply with this definition. 
  
  PCMaternal."Variable Calculated Gestational Age"

define "Denominator":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation"

define "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation":
  "Delivery Encounters with Calculated Gestational Age Greater than or Equal to 20 Weeks"
    union "Delivery Encounters with Estimated Gestational Age Assessment Greater than or Equal to 20 Weeks"
    union "Delivery Encounters with Gestational Age Greater than or Equal to 20 Weeks Based on Coding"

define "Delivery Encounters with Expiration":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where TwentyWeeksPlusEncounter.hospitalization.dischargeDisposition in "Patient Expired"

define "Delivery Encounters with Gestational Age Greater than or Equal to 20 Weeks Based on Coding":
  PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
    let CGA: DeliveryEncounter.calculatedGestationalAge ( ),
    EGA: DeliveryEncounter.lastEstimatedGestationalAge ( )
    where CGA is null
      and EGA is null
      and exists ( ( DeliveryEncounter.encounterDiagnosis ( ) ) EncounterDiagnosis
          where EncounterDiagnosis.code in "20 to 42 Plus Weeks Gestation"
      )

define "Delivery Encounters with Severe Obstetric Complications":
  "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure Excluding Blood Transfusion"
    union "Delivery Encounters with Expiration"
    union "Delivery Encounters with Blood Transfusion"

define "Delivery Encounters with Severe Obstetric Complications Diagnosis or Procedure Excluding Blood Transfusion":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Severe Maternal Morbidity Diagnoses"
          and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present on Admission is No or Unable To Determine"
    )
//EncounterDiagnoses.diagnosisPresentOnAdmission ~ 'N')
      
      or exists ( ["Procedure": "Severe Maternal Morbidity Procedures"] EncounterProcedures
          where EncounterProcedures.status = 'completed'
            and EncounterProcedures.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )
      )

define "Delivery Encounters with COVID and Respiratory Condition or Procedure":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( ( TwentyWeeksPlusEncounter.encounterDiagnosis ( ) ) EncounterDiagnosis
        where EncounterDiagnosis.code in "COVID 19 Confirmed"
    )
      and ( exists ( ( TwentyWeeksPlusEncounter.encounterDiagnosis ( ) ) EncounterDiagnosis
            where EncounterDiagnosis.code in "Respiratory Conditions Related to COVID 19"
        )
          or exists ( ["Procedure": "Respiratory Support Procedures Related to COVID 19"] EncounterProcedures
              where EncounterProcedures.status = 'completed'
                and EncounterProcedures.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )
          )
      )

define "Risk Variable Anemia":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Anemia"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Asthma":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Acute or Persistent Asthma"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Autoimmune Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Autoimmune Disease"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Bariatric Surgery":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Bariatric Surgery"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Bleeding Disorder":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Bleeding Disorder"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Morbid Obesity":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Morbid or Severe Obesity"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Cardiac Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Cardiac Disease"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Economic Housing Instability":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Economic Housing Instability"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Gastrointestinal Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Gastrointestinal Disease"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Gestational Diabetes":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Gestational Diabetes"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable HIV":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "HIV in Pregnancy Childbirth and Puerperium"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Hypertension":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Hypertension"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Long Term Anticoagulant Use":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Long Term Anticoagulant Use"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Mental Health Disorder":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Mental Health Disorder"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Multiple Pregnancy":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Multiple Pregnancy"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Neuromuscular":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Neuromuscular Disease"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Obstetrical VTE":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Venous Thromboembolism in Pregnancy"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Placenta Previa":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Placenta Previa"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Placental Abruption":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Placental Abruption"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Placental Accreta Spectrum":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Placental Accreta Spectrum"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Preexisting Diabetes":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Preexisting Diabetes"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Previous Cesarean":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Previous Cesarean"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Pulmonary Hypertension":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Pulmonary Hypertension"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Renal Disease":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Renal Disease"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Severe Preeclampsia":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Severe Preeclampsia"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Substance Abuse":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Substance Abuse"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Thyrotoxicosis":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Thyrotoxicosis"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Other Preeclampsia":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
        where EncounterDiagnoses.condition.getCondition ( ).code in "Mild or Moderate Preeclampsia"
          and ( EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
    )

define "Risk Variable Preterm Birth":
/*  CGA = Calculated Gestational Age.  EGA = Estimated Gestational Age. */
  
  ( PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
      let CGA: DeliveryEncounter.calculatedGestationalAge ( ),
      EGA: DeliveryEncounter.lastEstimatedGestationalAge ( )
      where CGA in Interval[20, 36]
        or ( CGA is null
            and ( EGA >= 20 weeks
                and EGA <= 36 weeks
            )
        )
  )
    union ( PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
        let CGA: DeliveryEncounter.calculatedGestationalAge ( ),
        EGA: DeliveryEncounter.lastEstimatedGestationalAge ( )
        where CGA is null
          and EGA is null
          and exists ( DeliveryEncounter.diagnosis DeliveryEncounterDiagnoses
              where DeliveryEncounterDiagnoses.condition.getCondition ( ).code in "Preterm Birth"
                and ( DeliveryEncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission is Yes or Exempt" )
          )
    )

define "Delivery Encounters with Blood Transfusion":
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
    with ["Procedure": "Blood Transfusion"] BloodTransfusion
      such that BloodTransfusion.status = 'completed'
        and BloodTransfusion.performed.toInterval ( ) starts during day of TwentyWeeksPlusEncounter.hospitalizationWithEDOBTriageObservation ( )


 //First resulted value 24 hours prior to start of encounter and before time of delivery
 //Report hematocrit as %



define "Risk Variable First Hematocrit Lab Test":
  First(from
      "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" Encounter,
      ["USCoreLaboratoryResultObservationProfile": "Hematocrit lab test"] Hematocrit
      where Hematocrit.issued during Interval[start of Encounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, Encounter.lastTimeOfDelivery())
        and Hematocrit.status in { 'final', 'amended', 'corrected' }
      return {
        EncounterId: Encounter.id,
        FirstResult: Hematocrit.value as Quantity,
        Timing: Hematocrit.issued
      }
      sort by Timing
  )
 

 //First resulted value 24 hours prior to start of encounter and before time of delivery
 //Report white blood cell count as 10*3/uL



define "Risk Variable First White Blood Cell Count Lab Test":
  First(from
      "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" Encounter,
      ["USCoreLaboratoryResultObservationProfile": "White blood cells count lab test"] WBC
      where WBC.issued during Interval[start of Encounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, Encounter.lastTimeOfDelivery())
        and WBC.status in { 'final', 'amended', 'corrected' }
      return {
        EncounterId: Encounter.id,
        FirstResult: WBC.value as Quantity,
        Timing: WBC.issued
      }
      sort by Timing
  )


 //First resulted value 24 hours prior to start of encounter and before time of delivery
 //Report heart rate as beats/min



define "Risk Variable Heart Rate":
  First(from
      "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" Encounter,
      ["observation-heartrate"] HeartRate
      where HeartRate.effective.earliest() during Interval[start of Encounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, Encounter.lastTimeOfDelivery())
        and HeartRate.status in { 'final', 'amended', 'corrected' }
      return {
        EncounterId: Encounter.id,
        FirstResult: HeartRate.value as Quantity,
        Timing: HeartRate.effective.earliest()
      }
      sort by Timing
  )
 
 
 //First resulted value 24 hours prior to start of encounter and before time of delivery
 //Report systolic blood pressure as mm[Hg]



define "Risk Variable Systolic Blood Pressure":
  First(from
      "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" Encounter,
      ["observation-bp"] BP
      where BP.effective.earliest() during Interval[start of Encounter.hospitalizationWithEDOBTriageObservation() - 1440 minutes, Encounter.lastTimeOfDelivery())
        and BP.status in { 'final', 'amended', 'corrected' }
      return {
        EncounterId: Encounter.id,
        FirstResult: BP.SystolicBP.value as Quantity,
        Timing: BP.effective.earliest()
      }
      sort by Timing
  )
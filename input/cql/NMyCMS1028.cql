library NMyCMS1028 version '0.0.000'

using QICore version '4.1.1'

include CQMCommon version '1.0.000' called CQMCommon
include FHIRHelpers version '4.1.000' called FHIRHelpers
include SupplementalDataElements version '3.0.000' called SDE
include PCMaternal version '5.0.000' called PCMaternal
include FHIRCommon version '4.1.000' called FHIRCommon
include QICoreCommon version '1.2.000' called QICoreCommon
include NMyCMS1028Workaround version '1.1.000' called WLib

codesystem "LOINC": 'http://loinc.org' 
codesystem "SNOMEDCT": 'http://snomed.info/sct' 

valueset "Anemia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.323' 
valueset "Asthma": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.271' 
valueset "Autoimmune Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.311' 
valueset "Bariatric Surgery": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.317' 
valueset "Bleeding Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.287' 
valueset "Blood Transfusion": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.213' 
valueset "BMI >= 40": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.290' 
valueset "Cardiac Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.341' 
valueset "COVID 19 Confirmed": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.373' 
valueset "Economic Housing Instability": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.292' 
valueset "ED Visit and OB Triage": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.369' 
valueset "Emergency Department Visit": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.292' 
valueset "Gastrointestinal Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.338' 
valueset "Gestational Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.269' 
valueset "Hematocrit lab test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.114' 
valueset "HIV": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.272' 
valueset "Hypertension": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.332' 
valueset "Long Term Anticoagulant Use": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.366' 
valueset "Mental Health Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.314' 
valueset "Multiple Pregnancy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.284' 
valueset "Neuromuscular Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.308' 
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143' 
valueset "Obstetrical VTE": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.363' 
valueset "Other Preeclampsia": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.329' 
valueset "Patient Expired": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.309' 
valueset "Placenta Previa": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.35' 
valueset "Placental Abruption": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.305' 
valueset "Placental Accreta Spectrum": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.302' 
valueset "Preexisting Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.275' 
valueset "Present on Admission = No or Unable To Determine": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.370' 
valueset "Present On Admission = Yes or Exempt": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.63' 
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
valueset "Trauma Complicating Childbirth": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.266' 
valueset "White blood cells count lab test": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.129' 

code "Heart rate": '8867-4' from "LOINC" display 'Heart rate'
code "Pre-admission observation, undelivered mother (procedure)": '42102002' from "SNOMEDCT" display 'Pre-admission observation, undelivered mother (procedure)'
code "Systolic blood pressure": '8480-6' from "LOINC" display 'Systolic blood pressure'

parameter "Measurement Period" Interval<DateTime>

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
  WLib."Delivery Encounters with COVID and Respiratory Condition or Procedure"

define "Stratum 1":
  //This logic identifies a subset of the numerator population with severe obstetric complications excluding cases where transfusion was the only severe obstetric complication.
                "Stratification Encounter"
                  intersect WLib."Delivery Encounters with Severe Obstetric Complications (Excluding Blood Transfusions)"


define "Numerator":
  WLib."Delivery Encounters with Severe Obstetric Complications"



define "Variable Calculated Gestational Age":
  //This definition establishes a variable of CGA (Calculated Gestational Age).  CGA is a supplemental data element to store the calculated gestational age result from the "CalculatedGestationalAge" function.  The data element enables the capturing and saving of the CGA for data analysis post data receipt. Hospitals do not need to submit any additional data to comply with this definition. 
                PCMaternal."Variable Calculated Gestational Age"

define "Denominator":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation"





define "Risk Variable Lab and Physical Exam Results":
  {
              // First physical exams:  Report heart rate as {beats}/min, systolic blood pressure as mm[Hg]
      FirstHeartRate: WLib."FirstPhysicalExamWithEncounterId"(["Observation": "Heart rate"]),
      FirstSystolicBloodPressure: WLib."FirstPhysicalExamWithEncounterId"(["Observation": "Systolic blood pressure"]),
              // First lab tests:  Report hematocrit as %, white blood cell count as 10*3/uL
      FirstHematocritLab: WLib."FirstLabTestWithEncounterId"(["Observation": "Hematocrit lab test"]),
      FirstWhiteBloodCellCount: WLib."FirstLabTestWithEncounterId"(["Observation": "White blood cells count lab test"])
    }

define "Risk Variable Anemia":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Anemia"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Asthma":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Asthma"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Autoimmune Disease":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Autoimmune Disease"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Bariatric Surgery":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Bariatric Surgery"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Bleeding Disorder":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Bleeding Disorder"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable BMI Greater than or Equal to 40":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "BMI >= 40"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Cardiac Disease":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Cardiac Disease"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Economic Housing Instability":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Economic Housing Instability"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Gastrointestinal Disease":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Gastrointestinal Disease"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Gestational Diabetes":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Gestational Diabetes"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable HIV":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "HIV"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Hypertension":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Hypertension"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Long Term Anticoagulant Use":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Long Term Anticoagulant Use"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Mental Health Disorder":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Mental Health Disorder"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Multiple Pregnancy":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Multiple Pregnancy"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Neuromuscular":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Neuromuscular Disease"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Obstetrical VTE":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Obstetrical VTE"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Placenta Previa":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Placenta Previa"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Placental Abruption":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Placental Abruption"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Placental Accreta Spectrum":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Placental Accreta Spectrum"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Preexisting Diabetes":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Preexisting Diabetes"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Previous Cesarean":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Previous Cesarean"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Pulmonary Hypertension":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Pulmonary Hypertension"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Renal Disease":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Renal Disease"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Severe Preeclampsia":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Severe Preeclampsia"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Substance Abuse":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Substance Abuse"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Thyrotoxicosis":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Thyrotoxicosis"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Other Preeclampsia":
  WLib."Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" TwentyWeeksPlusEncounter
      where exists ( TwentyWeeksPlusEncounter.diagnosis EncounterDiagnoses
          where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Other Preeclampsia"
            and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
      )

define "Risk Variable Preterm Birth":
  //CGA = Calculated Gestational Age.  EGA = Estimated Gestational Age.
    ( PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
        let CGA: PCMaternal."CalculatedGestationalAge" ( DeliveryEncounter ),
        EGA: PCMaternal."LastEstimatedGestationalAge" ( DeliveryEncounter )
        where CGA in Interval[20, 36]
          or ( CGA is null
              and ( EGA >= 20 weeks
                  and EGA <= 36 weeks
              )
          )
    )
      union ( PCMaternal."Delivery Encounter with Age Range" DeliveryEncounter
          let CGA: PCMaternal."CalculatedGestationalAge" ( DeliveryEncounter ),
          EGA: PCMaternal."LastEstimatedGestationalAge" ( DeliveryEncounter )
          where CGA is null
            and EGA is null
            and exists ( DeliveryEncounter.diagnosis EncounterDiagnoses
                where CQMCommon."GetCondition" ( EncounterDiagnoses.condition ).code in "Preterm Birth"
                  and EncounterDiagnoses.diagnosisPresentOnAdmission in "Present On Admission = Yes or Exempt"
            )
      )


  /* Add category once added to Global library.
  "Delivery Encounters At Greater than or Equal to 20 Weeks Gestation" Encounter
  let FirstLab: First(LabList Lab
  //(first resulted value 24 hours prior to start of encounter and before time of delivery)
      where exists (Lab.category C where C ~ QICoreCommon."laboratory") and Lab.issued during Interval[start of PCMaternal."HospitalizationWithEDOBTriageObservation"(Encounter)- 1440 minutes, PCMaternal."LastTimeOfDelivery"(Encounter))
        and Lab.status in { 'final', 'amended', 'corrected' }
  //      and Lab.category in { "laboratory"}
   // and (Lab.category C where C ~ QICoreCommon."laboratory") 
      sort by issued
  )
  return {
    EncounterId: Encounter.id,
    FirstResult: FirstLab.value as Quantity,
    Timing: FirstLab.issued
  }*/


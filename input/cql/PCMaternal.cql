library PCMaternal version '5.0.000'

/*@update: @@Created from QDM v2.1 to FHIR, then updated 041922 after annual update to QDM v2.21.000 @@*/

using QICore version '4.1.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include CQMCommon version '1.0.000' called Global
include QICoreCommon version '1.2.000' called QICoreCommon

codesystem "LOINC": 'http://loinc.org' 

valueset "Delivery Procedures": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.59' 
valueset "ED Visit and OB Triage": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.369' 
valueset "Encounter Inpatient": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.307' 
valueset "Estimated Gestational Age at Delivery": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1045.26' 
valueset "Observation Services": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1111.143' 

code "Date and time of obstetric delivery": '93857-1' from "LOINC" display 'Date and time of obstetric delivery'
code "Delivery date Estimated": '11778-8' from "LOINC" display 'Delivery date Estimated'

parameter "Measurement Period" Interval<DateTime>

context Patient

define "Delivery Encounter with Age Range":
  "Encounter with Age Range" EncounterWithAge
                with ["Procedure": "Delivery Procedures"] DeliveryProcedure
                such that DeliveryProcedure.status = 'completed'
                and QICoreCommon."ToInterval"  ( DeliveryProcedure.performed) starts during day of "HospitalizationWithEDOBTriageObservation"(EncounterWithAge)

define "Encounter with Age Range":
  ["Encounter": "Encounter Inpatient"] EncounterInpatient
                      where EncounterInpatient.status = 'finished'
                        and AgeInYearsAt(date from start of EncounterInpatient.period) in Interval[ 8, 65 )
                        and EncounterInpatient.period ends during day of "Measurement Period"

define "Variable Calculated Gestational Age":
  //This definition establishes a variable of CGA (Calculated Gestational Age) for all patients for the sole purpose of displaying the Calculated Gestational Age. This definition is not used in the measure logic.
  "Delivery Encounter with Age Range" QualifyingEncounter
    let CGA: "CalculatedGestationalAge"(QualifyingEncounter)
  //  return { QualifyingEncounter, CGA }
    return {
      EncounterID: QualifyingEncounter.id,
      CalculatedCGA: CGA
    }

define function "CalculatedGestationalAge"(Encounter Encounter ):
  //Gestational Age = (280-(Estimated Delivery Date minus Reference Date/Delivery Date))/7
  ( 280 - ( difference in days between "LastTimeOfDelivery"(Encounter) and "LastEstimatedDeliveryDate"(Encounter)) ) div 7




define function "HospitalizationWithEDOBTriageObservation"(Encounter Encounter ):
  /*HospitalizationWithEDOBTriageObservation returns the total interval from the start of any immediately prior emergency department visit or OB Triage visit through the observation visit to the discharge of the given encounter*/
  Encounter Visit
    let ObsVisit: Last(["Encounter": "Observation Services"] LastObs
        where LastObs.period ends 1 hour or less on or before start of Visit.period
          and LastObs.status = 'finished'
        sort by 
        end of period
    ),
    VisitStart: Coalesce(start of ObsVisit.period, start of Visit.period),
    EDOBTriageVisit: Last(["Encounter": "ED Visit and OB Triage"] LastEDOBTriage
        where LastEDOBTriage.period ends 1 hour or less on or before VisitStart
          and LastEDOBTriage.status = 'finished'
        sort by 
        end of period
    )
    return Interval[Coalesce(start of EDOBTriageVisit.period, VisitStart), 
    end of Visit.period]
  
  /*===============================================================*/
  /*  03/14/2022 from MATGlobalCommonFunctionsv7.000 - latest QDM  */
  /*     even though this PCMaternalFHIR was derived from          */
  /*     PCMaternal=2.1.000 cql, to make next update easier.       */
  /*     Will need to re-insert "Global". in front of these        */
  /*     function names later (whereever they are directly used.*/

define function "LastEstimatedDeliveryDate"(Encounter Encounter ):
  /*This function identifies the last time the EDD was assessed 42 weeks or less prior to or on delivery and stores the result of that assessment.*/
  Last(["Observation": "Delivery date Estimated"] EstimatedDateOfDelivery
      where EstimatedDateOfDelivery.value as DateTime is not null
        and EstimatedDateOfDelivery.status in { 'final', 'amended', 'corrected' }
        and QICoreCommon."Earliest" (EstimatedDateOfDelivery.effective) 42 weeks or less before or on "LastTimeOfDelivery"(Encounter)
      sort by QICoreCommon."Earliest" (effective)
  ).value as DateTime

define function "LastEstimatedGestationalAge"(Encounter Encounter ):
  Last(["Observation": "Estimated Gestational Age at Delivery"] EstimatedGestationalAge
      where EstimatedGestationalAge.value is not null
        and EstimatedGestationalAge.status in { 'final', 'amended', 'corrected' }
        and QICoreCommon."Earliest"(EstimatedGestationalAge.effective) 24 hours or less before or on "LastTimeOfDelivery"(Encounter)
      sort by QICoreCommon."Earliest" (effective)
  ).value as Quantity

define function "LastTimeOfDelivery"(Encounter Encounter ):
  Last(["Observation": "Date and time of obstetric delivery"] TimeOfDelivery
      where TimeOfDelivery.value as DateTime is not null
        and TimeOfDelivery.status in { 'final', 'amended', 'corrected' }
        and QICoreCommon."Earliest"(TimeOfDelivery.effective) during "HospitalizationWithEDOBTriageObservation"(Encounter)
        and TimeOfDelivery.value as DateTime during "HospitalizationWithEDOBTriageObservation"(Encounter)
      sort by QICoreCommon."Earliest"(effective)
  ).value as DateTime
# ecqm-content-qicore-2023
eCQM Measure Content (Using QICore 4.1.1, based on FHIR R4 v4.0.1)

These draft FHIR-based measures and shared libraries are translated from the QDM-based versions of eCQMs to be published in May 2023 for the 2024 reporting year, and have specific versions, especially for the shared libraries, appropriate to the content for that publication update.

Commits to this repository will automatically trigger a build of the continuous integration build, available here:

https://build.fhir.org/ig/cqframework/ecqm-content-qicore-2023

## Connectathon Scenarios

### Measure Testing

This repository is populated with FHIR-based measure specifications developed using the MADiE tool and based on published AU2023 eCQMs. See the [Measure Content Index](https://docs.google.com/spreadsheets/d/1DocNOIX3ZYWCzOxSHw00sl21WHWx5SeazrlSCUcjqqs/edit#gid=1008487491) for a complete listing of available measure content for measure testing.

### Multi-Provider Patient Scenario

For systems that deal house data from multiple providers, it is often the case that individual patients may have encounters with multiple providers. In these cases, there must be a way to support identifying the data that should be reported with an individual based on the provider being reported. This is often referred to as the attribution of a patient (and their associated data for reporting) to a provider. Because attribution models vary based on where and why a measure is being evaluated (i.e. for what reporting program), attribution is not included as part of the measure specification. This means that currently, reporting systems must partition data differently when running the same measure for different programs. To support formal description of the attribution model, this scenario will look at ways to describe the attribution as part of the program, rather than as part of the measure itself.

The testing scenario we are using to support these investigations is as follows:

![Multi-provider patient scenario](input/images/MultiProviderPatient.png)

The patient, Jane Doe, has 9 encounters, one at the beginning of each month. The first four encounters are with practitioners Jane Smith and John Smith, practicing at Organization A with CCN `CCN-123` and TIN `EIN-00123`. The last five encounters are with practitioners Kelly Smith and John Smith, practicing at Organization B with CCN `CCN-999` and TIN `EIN-00999`.

To support identifying the provider being reported, use the `provider` parameter of the R5 [$evaluate-measure](https://hl7.org/fhir/measure-operation-evaluate-measure.html):

```
GET [base]/Measure/<measure-id>/$evaluate-measure?subject=Patient/MultiProviderPatient&periodStart=2023-01-01&periodEnd=2023-12-31&provider=Organization/organization-a
```

This provides the needed input to the attribution criteria to determine what data should be attributed to the provider for the given patient.

There are two test measures defined to support this scenario testing, a "hospital" encounter-based measure `MPPEncounterLevel`, and a "clinic" patient-based measure `MPPPatientLevel`.

In addition, there is an `AttributionModel` library that introduces two fluent functions, `isAttributable(Patient)` and `isAttributable(Encounter)`:

```cql
parameter "Measurement Period" Interval<DateTime> default Interval[@2023-01-01T00:00:00.0Z, @2023-12-31T23:59:59.999Z]
parameter "Provider" String

context Patient

define fluent function isAttributable(patient Patient):
  "Provider" is not null implies Patient.managingOrganization.reference.endsWith("Provider")

define fluent function isAttributable(encounter Encounter):
  encounter.period during "Measurement Period"
    and "Provider" is not null implies encounter.serviceProvider.reference.endsWith("Provider")
```

These functions are then referenced in the initial population criteria for each of these measures:

```cql
define "Initial Population":
  "Encounter with Principal Diagnosis and Age" Encounter
    where Encounter.isAttributable()
```

```cql
define "Has Qualifying Encounter During First 240 Days of Measurement Period":
  exists ( ( ["Encounter": "Office Visit"]
      union ["Encounter": "Outpatient Consultation"]
      union ["Encounter": "Annual Wellness Visit"]
      union ["Encounter": "Face-to-Face Interaction"]
      union ["Encounter": "Home Healthcare Services"]
      union ["Encounter": "Preventive Care Services Established Office Visit, 18 and Up"]
      union ["Encounter": "Preventive Care Services Initial Office Visit, 18 and Up"]
      union ["Encounter": "Preventive Care Services, Initial Office Visit, 0 to 17"]
      union ["Encounter": "Preventive Care, Established Office Visit, 0 to 17"]
      union ["Encounter": "Telephone Visits"]
    ) QualifyingEncounter
      where QualifyingEncounter.period during day of Interval[start of "Measurement Period", start of "Measurement Period" + 240 days]
        and QualifyingEncounter.isAttributable()
  )

define "Initial Population":
  "Has Qualifying Encounter During First 240 Days of Measurement Period"
```

The "default" attribution model defined by this library is simply that the Patient's managing organization matches the given Provider, and that the Encounter's serviceProvider matches the given Provider.

Whenever measure intent requires the determination of attribution (usually in the qualifying encounter, but sometimes in partitioning encounters to be considered as part of the measure logic below population criteria), these functions can be used to include attribution consideration, but in a way that keeps the attribution model used isolated from the rest of the measure logic.

Subsequently, different attribution logic can be provided by specifying a different version of the AttributionModel library using an artifact manifest:

```json
{
  "resourceType": "Library",
  "id": "MPPManifest",
  "contained": [{
    "resourceType": "Parameters",
    "id": "expansion-parameters",
    "parameter": [{
      "name": "forceCanonicalVersion",
      "valueCanonical": "http://ecqi.healthit.gov/ecqms/Library/AttributionModel|1.0.0-custom"
    }]
  }],
  "extension": [{
    "url": "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-expansionParameters",
    "valueReference": "#expansion-parameters"
  }],
  "url": "http://ecqi.healthit.gov/ecqms/Library/MPPManifest",
  "name": "MPPManifest",
  ...
}
```

> NOTE: May want to keep expansion parameters limited to only those parameters that would be supplied to the $expand operation, and provide a separate set of parameters for "resolutionParameters"?

> NOTE: May want to expand this beyond just version override to actual canonical reference override?

In this way, the measure specification itself can remain unchanged and computable descriptions of different attribution models can be provided.

### Terminology API Testing

### Artifact Manifest Testing

### Measure Narrative Review

## Authoring

To author content in this implementation guide, you can use the VS Code CQL Plugin. This plugin will enable you to author, validate, and execute FHIR-based eCQM content.

For instructions on setting up your environment to use the VS Code Plugin, see the [VS Code CQL Support Readme](https://github.com/cqframework/vscode-cql/blob/master/README.md)

Github Codespaces can also be used in this repository.

## Content Indexes

* [Libraries](https://build.fhir.org/ig/cqframework/ecqm-content-qicore-2023/libraries.html)
* [Measures](https://build.fhir.org/ig/cqframework/ecqm-content-qicore-2023/measures.html)
* [Artifact Summary](https://build.fhir.org/ig/cqframework/ecqm-content-qicore-2023/artifacts.html)

## Repository Structure

This repository is setup like any HL7 FHIR IG project but also includes the CQL files and test data which means the file structure will be as follows:

```
   |-- _genonce.bat
   |-- _genonce.sh
   |-- _refresh.bat
   |-- _refresh.sh
   |-- _updatePublisher.bat
   |-- _updatePublisher.sh
   |-- _updateCQFTooling.bat
   |-- _updateCQFTooling.sh
   |-- ig.ini
   |-- bundles
       |-- MAT
           |-- <bundle files>
       |-- measure
           |-- <bundles>
   |-- input
       |-- ecqm-content-qicore-2023.xml
       |-- cql
           |-- <library name>.cql
       |-- pagecontent
       |-- resources
           |-- library
               |-- <library name>.json
           |-- measure
               |-- <measure name>.json
       |-- tests
           |-- measure
               |-- <measure name>
                   |-- <test case patient id>
                       |-- <test case resource files>
                   |-- ...
       |-- vocabulary
           |-- valueset
```

## Extracting MAT Packages

The CQF Tooling provides support for extracting a MAT exported package into the
directories of this repository so that the measure is included in the published
implementation guide. To do this, place the MAT export files (unzipped) in a
directory in the `bundles\mat` directory, and then run the following tooling
command:

```
[tooling-jar] -ExtractMatBundle bundles\mat\[bundle-directory]\[bundle-file]
```

For example:

```
input-cache\tooling-cli-2.4.0.jar -ExtractMATBundle bundles\mat\CLONE124_v6_03-Artifacts\measure-json-bundle.json
```

## Refresh IG Processing

The CQF Tooling provides "refresh" tooling that performs the following functions:

* Translates and validates all CQL source files
* Packages CQL and ELM content in the corresponding FHIR resources
* Refreshes generated content for each knowledge artifact (Library, Measure, PlanDefinition, ActivityDefinition) including parameters, dependencies, and effective data requirements

Whenever changes are made to the CQL, Library, or Measure resources, run the `_refresh` command to refresh the implementation guide content with the new content, and then run `_genonce` to run the publication tooling on the implementation guide (the same process that the continuous integration build uses to publish the implementation guide when commits are made to this repository).

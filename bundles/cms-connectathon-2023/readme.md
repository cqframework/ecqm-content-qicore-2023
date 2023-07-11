## Setup

There is a [Postman Collection](CMS Connectathon 4.postman_collection.json) that contains each of the following steps as an API call.

The collection has a `serverEndpoint` variable that is initially set to the value of the connectathon sandbox:

```
https://cloud.alphora.com/sandbox/r4/cqm/fhir
```

If you have a local instance running, set the value of this variable to:

```
http://localhost:8080/fhir
```

## Scenario Steps

### Load Measure, Terminology, and Test Data

1. Post the [measures bundle](measures-bundle.json) to the Knowledge Repository: https://cloud.alphora.com/sandbox/r4/cqm/fhir
2. Post the [terminology bundle](terminology-bundle.json) to the Terminology Server: https://cloud.alphora.com/sandbox/r4/cqm/fhir
3. Post the [facility-a bundle](facility-a-bundle.json) to the Clinical Data Repository: https://cloud.alphora.com/sandbox/r4/cqm/fhir

### Get Data Requirements:

1. In the eCQM Testing Tool, select the Knowledge Repository Server
2. Select the date range (2022-01-01 - 2022-12-31)
3. Select the measure
4. Execute Get Data Requirements

```
GET https://cloud.alphora.com/sandbox/r4/cqm/fhir/Measure/DischargedonAntithromboticTherapyQICore4/$data-requirements
```

### Collect Data:

1. Select a data repository
2. Execute Collect Data

```
GET https://cloud.alphora.com/sandbox/r4/cqm/fhir/Measure/DischargedonAntithromboticTherapyQICore4/$collect-data?periodStart=2022-01-01&periodEnd=2022-12-31
```

### Submit Data:

1. Select a receiving system
2. Execute Submit Data

```
POST https://cloud.aphora.com/sandbox/r4/cqm/fhir/Measure/DischargedonAntithromboticTherapyQICore4/$submit-data

BODY: Output from the Collect Data operation
```

### Evaluate Measure:

1. Execute Evaluate Measure

Summary Report:

```
https://cloud.aphora.com/sandbox/r4/cqm/fhir/Measure/DischargedonAntithromboticTherapyQICore4/$evaluate-measure?periodStart=2022-01-01&periodEnd=2022-12-31
```

Individual Report:

```
https://cloud.aphora.com/sandbox/r4/cqm/fhir/Measure/DischargedonAntithromboticTherapyQICore4/$evaluate-measure?subject=in-numerator-0&periodStart=2022-01-01&periodEnd=2022-12-31
```

Subject-list Report

```
https://cloud.aphora.com/sandbox/r4/cqm/fhir/Measure/DischargedonAntithromboticTherapyQICore4/$evaluate-measure?periodStart=2022-01-01&periodEnd=2022-12-31&reportType=subject-list
```


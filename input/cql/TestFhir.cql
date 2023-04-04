library TestFhir

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.013'

context Patient

define "Date Filter Expression":
  [Condition] C
    where C.onset = Today()

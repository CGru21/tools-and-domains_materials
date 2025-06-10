#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["xmllint", "--xpath",  "//*[local-name()='protein']/@protein_name"]
label: protXml2IdList
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: pipelinecomponents/xmllint
    dockerOutputDirectory: /data
arguments:
- valueFrom: "| cut -d '|' -f2 > output_protxml2idlist.txt"
  position: 2
  shellQuote: false

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3434  # Conversion
  - http://edamontology.org/operation_0335  # Formatting

inputs:
  protXml2IdList_in_1:
    type: File
    format: edam:format_3747  # protXML
    edam:data_0006: edam:data_0945  # Peptide identification
    inputBinding:
      position: 1

outputs:
  protXml2IdList_out_1:
    type: File
    format: edam:format_2330  # Textual format
    edam:data_0006: edam:data_2872  # ID list
    outputBinding:
      glob: "output_protxml2idlist.txt"


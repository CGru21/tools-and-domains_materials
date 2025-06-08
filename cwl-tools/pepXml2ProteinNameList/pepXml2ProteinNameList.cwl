#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
baseCommand: ["xmllint", "--xpath",  "//*[local-name()='search_hit'][@hit_rank = '\"1\"']/@protein_descr"]
label: pepXml2ProteinNameList

requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: pipelinecomponents/xmllint
    dockerOutputDirectory: /data
arguments:
- valueFrom: "| cut -d '|' -f2 > output_pepXml2ProteinNameList.txt"
  position: 2
  shellQuote: false

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3434
  - http://edamontology.org/operation_0335

inputs:
  pepXml2ProteinNameList_in_1:
    type: File
    format: "http://edamontology.org/format_3747"  # protXML
    edam:data_0006: edam:data_0945  # Peptide identification
    inputBinding:
      position: 1

outputs:
  pepXml2ProteinNameList_out_1:
    type: File
    format: "http://edamontology.org/format_2330"  # Textual format
    edam:data_0006: edam:data_2872  # ID list
    outputBinding:
      glob: "output_pepXml2ProteinNameList.txt"


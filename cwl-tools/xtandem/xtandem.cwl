#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool
label: xtandem
baseCommand: ["mkdir", "-p", "/tmp/xtandem"]
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: spctools/tpp:version6.3.3
  InitialWorkDirRequirement:
    listing:
      - entryname: tandem.params
        entry: $(inputs.Params)
      - entryname: taxonomy.xml
        entry: $(inputs.Taxonomy)
      - entryname: mzmlFile.mzML
        entry: $(inputs.XTandem_in_1)
      - entryname: fastaFile.fasta
        entry: $(inputs.XTandem_in_2)
arguments:
    - valueFrom: >
        && cp tandem.params taxonomy.xml mzmlFile.mzML fastaFile.fasta /tmp/xtandem &&
        tandem /tmp/xtandem/tandem.params &&
        Tandem2XML /tmp/xtandem/tandemFile.tandem > mzmlFile.pep.xml
      position: 1
      shellQuote: false

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_3647  # Blind peptide database search
  - http://edamontology.org/operation_3767  # Protein identification
  - http://edamontology.org/operation_3645  # PTM identification
  - http://edamontology.org/operation_3631  # Peptide identification
  - http://edamontology.org/operation_3646  # Peptide database search
inputs:
  Params:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/docker/cwl/tools/xtandem/tandem.params
  Taxonomy:
    type: File
    default:
      class: File
      location: https://raw.githubusercontent.com/Workflomics/tools-and-domains/docker/cwl/tools/xtandem/taxonomy.xml
    
  XTandem_in_1:
    type: File
    format: edam:format_3244 # mzML
    edam:data_0006: edam:data_0943  # Mass spectrum
  XTandem_in_2:
    type: File
    format: edam:format_1929 # FASTA
    edam:data_0006: edam:data_2976  # Protein sequence

outputs:
  XTandem_out_1:
    type: File
    format: edam:format_3655 # pepXML
    edam:data_0006: edam:data_0945  # Peptide identification
    outputBinding:
      glob: "mzmlFile.pep.xml"
cwlVersion: v1.2
label: ms_amanda
class: CommandLineTool
baseCommand: ["/bin/bash", "-c"]
arguments:
  - valueFrom: >
      "/msamanda/MSAmanda -s $(inputs.MS_Amanda_in_1.path) \
      -d $(inputs.MS_Amanda_in_2.path) \
      -e $(inputs.Settings) \
      -f $(inputs.FileFormat) \
      -o $(inputs.OutputFile) && \
      gunzip output.mzid.gz"
    shellQuote: false
requirements:
  ShellCommandRequirement: {}
  DockerRequirement:
    dockerPull: workflomics/msamanda:latest
    dockerOutputDirectory: /data

$namespaces:
  edam: http://edamontology.org/

intent:
  - http://edamontology.org/operation_2945  # Analysis
  - http://edamontology.org/operation_3767  # Peptide identification
  - http://edamontology.org/operation_3645  # PTM identification
  - http://edamontology.org/operation_3755  # PTM localisation

inputs:
  MS_Amanda_in_1:
    type: File
    format: edam:format_3244 # mzML
    edam:data_0006: edam:data_0943  # Mass spectrum
    inputBinding:
      position: 1
      prefix: -s
  MS_Amanda_in_2:
    type: File
    format: edam:format_1929 # FASTA
    edam:data_0006: edam:data_2976  # Protein sequence
    inputBinding:
      position: 2
      prefix: -d
  Settings:
    type: string
    default: /msamanda/settings.xml
    inputBinding:
      position: 3
      prefix: -e
  FileFormat:
    type: int
    default: 2  # .mzid=2, .csv=1
    inputBinding:
      position: 4
      prefix: -f
  OutputFile:
    type: string
    default: "/data/output"
    inputBinding:
      position: 5
      prefix: -o

outputs:
  MS_Amanda_out_1:
    type: File
    format: edam:format_3247 # mzIdentML
    edam:data_0006: edam:data_0945  # Peptide identification
    outputBinding:
      glob: /data/output.mzid
